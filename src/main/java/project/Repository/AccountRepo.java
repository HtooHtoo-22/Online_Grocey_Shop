package project.Repository;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import project.Model.UserBean;
import project.Service.BlankProfilePhoto;

public class AccountRepo {
	
	public int registerForUser(UserBean bean) throws IOException {
		int i=0;
		Connection cn=LinkConnection.linkConnection();
		String query="INSERT INTO mydb.user (name,email,password,phNo,gender,image) VALUES (?,?,?,?,?,?);";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, bean.getName());
			ps.setString(2, bean.getEmail());
			ps.setString(3, bean.getPassword());
			ps.setString(4, bean.getPhone());
			ps.setString(5, bean.getGender());
			ps.setBytes(6, bean.getPhotoByte());
			i=ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Registration Error "+e.getMessage());
		}
		return i;
	}
	public boolean checkUniqueEmail(String email) {
		boolean result=true;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT id FROM mydb.user WHERE email=? AND status=1;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				result=false;
			}
			query="SELECT * FROM mydb.admin WHERE email=? AND status=1;";
			ps=cn.prepareStatement(query);
			ps.setString(1, email);
			rs=ps.executeQuery();
			if(rs.next()) {
				result=false;
			}
		} catch (SQLException e) {
			System.out.println("GetAccountId "+e.getMessage());
		}
		return result;
	}
	public boolean checkUniquePhone(String phoneNumber) {
		boolean result=true;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT id FROM mydb.user WHERE phNo=? AND status=1;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, phoneNumber);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				result=false;
			}
		} catch (SQLException e) {
			System.out.println("Check Unique Phone Error  "+e.getMessage());
		}
		return result;
	}
	public boolean checkEmail(String email) {
		boolean result=false;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT id FROM mydb.user WHERE email=? AND status=1;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				result=true;
			}
			query="SELECT * FROM mydb.admin WHERE email=?;";
			ps=cn.prepareStatement(query);
			ps.setString(1, email);
			rs=ps.executeQuery();
			if(rs.next()) {
				result=true;
			}
			
		} catch (SQLException e) {
			System.out.println("GetAccountId "+e.getMessage());
		}
		return result;
	}
	public UserBean checkPassword(String email,String password) {
		UserBean bean=null;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT * FROM mydb.user WHERE email=? AND password=? AND status=1;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				bean=new UserBean();
				bean.setId(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setPassword(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setGender(rs.getString(8));
				Blob blob=rs.getBlob(6);
				bean.setPhotoByte(blob.getBytes(1, (int)blob.length()));			}
		} catch (SQLException e) {
			System.out.println("Checking Password Error "+e.getMessage());
		}
		return bean;
	}
	public String adminCheckPassword(String email,String password) {
		//boolean result=false;
		String adminRole=null;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT * FROM mydb.admin WHERE email=? AND password=? AND status=1;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				adminRole=rs.getString("role");
			}
		} catch (SQLException e) {
			System.out.println("Adimin Check Password Error "+e.getMessage());
		}
		return adminRole;
	}
	public String adminGetName(String email) {
		//boolean result=false;
		String adminName=null;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT * FROM mydb.admin WHERE email=? ;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				adminName=rs.getString("name");
			}
		} catch (SQLException e) {
			System.out.println("Adimin Check Password Error "+e.getMessage());
		}
		return adminName;
	}
	public int changeProfilePicture(byte[] photoByte,int id) {
		int i=0;
		Connection cn=LinkConnection.linkConnection();
		String query="UPDATE mydb.user SET image=? WHERE id=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setBytes(1, photoByte);
			ps.setInt(2, id);
			i=ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("ChangingProfile Error"+e.getMessage());
		}
		
		return i;
	}
	public int changeName(String name,int id) {
		int i=0;
		Connection cn=LinkConnection.linkConnection();
		String query="UPDATE mydb.user SET name=? WHERE id=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, name);
			ps.setInt(2, id);
			i=ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("ChangingName Error "+e.getMessage());
		}
		return i;
	}
	public int changePassword(String password,int id) {
		int i=0;
		Connection cn=LinkConnection.linkConnection();
		String query="UPDATE mydb.user SET password=? WHERE id=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, password);
			ps.setInt(2, id);
			i=ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("ChangingPassword Error "+e.getMessage());
		}
		return i;
	}
//	public UserBean getUserInfoById(int id) {
//		UserBean bean=null;
//		Connection cn=LinkConnection.linkConnection();
//		String query="SELECT * FROM mydb.user WHERE id=?;";
//		try {
//			PreparedStatement ps=cn.prepareStatement(query);
//			ps.setInt(1, id);
//			ResultSet rs=ps.executeQuery();
//			if(rs.next()) {
//				bean=new UserBean();
//				bean.setId(rs.getInt(1));
//				bean.setName(rs.getString(2));
//				bean.setEmail(rs.getString(3));
//				bean.setPassword(rs.getString(4));
//				bean.setPhone(rs.getString(5));
//				bean.setGender(rs.getString(8));
//				Blob blob=rs.getBlob(6);
//				bean.setPhotoByte(blob.getBytes(1, (int)blob.length()));
//			}
//		} catch (SQLException e) {
//			System.out.println("Get UserInfo By Id "+e.getMessage());
//		}
//		return bean;
//	}
}
