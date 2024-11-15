package project.Repository;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.Model.CategoryBean;
import project.Model.ProductBean;

public class AdminProductRepo {
	public List<ProductBean> findByCategoryId(int categoryId) {
		ProductBean    product = null;
        List<ProductBean> products = new ArrayList<>();
        Connection con = LinkConnection.linkConnection();
        
        try {
            PreparedStatement ps = con.prepareStatement(
                "                SELECT p.id AS product_id, p.name AS product_name, p.image AS product_image, \r\n"
                + "                                p.popularity, p.description, p.quantity, c.id AS category_id, c.name AS category_name, c.image AS category_image \r\n"
                + "                                FROM product p \r\n"
                + "                                JOIN category c ON p.catagory_id = c.id \r\n"
                + "                                WHERE c.id = ? AND p.status = 1;");

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

           

            while (rs.next()) {
                    product = new ProductBean();
                    product.setId(rs.getInt("product_id"));
                    product.setProductName(rs.getString(2));

                    Blob productBlob = rs.getBlob("product_image");
                    if (productBlob != null) {
                        product.setProductPhotoByte(productBlob.getBytes(1, (int) productBlob.length()));
                    } else {
                        product.setProductPhotoByte(new byte[0]); 
                    }

                    product.setPopularity(rs.getInt("popularity"));
                    product.setDescription(rs.getString("description"));
                    product.setQuantity(rs.getInt("quantity"));

                    CategoryBean category = new CategoryBean();
                    category.setId(rs.getInt("category_id"));
                    category.setName(rs.getString("category_name"));
                    
                    Blob categoryBlob = rs.getBlob("category_image");
                    if (categoryBlob != null) {
                        category.setPhotoByte(categoryBlob.getBytes(1, (int) categoryBlob.length()));
                    }

                    product.setCategory(category);
                   products.add(product);
                   
                }
            if(!rs.next()) {
            	System.out.println("LEE BAL");
            }
        } catch (SQLException e) {
            System.out.println("Error fetching product by category id: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return products;
    }
}
