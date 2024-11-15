package project.Model;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data

public class DetailBean {
	private int id;
	 @NotEmpty(message = "Unit cannot be empty")
	private String unit;
	 @Min(value = 0, message = "Price must be a positive value")
	private double price;
	 @Min(value = 1, message = "Quantity must be at least 1")
	private int perQuantity;
	private int status;
   private ProductBean product;
}
