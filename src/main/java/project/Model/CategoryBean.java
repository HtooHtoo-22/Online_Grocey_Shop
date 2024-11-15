package project.Model;

import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class CategoryBean {
	private int id;
	private String name;
	private byte[] photoByte;
	private MultipartFile file;
	public String getBase64() {
		if(photoByte!=null) {
			return Base64.getEncoder().encodeToString(photoByte);
		}else {
			return null;
		}
	}
}
