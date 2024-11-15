package project.Model;

import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class UserBean {
	private int id;
	private String name;
	private String gender;
	private String email;
	private String password;
	private String phone;
	private MultipartFile photoFile;
	private byte[] photoByte;
	public String get64() {
		if(photoByte!=null) {
			return Base64.getEncoder().encodeToString(photoByte);
		}else {
			return null;
		}
	}
}
