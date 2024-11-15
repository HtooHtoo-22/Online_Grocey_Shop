package project.Model;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;

import lombok.Data;

@Data
public class Payment {

	private int id;
	private int orderId;
	private double amount;
	private String paymentdate;
	private int status;
	private String orderNumber;
	private String userAddress;
	private String userName;
	private String userEmail;
	private String phNo;
	private String gender;
	private String paymentMethodName;
	private String productName;
	private int orderQuantity;
	private String orderNote;
	private String orderDate;
	private Double price;
	private Double totalPrice;
	private List<Payment> orderItems;
	private byte[]userTransaction;
	
	 public String getBase64() {
	        if(userTransaction != null) {
	          return Base64.getEncoder().encodeToString(userTransaction);
	          } else {
	              return null;
	          }
	      }
	
	 private String unit;
	  private int perQuantity;
	  private int detailId;
	
}

