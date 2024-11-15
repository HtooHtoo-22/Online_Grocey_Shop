package project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.stereotype.Repository;

import project.Model.OrderBean;
import project.Model.UserBean;

@Repository
public class OrderRepository {
	public int insertOrder(UserBean bean, OrderBean oBean,String orderNote) {
	    String sql = "INSERT INTO mydb.order (order_number, user_id, date, address,order_notes) VALUES (?, ?, ?, ?,?);";
	    Connection con = LinkConnection.linkConnection();
	    int generatedOrderId = -1;  // Variable to store the generated order_id (initialize with -1 for safety)
	    try {
	        // Prepare the statement with RETURN_GENERATED_KEYS to get the auto-generated order_id
	        PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
	        ps.setString(1, oBean.getOrderNumber());
	        ps.setInt(2, bean.getId());
	        ps.setTimestamp(3, new java.sql.Timestamp(System.currentTimeMillis()));
	        ps.setString(4, oBean.getAddress());
	        ps.setString(5, orderNote);

	        // Execute the prepared statement to insert the order
	        int rowsAffected = ps.executeUpdate();

	        if (rowsAffected > 0) {  // Check if the insert was successful
	            System.out.println("Insert Order successful.");

	            // Retrieve the generated order_id
	            try (ResultSet rs = ps.getGeneratedKeys()) {
	                if (rs.next()) {
	                    generatedOrderId = rs.getInt(1);  // The generated order_id from the database
	                    System.out.println("Generated order_id: " + generatedOrderId);
	                }
	            }
	        } else {
	            System.out.println("Insert Order failed, no rows affected.");
	        }

	    } catch (SQLException e) {
	        System.out.println("Insert Order error: " + e.getMessage());
	    }

	    return generatedOrderId;  // Return the generated order_id to be used later
	}

	
	public int insertOrderItem(OrderBean item, int orderId) {
	    String sql = "INSERT INTO `mydb`.`order_item` (`order_quantity`, `status`, `order_id`, `detail_id`, `total_price`) VALUES (?, ?, ?, ?, ?);";
	    Connection con = LinkConnection.linkConnection();
	    double totalprice = item.getQuantity() * item.getPrice();
	    int status = 1;
	    
	    // Variable to hold the generated key
	    int generatedKey = -1; 

	    try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) { // Specify to return generated keys
	        ps.setInt(1, item.getQuantity());
	        ps.setInt(2, status);
	        ps.setInt(3, orderId);
	        ps.setInt(4, item.getId());
	        ps.setDouble(5, totalprice);

	        ps.executeUpdate(); // Execute the insert query
	        
	        // Retrieve the generated key
	        try (ResultSet rs = ps.getGeneratedKeys()) {
	            if (rs.next()) {
	                generatedKey = rs.getInt(1); // Get the generated key (first column)
	            }
	        }

	        System.out.println("OrderRepository Success");
	        System.out.println("OrderId is: " + orderId);
	        System.out.println("Generated Order Item ID is: " + generatedKey); // Print the generated key
	    } catch (SQLException e) {
	        System.out.println("Insert Order Item Error: " + e.getMessage());
	    }

	    return generatedKey; // Return the generated key
	}

	
	public int insertPaymentTable(int orderId,int paymentMethodId,Double totalAmount,byte[] screenshot) {
		int i=0;
		String sql = "INSERT INTO payment (order_id,payment_method_id,amount,user_transaction) VALUES (?,?,?,?);";
	    Connection con = LinkConnection.linkConnection();
	    try {
			PreparedStatement ps=con.prepareStatement(sql);
			//ps.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
			ps.setInt(1, orderId);
			ps.setInt(2, paymentMethodId);
			ps.setDouble(3, totalAmount);
			ps.setBytes(4, screenshot);
			
			i=ps.executeUpdate();

		} catch (SQLException e) {
			System.out.println("Insert Payment Table Error "+e.getMessage());
		}
		return i;
	}
	
	public void substractProductQuantity(int orderItemId) {
		String sql = "SELECT order_quantity,detail.per_quantity,product.quantity,detail.unit,product.unit FROM order_item \r\n"
				+ "INNER JOIN detail ON order_item.detail_id=detail.id \r\n"
				+ "INNER JOIN product ON detail.product_id=product.id WHERE order_item.id=?;";
	    Connection con = LinkConnection.linkConnection();
	    double changeToGram=0;
	    double finalStockQuantity=0;
	    try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, orderItemId);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				int orderQuantity=rs.getInt(1);
				int perQuantity=rs.getInt(2);
				double stockQuantity=rs.getDouble(3);
				String detailUnit=rs.getString(4);
				String productUnit=rs.getString(5);
				if(detailUnit.equals("gram")&&productUnit.equals("kilogram")) {
					 
					  changeToGram=(double)perQuantity/1000;
					  finalStockQuantity=(double)stockQuantity-(changeToGram*orderQuantity);
					  System.out.println("Kilogram to gram "+finalStockQuantity);
				}else {
					 finalStockQuantity=(double)stockQuantity-(perQuantity*orderQuantity);
					 System.out.println("gram to gram "+finalStockQuantity);
				}
				
//				System.out.println("Stock Quantity "+stockQuantity);
//				System.out.println("PerQuantity "+perQuantity);
//				System.out.println("OrderQuantity "+orderQuantity);
				
				sql= "UPDATE product\r\n"
						+ "INNER JOIN detail ON product.id=detail.product_id\r\n"
						+ "INNER JOIN order_item ON order_item.detail_id=detail.id\r\n"
						+ " SET quantity=? \r\n"
						+ "WHERE order_item.id=?;";
				ps=con.prepareStatement(sql);
				ps.setDouble(1, finalStockQuantity);
				ps.setInt(2, orderItemId);
				ps.executeUpdate();
				
			}
		} catch (SQLException e) {
			System.out.println("Substract Product Quantity Error "+e.getMessage());
		}
	    
	}
	public void increasePopularity(int orderItemId) {
		Connection con = LinkConnection.linkConnection();
		String sql="SELECT product.popularity FROM order_item \r\n"
				+ "INNER JOIN detail ON order_item.detail_id=detail.id \r\n"
				+ "INNER JOIN product ON detail.product_id=product.id WHERE order_item.id=?;";	
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, orderItemId);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				int currentPopularity=rs.getInt(1);
				int updatePopularity=++currentPopularity;
				sql="UPDATE product\r\n"
						+ "INNER JOIN detail ON product.id=detail.product_id\r\n"
						+ "INNER JOIN order_item ON order_item.detail_id=detail.id\r\n"
						+ " SET popularity=? \r\n"
						+ "WHERE order_item.id=?;";
				ps=con.prepareStatement(sql);
				ps.setInt(1, updatePopularity);
				ps.setInt(2, orderItemId);
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("Increase Popularity Error "+e.getMessage());
		}
		
	}
	

}
