package project.Model;

import lombok.Data;

@Data
public class HistoryModelBoxBean {
    private String orderItem;
    private int orderQuantity;
    private double price;
    private double totalPrice; // For individual order item total from order_item table
    private double totalAmount; // For overall total from payment table (to be displayed outside the table)
    private int status;
    private String unit;
    private int perQuantity;
}