package project.Model;

import lombok.Data;

import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

@Data
public class PaymentMethod {
    private int id;
    private String payment_method_name;
    private byte[] qr_code;
    private MultipartFile file;
    private int status;
    private byte[]logo;
    private MultipartFile logoFile;
    
    public String getBase64() {
    	
    	if(qr_code != null) {
    		return Base64.getEncoder().encodeToString(qr_code);
        } else {
            return null;
        }
    }
    
    public String logoGetBase64() {
        if(logo != null) {
          return Base64.getEncoder().encodeToString(logo);
          } else {
              return null;
          }
      }

}

