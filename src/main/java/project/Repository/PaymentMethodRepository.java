package project.Repository;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import project.Model.PaymentMethod;

@Repository
public class PaymentMethodRepository {
	
	 public int createPaymentMethod(PaymentMethod paymentMethod) {
	        int i = 0;
	        try (Connection con = LinkConnection.linkConnection();
	             PreparedStatement ps = con.prepareStatement("INSERT INTO payment_method(payment_method_name,qr_code,payment_logo,status)values(?,?,?,1)")) {
	            ps.setString(1, paymentMethod.getPayment_method_name());
	            ps.setBytes(2, paymentMethod.getQr_code());
	            ps.setBytes(3, paymentMethod.getLogo());
	            i = ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("Inserting paymentmethod error : " + e.getMessage());
	        }
	        return i;
	    }

	 public List<PaymentMethod> getAllPaymentMethod() {
		    List<PaymentMethod> paymentMethods = new ArrayList<>();
		    Connection con = LinkConnection.linkConnection();
		    try {
		        PreparedStatement ps = con.prepareStatement("SELECT * FROM payment_method WHERE status=1");
		        
		        ResultSet rs = ps.executeQuery();
		        while (rs.next()) {
		            PaymentMethod paymentMethod = new PaymentMethod();
		            paymentMethod.setId(rs.getInt("id"));
		            paymentMethod.setPayment_method_name(rs.getString("payment_method_name"));
		            paymentMethod.setQr_code(rs.getBytes("qr_code"));
		            paymentMethod.setLogo(rs.getBytes("payment_logo"));
		            paymentMethods.add(paymentMethod);
		        }
		    } catch (SQLException e) {
		        System.out.println("Error fetching payment methods: " + e.getMessage());
		    } finally {
		        try {
		            if (con != null) con.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		    return paymentMethods;
		}

	
	 public PaymentMethod getById(int id) {
		    PaymentMethod paymentMethod = null;
		    Connection con = LinkConnection.linkConnection();
		    try {
		        PreparedStatement ps = con.prepareStatement("SELECT * FROM payment_method WHERE id=?");
		        ps.setInt(1, id);
		        ResultSet rs = ps.executeQuery();
		        if (rs.next()) {
		            paymentMethod = new PaymentMethod();
		            paymentMethod.setId(rs.getInt("id"));
		            paymentMethod.setPayment_method_name(rs.getString("payment_method_name"));

		            // Handle QR Code
		            Blob blob = rs.getBlob("qr_code");
		            if (blob != null) {
		                paymentMethod.setQr_code(blob.getBytes(1, (int) blob.length()));
		            }

		            // Handle Logo
		            Blob blob1 = rs.getBlob("payment_logo");
		            if (blob1 != null) {
		                paymentMethod.setLogo(blob1.getBytes(1, (int) blob1.length()));
		            }
		        }
		    } catch (SQLException e) {
		        System.out.println("Error fetching payment method by id: " + e.getMessage());
		    } finally {
		        try {
		            if (con != null) con.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		    return paymentMethod;
		}

	
	public boolean paymentMethodExistName(String payment_method_name) {
		
		Connection con=LinkConnection.linkConnection();
		try {
			PreparedStatement ps=con.prepareStatement("SELECT COUNT(*) FROM payment_method WHERE payment_method_name = ? AND status=1");
			ps.setString(1, payment_method_name);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)>0;
			}
			
		} catch (SQLException e) {
			System.out.println("Error checking existing paymentMethodName :"+e.getMessage());
			
		}
		return false;
		
	}
	
	public void updatePaymentMethod(PaymentMethod paymentMethod) {
	    Connection con = LinkConnection.linkConnection();
	    try {
	        PreparedStatement ps = con.prepareStatement("UPDATE payment_method SET payment_method_name = ?, qr_code = ?, payment_logo = ?  WHERE id = ?");
	        ps.setString(1, paymentMethod.getPayment_method_name());
	        ps.setBytes(2, paymentMethod.getQr_code());
	        ps.setBytes(3, paymentMethod.getLogo());
	        ps.setInt(4, paymentMethod.getId());
	         ps.executeUpdate();
	    } catch (SQLException e) {
	        System.out.println("Updating payment method error: " + e.getMessage());
	    }
	}



	
	public void softDeleteById(int id) {
		Connection con=LinkConnection.linkConnection();
		try {
			PreparedStatement ps=con.prepareStatement("UPDATE payment_method SET status = 0 WHERE id = ?");
			ps.setInt(1, id);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("Deleting paymentmethod error :"+e.getMessage());
		}
	}
	 public void restoreById(int id) {
	        try (Connection con = LinkConnection.linkConnection();
	             PreparedStatement ps = con.prepareStatement("UPDATE payment_method SET status = 1 WHERE id = ?")) {
	            ps.setInt(1, id);
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("Error restoring category: " + e.getMessage());
	        }
	    }
	 
	 public List<PaymentMethod> getDeletedPaymentMethods() {
		    List<PaymentMethod> deletedPaymentMethods = new ArrayList<>();
		    String query = "SELECT * FROM payment_method WHERE status = 0";
		    
		    try (Connection con = LinkConnection.linkConnection();
		         PreparedStatement ps = con.prepareStatement(query);
		         ResultSet rs = ps.executeQuery()) {
		        
		        while (rs.next()) {
		            PaymentMethod paymentMethod = new PaymentMethod();
		            paymentMethod.setId(rs.getInt("id"));
		            paymentMethod.setPayment_method_name(rs.getString("payment_method_name"));
		            paymentMethod.setQr_code(rs.getBytes("qr_code"));
		            paymentMethod.setLogo(rs.getBytes("payment_logo"));
		            paymentMethod.setStatus(rs.getInt("status"));
		            deletedPaymentMethods.add(paymentMethod);
		        }
		    } catch (SQLException e) {
		        System.out.println("Error retrieving deleted payment methods: " + e.getMessage());
		    }
		    return deletedPaymentMethods;
		}


}
