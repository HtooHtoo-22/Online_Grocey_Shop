package project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.Model.AdminBean;
import project.Model.CreateAdminBean;


public class AdminRepository {

    public int insertAdmin(AdminBean bean) {
        String sql = "INSERT INTO admin(name, email, password, role, gender, status) VALUES(?, ?, ?, ?, ?, 1)";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, bean.getName());
            ps.setString(2, bean.getEmail());
            ps.setString(3, bean.getPassword()); // Make sure to hash this password before storing
            ps.setString(4, bean.getRole());
            ps.setString(5, bean.getGender());
           

            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Insert error: " + e.getMessage());
            return 0;
        }
    }
    
    
    
    
  
    
    public boolean adminExistName(String adminName) {
    	Connection con=LinkConnection.linkConnection();
    	try {
			PreparedStatement ps=con.prepareStatement("SELECT count(*) FROM admin WHERE name = ? AND status = 1");
			ps.setString(1, adminName);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)>0;
			}
		} catch (SQLException e) {
			System.out.print("Error admin name exist :"+e.getMessage());
		}
		return false;
    }
    
//    public boolean checkEmail(String email) {
//        String sql = "SELECT * FROM admin WHERE email=?";
//        try (Connection con = LinkConnection.linkConnection();
//             PreparedStatement ps = con.prepareStatement(sql)) {
//             
//            ps.setString(1, email);
//            ResultSet rs = ps.executeQuery();
//            return rs.next(); 
//        } catch (SQLException e) {
//            System.out.println("Check email error: " + e.getMessage());
//            return false;
//        }
//    }
//
//    public AdminBean loginAdmin(LoginBean loginbean) {
//        String sql = "SELECT * FROM admin WHERE email=? AND password=?";
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(sql)) {
//
//            ps.setString(1, loginbean.getEmail());
//            ps.setString(2, loginbean.getPassword()); 
//
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                AdminBean admin = new AdminBean();
//                admin.setId(rs.getInt("id"));
//                admin.setName(rs.getString("name"));
//                admin.setRole(rs.getString("role"));
//                admin.setEmail(rs.getString("email"));
//                admin.setPassword(rs.getString("password"));
//                admin.setGender(rs.getString("gender"));
//                return admin;
//            }
//        } catch (SQLException e) {
//            System.out.println("Login admin error: " + e.getMessage());
//        }
//        return null;
//    }

    public AdminBean getAdminByName(String name) {
        String sql = "SELECT * FROM admin WHERE name=?";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                AdminBean admin = new AdminBean();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setRole(rs.getString("role"));
                admin.setEmail(rs.getString("email"));
                admin.setGender(rs.getString("gender"));
                return admin;
            }
        } catch (SQLException e) {
            System.out.println("Get admin by name error: " + e.getMessage());
        }
        return null;
    }

    public List<AdminBean> getAllAdmins() {
        List<AdminBean> admins = new ArrayList<>();
        String sql = "SELECT * FROM admin WHERE status = 1 AND role=\"Admin\";";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminBean admin = new AdminBean();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("role"));
                admin.setGender(rs.getString("gender"));
                admins.add(admin);
            }
        } catch (SQLException e) {
            System.out.println("Get admins error: " + e.getMessage());
        }
        return admins;
    }

    public AdminBean getAdminById(int id) {
        String sql = "SELECT * FROM admin WHERE id = ?";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                AdminBean admin = new AdminBean();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("role"));
                admin.setPassword(rs.getString("password")); // Consider not fetching this for security
                admin.setGender(rs.getString("gender"));
                return admin;
            }
        } catch (SQLException e) {
            System.out.println("Get admin by ID error: " + e.getMessage());
        }
        return null;
    }

    public void updateAdmin(AdminBean admin) {
        String sql = "UPDATE admin SET name = ?, email = ?, role = ?, gender = ? WHERE id = ?";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, admin.getName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getRole());
            ps.setString(4, admin.getGender());
            ps.setInt(5, admin.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Update admin error: " + e.getMessage());
        }
    }

    public void deleteAdmin(int id) {
        String sql = "UPDATE admin SET status = 0 WHERE id = ?";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Successfully deleted admin.");
        } catch (SQLException e) {
            System.out.println("Delete error: " + e.getMessage());
        }
    }

    public List<AdminBean> getDeletedAdmins() {
        List<AdminBean> deletedAdmins = new ArrayList<>();
        String sql = "SELECT * FROM admin WHERE status = 0";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminBean admin = new AdminBean();
                admin.setId(rs.getInt("id"));
                admin.setName(rs.getString("name"));
                admin.setRole(rs.getString("role"));
                admin.setEmail(rs.getString("email"));
                admin.setGender(rs.getString("gender"));
                deletedAdmins.add(admin);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching deleted admins: " + e.getMessage());
        }
        return deletedAdmins;
    }

    public void restoreAdmin(int id) {
        String sql = "UPDATE admin SET status = 1 WHERE id = ?";
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Successfully restored admin.");
        } catch (SQLException e) {
            System.out.println("Restore error: " + e.getMessage());
        }
    }
    public int saveAdmin(CreateAdminBean bean) {
        int i = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("INSERT INTO mydb.admin(name, email, password, gender,  status) VALUES(?, ?, ?, ?,  1)");
            ps.setString(1, bean.getName());
            ps.setString(2, bean.getEmail());
            ps.setString(3, bean.getPassword());
            
            ps.setString(4, bean.getGender());
            i = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Insert error: " + e.getMessage());
        }
        return i;
    }
    public boolean checkUserUniqueEmail(String email) {
		boolean result=true;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT id FROM mydb.user WHERE email=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				result=false;
			}
			query="SELECT * FROM mydb.admin WHERE email=?;";
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
    public boolean checkAdminUniqueEmail(String email) {
		boolean result=true;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT id FROM mydb.admin WHERE email=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				result=false;
			}
			query="SELECT * FROM mydb.admin WHERE email=?;";
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
  
    public boolean checkUniqueName(String name) {
		boolean result=true;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT id FROM mydb.admin WHERE name=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, name);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				result=false;
			}
		} catch (SQLException e) {
			System.out.println("Check Unique Name Error  "+e.getMessage());
		}
		return result;
	}
}
