package project.Repository;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


import project.Model.CategoryBean;
import project.Model.ProductBean;

@Repository
public class ProductRepository {

	
    public int createProduct(ProductBean product) {
        int i = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO product(name, catagory_id, image,  description, quantity, unit) VALUES(?, ?, ?, ?, ?, ?)");
            ps.setString(1, product.getProductName());
            ps.setInt(2, product.getCategory().getId());
            ps.setBytes(3, product.getProductPhotoByte());
            
            ps.setString(4, product.getDescription());
            ps.setDouble(5, product.getQuantity());
            ps.setString(6, product.getProductUnit());

            i = ps.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println("Inserting product: " + e.getMessage());
            
        }
        return i;
    }

    public List<ProductBean> findByCategoryId(int categoryId) {
        List<ProductBean> products = new ArrayList<>();
        Connection con = LinkConnection.linkConnection();
        
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT p.unit AS product_unit ,p.id AS product_id, p.name AS product_name, p.image AS product_image, \n"
                + "                p.popularity, p.description, p.quantity, c.id AS category_id, c.name AS category_name, c.image AS category_image \n"
                + "                FROM product p \n"
                + "                JOIN category c ON p.catagory_id = c.id \n"
                + "                WHERE c.id = ? AND p.status = 1;");

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

           

            while (rs.next()) {
                ProductBean    product = new ProductBean();
                    product.setId(rs.getInt("product_id"));
                    product.setProductName(rs.getString("product_name"));

                    Blob productBlob = rs.getBlob("product_image");
                    if (productBlob != null) {
                        product.setProductPhotoByte(productBlob.getBytes(1, (int) productBlob.length()));
                    } else {
                        product.setProductPhotoByte(new byte[0]); 
                    }

                    product.setPopularity(rs.getInt("popularity"));
                    product.setDescription(rs.getString("description"));
                    product.setQuantity(rs.getDouble("quantity"));
                    //System.out.println(rs.get)
                    product.setProductUnit(rs.getString("product_unit"));
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

 
   
    public boolean productExistName(String productName) {
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM product WHERE name = ?");
            ps.setString(1, productName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return (rs.getInt(1) > 0);
            }
        } catch (SQLException e) {
            System.out.println("Error checking product existence: " + e.getMessage());
        }
        return false;
    }
//    
    public ProductBean findProductById(int id) {
        ProductBean product = null;
        try (Connection con = LinkConnection.linkConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT p.id AS product_id, p.name AS product_name, p.image AS product_image, " +
                "p.popularity, p.description, p.quantity, c.id AS catagory_id, c.name AS category_name, " +
                "c.image AS category_image " + 
                "FROM product p " +
                "JOIN category c ON p.catagory_id = c.id " +
                "WHERE p.id = ?");

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                product = new ProductBean();
                product.setId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                Blob productBlob = rs.getBlob("product_image");
                product.setProductPhotoByte(productBlob != null ? productBlob.getBytes(1, (int) productBlob.length()) : new byte[0]);
                product.setPopularity(rs.getInt("popularity"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("quantity"));

                CategoryBean category = new CategoryBean();
                category.setId(rs.getInt("catagory_id"));
                category.setName(rs.getString("category_name"));
                Blob categoryBlob = rs.getBlob("category_image");
                category.setPhotoByte(categoryBlob != null ? categoryBlob.getBytes(1, (int) categoryBlob.length()) : null);
                product.setCategory(category);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching product by id: " + e.getMessage());
        }
        return product;
    }
//
//
//    
    public void updateProduct(ProductBean product) {
    	
    	Connection con=LinkConnection.linkConnection();
    	try {
			PreparedStatement ps=con.prepareStatement("UPDATE  product set name=?,image=?,popularity=?,description=?,quantity=? WHERE id=?");
			ps.setString(1, product.getProductName());
			ps.setBytes(2, product.getProductPhotoByte());
			ps.setInt(3, product.getPopularity());
			ps.setString(4, product.getDescription());
			ps.setDouble(5, product.getQuantity());
			ps.setInt(6, product.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("Updating product error :"+e.getMessage());
		}
    }
//    
    public void softDeleteProductById(int id) {
    	Connection con=LinkConnection.linkConnection();
    	try {
			PreparedStatement ps=con.prepareStatement("UPDATE product set status=0 WHERE id=?");
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SoftDeleting by product id error :"+e.getMessage());
		}
    }
    
    public void restoreProductById(int id) {
    	Connection con=LinkConnection.linkConnection();
    	try {
			PreparedStatement ps=con.prepareStatement("UPDATE product set status=1 WHERE id=?");
			ps.setInt(1, id);
			ps.executeUpdate();	
		} catch (SQLException e) {
			System.out.println("Restoring by product id error :"+e.getMessage());
		}
    }
    
    public List<ProductBean> getAllDeletedProducts(int categoryId) {
    	ProductBean product=null;
    	List<ProductBean> deletedProducts = new ArrayList<>();

        Connection con = LinkConnection.linkConnection();
        try {
             PreparedStatement ps = con.prepareStatement(
                "SELECT p.id AS product_id, p.name AS product_name, p.image AS product_image, \n"
                + "                p.popularity, p.description, p.quantity, c.id AS catagory_id, c.name AS category_name,c.image AS category_image \n"
                + "                FROM product p JOIN category c ON p.catagory_id = c.id WHERE p.status = 0 AND c.id=?;");
        		
             ps.setInt(1, categoryId);
             ResultSet rs = ps.executeQuery() ;

            while (rs.next()) {
                 product = new ProductBean();
                product.setId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));

                
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
                category.setId(rs.getInt("catagory_id"));
                category.setName(rs.getString("category_name"));
                Blob categoryBlob=rs.getBlob("category_image");
                category.setPhotoByte(categoryBlob.getBytes(1, (int) categoryBlob.length()));

                product.setCategory(category);  
                deletedProducts.add(product);
            }
        } catch (SQLException e) {
            
            System.err.println("Error fetching deleted products: " + e.getMessage());
        }
        return deletedProducts;
    }
    public int count() {
        int count = 0;
        Connection con = LinkConnection.linkConnection();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM product WHERE status = 1");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting products: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }
    public List<ProductBean> getAllProducts() {
        List<ProductBean> products = new ArrayList<>();
        Connection con = LinkConnection.linkConnection();
        
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT p.*, c.name AS category_name FROM mydb.product p " +
                "JOIN mydb.category c ON p.catagory_id = c.id WHERE p.status=1 AND c.status=1 ORDER BY p.popularity DESC"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductBean	 product = new ProductBean();
                product.setId(rs.getInt("id"));
                product.setProductName(rs.getString("name"));

                Blob productBlob = rs.getBlob("image");
                if (productBlob != null) {
                    product.setProductPhotoByte(productBlob.getBytes(1, (int) productBlob.length()));
                } else {
                    product.setProductPhotoByte(new byte[0]); 
                }

                product.setPopularity(rs.getInt("popularity"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getDouble("quantity"));
                product.setProductUnit(rs.getString("unit"));

                // Set the category
                CategoryBean category = new CategoryBean();
                category.setId(rs.getInt("catagory_id"));
                category.setName(rs.getString("category_name"));
                product.setCategory(category);
                
                products.add(product);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching all products : " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return products;
    }
    public List<ProductBean> searchProducts(String query, Integer categoryId) {
        List<ProductBean> products = new ArrayList<>();
        Connection con = LinkConnection.linkConnection();
        
        try {
        	StringBuilder sql = new StringBuilder("SELECT p.id AS product_id, p.name AS product_name, p.image AS product_image, " +
                    "p.popularity, p.description, p.quantity, p.unit, c.id AS catagory_id, c.name AS category_name " +
                    "FROM product p JOIN category c ON p.catagory_id = c.id " +
                    "WHERE p.status = 1 AND c.status=1 AND (p.name LIKE ? OR c.name LIKE ?)");

            
            
            if (categoryId != null) {
                sql.append(" AND c.id = ?");
            }
            
            PreparedStatement ps = con.prepareStatement(sql.toString());
            ps.setString(1, "%" + query + "%");  // For product name
            ps.setString(2, "%" + query + "%");  // For category name
            
          
            if (categoryId != null) {
                ps.setInt(3, categoryId);
            }

            System.out.println("Executing SQL: " + ps.toString()); // Consider logging parameter values separately

            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));

                Blob productBlob = rs.getBlob("product_image");
                product.setProductPhotoByte(productBlob != null ? productBlob.getBytes(1, (int) productBlob.length()) : new byte[0]);
                
                product.setPopularity(rs.getInt("popularity"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("quantity"));
                product.setUnit(rs.getString("unit"));

                CategoryBean category = new CategoryBean();
                category.setId(rs.getInt("catagory_id"));
                category.setName(rs.getString("category_name"));
                
                product.setCategory(category);
                products.add(product);
            }

        } catch (SQLException e) {
            System.err.println("Error searching products: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return products.isEmpty() ? Collections.emptyList() : products;
    }
    public List<ProductBean> getTopSellingProducts(int limit) {
        List<ProductBean> products = new ArrayList<>();
        Connection con = LinkConnection.linkConnection();
        
        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT p.*, c.name AS category_name FROM product p " +
                "JOIN category c ON p.catagory_id = c.id WHERE p.status = 1 " +
                "ORDER BY p.popularity DESC LIMIT ?");
            
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setId(rs.getInt("id"));
                product.setProductName(rs.getString("name"));
                product.setPopularity(rs.getInt("popularity"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("quantity"));
                product.setUnit(rs.getString("unit"));

                // Set the category
                CategoryBean category = new CategoryBean();
                category.setId(rs.getInt("catagory_id"));
                category.setName(rs.getString("category_name"));
                product.setCategory(category);
                
                products.add(product);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching top selling products: " + e.getMessage());
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
