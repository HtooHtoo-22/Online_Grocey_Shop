package project.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import project.Model.UserBean2;




public class UserRepository {
    
    // Method to get user by name
//    public UserBean getUserByName(String name) {
//        UserBean user = null;
//        String query = "SELECT * FROM user WHERE name = ?";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query)) {
//            
//            ps.setString(1, name);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                user = mapRowToUser(rs);
//            }
//        } catch (SQLException e) {
//            System.out.println("Error fetching user by name: " + e.getMessage());
//        }
//        return user;
//    } 
//    
//    // Method to get all active users
//    public List<UserBean> getAllUsers() {
//        List<UserBean> userList = new ArrayList<>();
//        String query = "SELECT * FROM user WHERE status = 1";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query);
//             ResultSet rs = ps.executeQuery()) {
//             
//            while (rs.next()) {
//                userList.add(mapRowToUser(rs));
//            }
//        } catch (SQLException e) {
//            System.out.println("No user data found: " + e.getMessage());
//        }
//        return userList;
//    }
//
//    // Method to update user
//    public void updateUser(UserBean user) {
//        String query = "UPDATE user SET name = ?, email = ?, phNo = ?, gender = ? WHERE id = ?";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query)) {
//             
//            ps.setString(1, user.getName());
//            ps.setString(2, user.getEmail());
//            ps.setString(3, user.getPhNo());
//            ps.setString(4, user.getGender());
//            ps.setInt(5, user.getId());
//            ps.executeUpdate();
//            System.out.println("Update successful");
//        } catch (SQLException e) {
//            System.out.println("Update error: " + e.getMessage());
//        }
//    }
//
//    // Method to delete user (soft delete)
//    public void deleteUser(int id) {
//        String query = "UPDATE user SET status = 0 WHERE id = ?";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query)) {
//             
//            ps.setInt(1, id);
//            ps.executeUpdate();
//            System.out.println("User deleted successfully");
//        } catch (SQLException e) {
//            System.out.println("Delete error: " + e.getMessage());
//        }
//    }
//
//    // Method to get user by ID
//    public UserBean getUserById(int id) {
//        UserBean user = null;
//        String query = "SELECT * FROM user WHERE id = ?";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query)) {
//             
//            ps.setInt(1, id);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                user = mapRowToUser(rs);
//            }
//        } catch (SQLException e) {
//            System.out.println("Error fetching user by ID: " + e.getMessage());
//        }
//        return user;
//    }
//
//    // Method to get all deleted users
//    public List<UserBean> getDeletedUsers() {
//        List<UserBean> deletedUsers = new ArrayList<>();
//        String query = "SELECT * FROM user WHERE status = 0";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query);
//             ResultSet rs = ps.executeQuery()) {
//             
//            while (rs.next()) {
//                deletedUsers.add(mapRowToUser(rs));
//            }
//        } catch (SQLException e) {
//            System.out.println("Error fetching deleted users: " + e.getMessage());
//        }
//        return deletedUsers;
//    }
//
//    // Method to restore a user
//    public void restoreUser(int id) {
//        String query = "UPDATE user SET status = 1 WHERE id = ?";
//        
//        try (Connection con = DBconnection.getConnection();
//             PreparedStatement ps = con.prepareStatement(query)) {
//             
//            ps.setInt(1, id);
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println("Restore user error: " + e.getMessage());
//        }
//    }
//
//    // Helper method to map ResultSet to UserBean
//    private UserBean mapRowToUser(ResultSet rs) throws SQLException {
//        UserBean user = new UserBean();
//        user.setId(rs.getInt("id"));
//        user.setName(rs.getString("name"));
//        user.setEmail(rs.getString("email"));
//        user.setPhNo(rs.getString("phNo"));
//        user.setGender(rs.getString("gender"));
//        user.setPassword(rs.getString("password")); // Include password if needed
//        return user;
//    }
    
    public int countActiveUsers() {
        int count = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM user WHERE status = 1");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting active users: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }
    private UserBean2 mapRowToUser(ResultSet rs) throws SQLException {
        UserBean2 user = new UserBean2();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhNo(rs.getString("phNo"));
        user.setGender(rs.getString("gender"));
        user.setPassword(rs.getString("password")); // Include password if needed
        return user;
    }
    public List<UserBean2> getAllUsers() {
        List<UserBean2> userList = new ArrayList<>();
        String query = "SELECT * FROM user WHERE status = 1";
        
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                userList.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            System.out.println("No user data found: " + e.getMessage());
        }
        return userList;
    }
    public UserBean2 getUserById(int id) {
        UserBean2 user = null;
        String query = "SELECT * FROM user WHERE id = ?";
        
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
             
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = mapRowToUser(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user by ID: " + e.getMessage());
        }
        return user;
    }
    public void updateUser(UserBean2 user) {
        String query = "UPDATE user SET name = ?, email = ?, phNo = ?, gender = ? WHERE id = ?";
        
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
             
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhNo());
            ps.setString(4, user.getGender());
            ps.setInt(5, user.getId());
            ps.executeUpdate();
            System.out.println("Update successful");
        } catch (SQLException e) {
            System.out.println("Update error: " + e.getMessage());
        }
    }
    public void deleteUser(int id) {
        String query = "UPDATE user SET status = 0 WHERE id = ?";
        
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
             
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("User deleted successfully");
        } catch (SQLException e) {
            System.out.println("Delete error: " + e.getMessage());
        }
    }
    public void restoreUser(int id) {
        String query = "UPDATE user SET status = 1 WHERE id = ?";
        
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
             
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Restore user error: " + e.getMessage());
        }
    }
    public List<UserBean2> getDeletedUsers() {
        List<UserBean2> deletedUsers = new ArrayList<>();
        String query = "SELECT * FROM user WHERE status = 0";
        
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                deletedUsers.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching deleted users: " + e.getMessage());
        }
        return deletedUsers;
    }

}
