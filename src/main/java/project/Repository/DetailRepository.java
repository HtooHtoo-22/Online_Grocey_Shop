package project.Repository;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;

import project.Model.DetailBean;
import project.Model.ProductBean;



@Repository
public class DetailRepository {
	public int createDetail(DetailBean detail) {
	        int result = 0;
	        try (Connection con =LinkConnection.linkConnection();) {
	            PreparedStatement ps = con.prepareStatement("INSERT INTO detail(unit, price, per_quantity,  product_id) VALUES (?, ?, ?,  ?)");
//	            if(detail.getUnit().equals("kg")||detail.getUnit().equals("KG")||detail.getUnit().equals("kG")||detail.getUnit().equals("Kg")) {
//	            	 ps.setString(1, "kilogram");
//	            }else if(detail.getUnit().equals("g")||detail.getUnit().equals("G")) {
//	            	ps.setString(1, "gram");
//	            }else {
//	            	ps.setString(1, detail.getUnit());
//	            }
	            ps.setString(1, detail.getUnit());
	            ps.setDouble(2, detail.getPrice());
	            ps.setInt(3, detail.getPerQuantity());
	            ps.setInt(4, detail.getProduct().getId());
	            result = ps.executeUpdate();
	        } catch (SQLException e) {
	            System.err.println("Inserting detail error: " + e.getMessage());
	        }
	        return result;
	    
	}
//
	public List<DetailBean> findByProductId(int prodouctId){
		List<DetailBean> details=new ArrayList<>();
		Connection con=LinkConnection.linkConnection();
		try {
			PreparedStatement ps=con.prepareStatement("SELECT d.id AS detail_id,d.unit AS detail_unit,d.price AS detail_price,d.per_quantity AS detail_per_quantity,\n"
														+ "p.id AS product_id ,p.name as product_name,p.image AS product_image,p.description AS product_description\n"
														+ "FROM detail d JOIN product p ON d.product_id=p.id WHERE p.id=? AND d.status=1");
			
			ps.setInt(1, prodouctId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				
				DetailBean detail=new DetailBean();
				detail.setId(rs.getInt("detail_id"));
				detail.setUnit(rs.getString("detail_unit"));
				detail.setPrice(rs.getDouble("detail_price"));
				detail.setPerQuantity(rs.getInt("detail_per_quantity"));
				
				ProductBean    product = new ProductBean();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));

                Blob productBlob = rs.getBlob("product_image");
                if (productBlob != null) {
                    product.setProductPhotoByte(productBlob.getBytes(1, (int) productBlob.length()));
                } else {
                    product.setProductPhotoByte(new byte[0]); 
                }

                product.setDescription(rs.getString("product_description"));
                
                detail.setProduct(product);
                details.add(detail);
			}
			
			
			
		} catch (SQLException e) {
			System.out.println("Error fetching details with product :"+e.getMessage());
		}
		
		
		
		return details;
	}
//	
	public DetailBean findByDetailId(int id) {
		
		DetailBean detail=null;
		
		Connection con=LinkConnection.linkConnection();
		try {
			PreparedStatement ps=con.prepareStatement("SELECT d.id AS detail_id,d.unit AS detail_unit,d.price AS detail_price,d.per_quantity AS detail_per_quantity,\n"
					+ "p.id AS product_id ,p.name as product_name,p.image AS product_image,p.description AS product_description\n"
					+ "FROM detail d JOIN product p ON d.product_id=p.id WHERE d.id=?");
			ps.setInt(1, id);
			
			ResultSet rs=ps.executeQuery();
			
			while(rs.next()) {
				
				 detail=new DetailBean();
				detail.setId(rs.getInt("detail_id"));
				detail.setUnit(rs.getString("detail_unit"));
				detail.setPrice(rs.getDouble("detail_price"));
				detail.setPerQuantity(rs.getInt("detail_per_quantity"));
				
				ProductBean    product = new ProductBean();
                product.setId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));

                Blob productBlob = rs.getBlob("product_image");
                if (productBlob != null) {
                    product.setProductPhotoByte(productBlob.getBytes(1, (int) productBlob.length()));
                } else {
                    product.setProductPhotoByte(new byte[0]); 
                }

                product.setDescription(rs.getString("product_description"));
                detail.setProduct(product);
				
			}
			
			
		} catch (SQLException e) {
			System.out.println("Error fetching detail by id :"+e.getMessage());
		}
		
		return detail;
		
		
	}
//	
//	
	public void updateDetails(int id, DetailBean newDetail) {
	    Connection con = null;
	    PreparedStatement ps = null;
	    PreparedStatement ups = null;

	    try {
	        con = LinkConnection.linkConnection();
	        con.setAutoCommit(false); // Start transaction

	        
	        ps = con.prepareStatement("UPDATE detail SET status = 0 WHERE id = ?");
	        ps.setInt(1, id);
	        ps.executeUpdate();

	        
	        ups = con.prepareStatement("INSERT INTO detail(unit, price, per_quantity, status, product_id) VALUES (?, ?, ?, 1, ?)");
	        ups.setString(1, newDetail.getUnit());
	        ups.setDouble(2, newDetail.getPrice());
	        ups.setInt(3, newDetail.getPerQuantity());
	        ups.setInt(4, newDetail.getProduct().getId());
	        ups.executeUpdate();

	        con.commit(); 
	    } catch (SQLException e) {
	        System.out.println("Updating detail error: " + e.getMessage());
	        if (con != null) {
	            try {
	                con.rollback();
	            } catch (SQLException rollbackEx) {
	                System.out.println("Rollback error: " + rollbackEx.getMessage());
	            }
	        }
	    } finally {
	        try {
	            if (ups != null) ups.close();
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            System.out.println("Closing resources error: " + e.getMessage());
	        }
	    }
	}
	
	public List<DetailBean> getAllHistoryDetails(int prodouctId){
		List<DetailBean> historyDetails=new ArrayList<>();
		Connection con=LinkConnection.linkConnection();
		try {
			PreparedStatement ps=con.prepareStatement("SELECT d.id AS detail_id,d.unit AS detail_unit,d.price AS detail_price,d.per_quantity AS detail_per_quantity,\n"
														+ "p.id AS product_id ,p.name as product_name,p.image AS product_image,p.description AS product_description\n"
														+ "FROM detail d JOIN product p ON d.product_id=p.id WHERE p.id=? AND d.status=0");
			
			ps.setInt(1, prodouctId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				
				DetailBean detail=new DetailBean();
				detail.setId(rs.getInt("detail_id"));
				detail.setUnit(rs.getString("detail_unit"));
				detail.setPrice(rs.getDouble("detail_price"));
				detail.setPerQuantity(rs.getInt("detail_per_quantity"));
				
				ProductBean    product = new ProductBean();
                product.setId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));

                Blob productBlob = rs.getBlob("product_image");
                if (productBlob != null) {
                    product.setProductPhotoByte(productBlob.getBytes(1, (int) productBlob.length()));
                } else {
                    product.setProductPhotoByte(new byte[0]); 
                }

                product.setDescription(rs.getString("product_description"));
                
                detail.setProduct(product);
                historyDetails.add(detail);
			}
			
			
			
		} catch (SQLException e) {
			System.out.println("Error fetching details with product :"+e.getMessage());
		}
		
		
		
		return historyDetails;
	}
	
	public int deleteDetail(int detailId) {
		int i=0;
		Connection con=LinkConnection.linkConnection();
		String query="DELETE FROM detail\n"
				+ "WHERE id=?;";
		try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, detailId);
			i=ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("DeleteDetail Error "+e.getMessage());
		}
		return i;
	}
	
	public boolean DetailExistUnit(String detailUnit,int productId) {
	     String query = "SELECT COUNT(*)  FROM detail\n"
	     		+ "INNER JOIN product ON product.id=detail.product_id\n"
	     		+ " WHERE detail.unit=? AND  product.id=?;";
	     try (Connection con = LinkConnection.linkConnection();
	          PreparedStatement ps = con.prepareStatement(query)) {
	          
	         ps.setString(1, detailUnit);
	         ps.setInt(2, productId);
	         try (ResultSet rs = ps.executeQuery()) {
	             if (rs.next()) {
	                 return (rs.getInt(1) > 0);
	             }
	         }
	     } catch (SQLException e) {
	         System.out.println("Error checking detail with this unit existence: " + e.getMessage());
	     }
	     return false;
	 }
	 
	 public boolean DetailExistPerQuantity(int perQuantity,int productId) {
	     String query = "SELECT COUNT(*)  FROM detail\n"
	     		+ "INNER JOIN product ON product.id=detail.product_id\n"
	     		+ " WHERE per_quantity=? AND  product.id=?;";
	     try (Connection con = LinkConnection.linkConnection();
	          PreparedStatement ps = con.prepareStatement(query)) {
	          
	         ps.setInt(1, perQuantity);
	         ps.setInt(2, productId);
	        
	         try (ResultSet rs = ps.executeQuery()) {
	             if (rs.next()) {
	                 return (rs.getInt(1) > 0);
	             }
	         }
	     } catch (SQLException e) {
	         System.out.println("Error checking detail with this perQuantity existence: " + e.getMessage());
	     }
	     return false;
	 }
	 public String getProductNameByProductId(int productId) {
		 String productName=null;
		 Connection con=LinkConnection.linkConnection();
		 String query="SELECT * FROM mydb.product WHERE id=?;";
		 try {
			PreparedStatement ps=con.prepareStatement(query);
			ps.setInt(1, productId);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				productName=rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("Get Product Name By ProductId "+e.getMessage());
		}
		 return productName;
		 
	 }
	 
}

