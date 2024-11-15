package project.Repository;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import project.Model.CategoryBean;

public class CategoryRepo {
	public int addCategory(CategoryBean category) {
        int i = 0;
        try (Connection con =  LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO category(name, image, status) VALUES (?, ?, 1)")) {
            ps.setString(1, category.getName());
            ps.setBytes(2, category.getPhotoByte());
            i = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Insert error: " + e.getMessage());
        }
        return i;
    }

    public List<CategoryBean> getAllCategories() {
        List<CategoryBean> categories = new ArrayList<>();
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM category WHERE status = 1");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CategoryBean category = new CategoryBean();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                Blob blob = rs.getBlob("image");
                if (blob != null) {
                    category.setPhotoByte(blob.getBytes(1, (int) blob.length()));
                }
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching categories: " + e.getMessage());
        }
        return categories;
    }

    public CategoryBean findById(int id) {
        CategoryBean category = null;
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM category WHERE id = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                category = new CategoryBean();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                Blob blob = rs.getBlob("image");
                if (blob != null) {
                    category.setPhotoByte(blob.getBytes(1, (int) blob.length()));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching category by id: " + e.getMessage());
        }
        return category;
    }

    public void updateCategory(CategoryBean category) {
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(
                 "UPDATE category SET name = ?, image = ? WHERE id = ?")) {
            
            ps.setString(1, category.getName());
            ps.setBytes(2, category.getPhotoByte());
            ps.setInt(3, category.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Updating category error: " + e.getMessage());
        }
    }

    public boolean categoryExistName(String categoryName) {
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("SELECT count(*) FROM category WHERE name = ? AND status = 1")) {
            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking existing category name: " + e.getMessage());
        }
        return false;
    }
    
    public List<CategoryBean> getDeletedCategories() {
        List<CategoryBean> categories = new ArrayList<>();
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM category WHERE status = 0");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CategoryBean category = new CategoryBean();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setPhotoByte(rs.getBytes("image"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching deleted categories: " + e.getMessage());
        }
        return categories;
    }

    
    public void softDeleteById(int id) {
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE category SET status = 0 WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error soft deleting category: " + e.getMessage());
        }
    }

    public void restoreById(int id) {
        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE category SET status = 1 WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error restoring category: " + e.getMessage());
        }
    }
    public int count() {
        int count = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM category WHERE status = 1");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting categories: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }
	
}
