package project.Model;

//import java.sql.Date;
import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductBean {
	private int id;
	private int productId;
	//private int detailId;
	private int categoryId;
	private String categoryName;
	private String productName;
	//private Date expDate;
	private String description;
	private byte[] productPhotoByte;
	private MultipartFile productPhotoFile;
	public String getBase64() {
		if(productPhotoByte!=null) {
			return Base64.getEncoder().encodeToString(productPhotoByte);
		}
		return null;
	}
	private String productUnit;
	private String unit;
	private double quantity;
	private double price;
	private int per_quantity;
	
	
	private int popularity;
	private CategoryBean category;
	
}
