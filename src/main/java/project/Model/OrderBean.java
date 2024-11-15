package project.Model;

import lombok.Data;

@Data
public class OrderBean {
	// product fields
    private int id;
    private int price;
    private int quantity;

    // Address fields
    private String address;

    // Order-specific fields
    private String orderNumber;
    private String orderNote;
}
