package project.Model;

import lombok.Data;

@Data
public class CreateAdminBean {
	private int id;
	  private String name;
	  private String email;
	  private String password;
	  private String role;
	  private String gender;
}
