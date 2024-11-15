package project.Repository;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import project.Model.Payment;



@Repository
public class PaymentRepository {
	
	public List<Payment> getAllOrdersByStatus() {
	    List<Payment> orders = new ArrayList<>();
	    String qry = "SELECT \r\n"
	    		+ "	                payment.id AS payment_id, \r\n"
	    		+ "	    		\r\n"
	    		+ "	                `order`.id AS order_id,\r\n"
	    		+ "	                `order`.order_number AS order_number, \r\n"
	    		+ "	                `order`.address AS order_address, \r\n"
	    		+ "	                `order`.date AS date, \r\n"
	    		+ "                     `order`.order_notes AS order_notes, \r\n"
	    		+ "	                user.name AS user_name, \r\n"
	    		+ "	                user.email AS user_email, \r\n"
	    		+ "	                user.phNo AS user_phNo, \r\n"
	    		+ "	                user.gender AS user_gender, \r\n"
	    		+ "	                payment_method.payment_method_name, \r\n"
	    		+ "	                payment.payment_date, \r\n"
	    		+ "	                payment.amount AS payment_amount, \r\n"
	    		+ "	                payment.status AS payment_status, \r\n"
	    		+ "	                payment.user_transaction AS payment_user_transaction \r\n"
	    		+ "	            FROM \r\n"
	    		+ "	                payment \r\n"
	    		+ "	            JOIN\r\n"
	    		+ "	                payment_method ON payment.payment_method_id = payment_method.id \r\n"
	    		+ "	            JOIN \r\n"
	    		+ "	                `order` ON payment.order_id = `order`.id \r\n"
	    		+ "	            JOIN \r\n"
	    		+ "	                user ON `order`.user_id = user.id \r\n"
	    		+ "	            ORDER BY \r\n"
	    		+ "	                CASE payment.status \r\n"
	    		+ "	                    WHEN 1 THEN 0  \r\n"
	    		+ "	                    WHEN 2 THEN 1  \r\n"
	    		+ "	                    WHEN 0 THEN 2 \r\n"
	    		+ "	                END, \r\n"
	    		+ "	                payment.payment_date DESC"; 

	    try (Connection con = LinkConnection.linkConnection();
	         PreparedStatement ps = con.prepareStatement(qry);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Payment order = new Payment();
	            order.setId(rs.getInt("payment_id"));
	            order.setOrderId(rs.getInt("order_id"));
	            order.setOrderNumber(rs.getString("order_number"));
	            order.setUserAddress(rs.getString("order_address"));
	            
	            
	            
	            Timestamp paymentDateTimestamp = rs.getTimestamp("date");
                
                // Convert it to LocalDateTime
                LocalDateTime paymentDate = paymentDateTimestamp.toLocalDateTime();

                // Define the desired format
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy, h:mm a");

                // Format the LocalDateTime to a String
                String formattedOrderDate = paymentDate.format(formatter);
                
                // Set the formatted date to your order object
                order.setOrderDate(formattedOrderDate);
                
	            
	            
	            
	            order.setUserName(rs.getString("user_name"));
	            order.setUserEmail(rs.getString("user_email"));
	            order.setPhNo(rs.getString("user_phNo"));
	            order.setGender(rs.getString("user_gender"));
	            order.setPaymentMethodName(rs.getString("payment_method_name"));
	            order.setOrderNote(rs.getString("order_notes"));;
	            if (rs.getTimestamp("payment.payment_date") != null) {
	            	 Timestamp paymentDateTimestamp1 = rs.getTimestamp("payment.payment_date");
	                 
	                 // Convert it to LocalDateTime
	                 LocalDateTime paymentDate1 = paymentDateTimestamp1.toLocalDateTime();

	                 // Define the desired format
	                 DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("MMMM d, yyyy, h:mm a");

	                 // Format the LocalDateTime to a String
	                 String formattedPaymentDate = paymentDate1.format(formatter1);
	                 
	                 // Set the formatted date to your order object
	                 order.setPaymentdate(formattedPaymentDate);
	            }
	            
	            order.setAmount(rs.getDouble("payment_amount"));
	            order.setStatus(rs.getInt("payment_status"));
	            order.setUserTransaction(rs.getBytes("payment_user_transaction"));
	            orders.add(order);
	            System.out.println("Order ID: " + order.getId() + ", Status: " + order.getStatus());
	        }

	        // Sort the orders by orderId from largest to smallest
	        orders.sort((o1, o2) -> Integer.compare(o2.getOrderId(), o1.getOrderId()));

	    } catch (SQLException e) {
	        System.err.println("Error fetching orders: " + e.getMessage());
	    }
	    return orders;
	}

	public Map<String, List<Payment>> getAllOrdersGroupedByStatus() {
	    List<Payment> allOrders = getAllOrdersByStatus(); 
	    Map<String, List<Payment>> groupedOrders = new HashMap<>();

	    groupedOrders.put("Pending", new ArrayList<>());
	    groupedOrders.put("Approved", new ArrayList<>());
	    groupedOrders.put("Canceled", new ArrayList<>());

	    for (Payment order : allOrders) {
	        switch (order.getStatus()) {
	            case 1:
	                groupedOrders.get("Pending").add(order);
	                break;
	            case 2:
	                groupedOrders.get("Approved").add(order);
	                break;
	            case 0:
	                groupedOrders.get("Canceled").add(order);
	                break;
	        }
	    }
	    return groupedOrders;
	}


    
    
    public Payment getAllOrdersById(int id) {
       Payment order=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String qry = "SELECT " +
                     "    payment.id AS payment_id, " +
                     "    `order`.id AS order_id, " +
                     "    `order`.order_number AS order_number, " +
                     "    `order`.address AS order_address, " +
                     "    `order`.date AS date, " +
                     "    user.name AS user_name, " +
                     "    user.email AS user_email, " +
                     "    user.phNo AS user_phNo, " +
                     "    user.gender AS user_gender, " +
                     "    payment_method.payment_method_name, " +
                     "    payment.payment_date, " +
                     "    payment.amount AS payment_amount, " +
                     "    payment.user_transaction AS payment_user_transaction " +
                     "FROM " +
                     "    payment " +
                     "JOIN " +
                     "    payment_method ON payment.payment_method_id = payment_method.id " +
                     "JOIN " +
                     "    `order` ON payment.order_id = `order`.id " +
                     "JOIN " +
                     "    user ON `order`.user_id = user.id " +
                     "WHERE payment.id=? "+
                     "ORDER BY payment.payment_date";

        try {
            con = LinkConnection.linkConnection();
            ps = con.prepareStatement(qry);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                 order = new Payment();
                order.setId(rs.getInt("payment_id"));
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderNumber(rs.getString("order_number"));
                order.setUserAddress(rs.getString("order_address"));
                Timestamp orderTimeStamp = rs.getTimestamp("date");
                LocalDateTime orderDateTime = orderTimeStamp != null ? orderTimeStamp.toLocalDateTime() : null;

	            Timestamp paymentDateTimestamp = rs.getTimestamp("date");
                
                // Convert it to LocalDateTime
                LocalDateTime paymentDate = paymentDateTimestamp.toLocalDateTime();

                // Define the desired format
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy, h:mm a");

                // Format the LocalDateTime to a String
                String formattedOrderDate = paymentDate.format(formatter);
                
                // Set the formatted date to your order object
                order.setOrderDate(formattedOrderDate);
                
                order.setUserName(rs.getString("user_name"));
                order.setUserEmail(rs.getString("user_email"));
                order.setPhNo(rs.getString("user_phNo"));
                order.setGender(rs.getString("user_gender"));
                order.setPaymentMethodName(rs.getString("payment_method_name"));
                
                
                
                // Convert it to LocalDateTime
                if (rs.getTimestamp("payment.payment_date") != null) {
                	Timestamp paymentDateTimestamp1 = rs.getTimestamp("payment.payment_date");
                	LocalDateTime paymentDate1 = paymentDateTimestamp1.toLocalDateTime();
                	 DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("MMMM d, yyyy, h:mm a");
                	 String formattedPaymentDate = paymentDate1.format(formatter1);
                     
                     // Set the formatted date to your order object
                     order.setPaymentdate(formattedPaymentDate);
                }
                

                // Define the desired format
               

                // Format the LocalDateTime to a String
               
                order.setAmount(rs.getDouble("payment_amount"));
                Blob blob = rs.getBlob("payment_user_transaction");
	            if (blob != null) {
	                order.setUserTransaction(blob.getBytes(1, (int) blob.length()));
	            }

	             List<Payment> orderItems = getAllOrderItems(order.getOrderId());
	             order.setOrderItems(orderItems);
               
            }
        } catch (SQLException e) {
            System.out.println("Error fetching get all orders: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
        return order;
    }
    
    public List<Payment> getAllOrderItems(int orderId) {
        List<Payment> orderItems = new ArrayList<>();
        Connection con = LinkConnection.linkConnection();
        String qry = "SELECT \r\n"
        		+ "    order_item.order_quantity AS order_item_order_quantity, \r\n"
        		+ "    order_item.total_price AS order_item_order_total_price, \r\n"
        		+ "    product.name AS product_name, \r\n"
        		+ "    detail.price AS detail_price,\r\n"
        		+ "    detail.per_quantity AS detail_perquantity,\r\n"
        		+ "    detail.unit AS detail_unit\r\n"
        		+ "FROM \r\n"
        		+ "    order_item\r\n"
        		+ "JOIN \r\n"
        		+ "    `order` ON order_item.order_id = `order`.id\r\n"
        		+ "JOIN \r\n"
        		+ "    detail ON order_item.detail_id = detail.id\r\n"
        		+ "JOIN \r\n"
        		+ "    product ON detail.product_id = product.id\r\n"
        		+ "WHERE \r\n"
        		+ "    order_item.order_id = ?;";

   try {
       PreparedStatement ps = con.prepareStatement(qry);
       ps.setInt(1, orderId); // Set the orderId parameter
       ResultSet rs = ps.executeQuery();

       while (rs.next()) {
           Payment orderItem = new Payment();
          // orderItem.setOrderNote(rs.getString("order_item_order_notes"));
           orderItem.setOrderQuantity(rs.getInt("order_item_order_quantity"));
           orderItem.setTotalPrice(rs.getDouble("order_item_order_total_price"));
           orderItem.setProductName(rs.getString("product_name"));
           orderItem.setPrice(rs.getDouble("detail_price"));
           orderItem.setOrderId(orderId);
           orderItem.setUnit(rs.getString("detail_unit"));
           orderItem.setPerQuantity(rs.getInt("detail_perquantity"));
           orderItems.add(orderItem);
       }
       System.out.println("Order Items: " + orderItems.size()); 
   } catch (SQLException e) {
       e.printStackTrace();
   }

   return orderItems;
}
  
    
    public void updateOrders(Payment payment) {
    	Connection con=LinkConnection.linkConnection();
    	try {
			PreparedStatement ps=con.prepareStatement("UPDATE `order` SET address=? WHERE id=? ");
			
			ps.setString(1, payment.getUserAddress());
			ps.setInt(2, payment.getOrderId());
			ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Updating order error :"+e.getMessage());
		}
    }
    
   
    
    public void softDeleteById(int id) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = LinkConnection.linkConnection();
            ps = con.prepareStatement("UPDATE payment SET status=0 WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Soft deleting order error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
 
    public void approvedOrderByid(int id) {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = LinkConnection.linkConnection();
            ps = con.prepareStatement("UPDATE payment SET status=2, payment_date=? WHERE id=?");
            ps.setTimestamp(1, new java.sql.Timestamp(System.currentTimeMillis()));
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Soft deleting order error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }
    
    
    public int count() {
        int count = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM payment WHERE status = 2");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting orders: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }
    public Map<String, Double> getSalesDataByWeekday() {
        Map<String, Double> salesData = new HashMap<>();
        String qry = "SELECT DAYNAME(payment.payment_date) AS weekday, SUM(payment.amount) AS total_sales " +
                     "FROM payment " +
                     "WHERE payment.status = 2 " + 
                     "GROUP BY weekday " +
                     "ORDER BY FIELD(weekday, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')";

        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(qry);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String weekday = rs.getString("weekday");
                double totalSales = rs.getDouble("total_sales");
                salesData.put(weekday, totalSales);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching sales data: " + e.getMessage());
        }
        return salesData;
    }
    public void substractQuantityAndIncreasePopularity(int paymentId) {
    	Connection con = LinkConnection.linkConnection();
    	String query="SELECT order_item.id \r\n"
    			+ "FROM payment \r\n"
    			+ "INNER JOIN `order` ON payment.order_id = `order`.id\r\n"
    			+ "INNER JOIN order_item ON `order`.id = order_item.order_id WHERE payment.id=?;";
    	OrderRepository orderRepository=new OrderRepository();
    	try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, paymentId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				int orderItemId=rs.getInt(1);
				orderRepository.substractProductQuantity(orderItemId);
				orderRepository.increasePopularity(orderItemId);
			}
		} catch (SQLException e) {
			System.out.println("Substract Quantity ERror "+e.getMessage());
		}
    }
    public int deletePayment(int paymentId) {
    	Connection con = LinkConnection.linkConnection();
    	int i=0;
    	String query="";
    	try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, paymentId);
			ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Delete Payment Error "+e.getMessage());
		}
    	return i;
    }
    public int deletingOrders(Payment order) {
    	  int i=0;
    	  Connection con=LinkConnection.linkConnection();
    	  try {
    	   PreparedStatement ps=con.prepareStatement("DELETE FROM payment WHERE id=?");
    	   ps.setInt(1, order.getId());
    	   i=ps.executeUpdate();
    	  } catch (SQLException e) {
    	   System.out.print("Deleting order completely error :"+e.getMessage());
    	  }
    	  return i;
    	 }
    public int pendingCount() {
        int count = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM payment WHERE status = 1;");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
                System.out.println("PP"+count);
            }else {
            	System.out.println("No");
            }
        } catch (SQLException e) {
            System.out.println("Error pended counting orders: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }
}
