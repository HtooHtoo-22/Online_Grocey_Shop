package project.Model;

import java.util.Base64;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OrderRequestDTO {
	
	private List<OrderBean> cartItems;
    private OrderBean address;
    private String orderNote;
    private int paymentId;
    private Double totalAmount;
    private byte[] screenshot;          // Screenshot in byte array format
    private String base64Screenshot; 
    
    public void decodeBase64Screenshot() {
        if (this.base64Screenshot != null) {
            this.screenshot = java.util.Base64.getDecoder().decode(this.base64Screenshot);
        }
    }
}
