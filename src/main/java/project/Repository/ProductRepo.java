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

public class ProductRepo {
	
	public List<CategoryBean> showAllCategory() {
		Connection cn=LinkConnection.linkConnection();
		List<CategoryBean> cList=new ArrayList<CategoryBean>();
		CategoryBean cBean=null;
		String query="SELECT DISTINCT category.* FROM category\r\n"
				+ "INNER JOIN product ON product.catagory_id=category.id\r\n"
				+ "INNER JOIN detail ON detail.product_id=product.id\r\n"
				+ " WHERE category.status= 1 AND product.status=1 AND detail.status=1;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				cBean=new CategoryBean();
				cBean.setId(rs.getInt(1));
				cBean.setName(rs.getString(2));
				Blob blob=rs.getBlob(4);
				cBean.setPhotoByte(blob.getBytes(1, (int)blob.length()));
				cList.add(cBean);
			}
		} catch (SQLException e) {
			System.out.println("Showing all category error"+e.getMessage());
		}
		return cList;
	}
//	public List<Integer> showAllCategoryId() {
//		
//		Connection cn=LinkConnection.linkConnection();
//		List<Integer> idList=new ArrayList<Integer>();
//		String query="SELECT * FROM mydb.category WHERE status=1;";
//		try {
//			PreparedStatement ps=cn.prepareStatement(query);
//			ResultSet rs=ps.executeQuery();
//			while(rs.next()) {
//				idList.add(rs.getInt(1));
//			}
//		} catch (SQLException e) {
//			System.out.println("Showing all category error"+e.getMessage());
//		}
//		return idList;
//	}
//	public List<ProductBean> showAllProduct(){
//		Connection cn=LinkConnection.linkConnection();
//		List<ProductBean> pList=new ArrayList<ProductBean>();
//		ProductBean pBean=null;
//		String query="SELECT product_detail.id,product_id,product.name,product.Exp_Date,product.description,product.image,\r\n"
//				+ "detail_id,detail.unit,detail.quantity,detail.price,detail.per_price\r\n"
//				+ "FROM mydb.product_detail\r\n"
//				+ "INNER JOIN mydb.product ON mydb.`product_detail`.product_id = mydb.product.id\r\n"
//				+ "INNER JOIN detail ON mydb.`product_detail`.detail_id = detail.id WHERE product.status=1;";
//		try {
//			PreparedStatement ps=cn.prepareStatement(query);
//			ResultSet rs=ps.executeQuery();
//			while(rs.next()) {
//				pBean=new ProductBean();
//				pBean.setId(rs.getInt(1));
//				pBean.setProductId(rs.getInt(2));
//				pBean.setProductName(rs.getString(3));
//				pBean.setExpDate(rs.getDate(4));
//				pBean.setDescription(rs.getString(5));
//				Blob blob=rs.getBlob(6);
//				pBean.setProductPhotoByte(blob.getBytes(1, (int)blob.length()));
//				pBean.setDetailId(rs.getInt(7));
//				pBean.setUnit(rs.getInt(8));
//				pBean.setQuantity(rs.getInt(9));
//				pBean.setPrice(rs.getDouble(10));
//				pBean.setPer_price(rs.getDouble(11));
//				pList.add(pBean);
//				
//			}
//		} catch (SQLException e) {
//			System.out.println("Show All Product Error "+e.getMessage());
//		}
//		return pList;
//	}
	public List<ProductBean> showAllProductByCategoryId(int catagoryId){
		Connection cn=LinkConnection.linkConnection();
		List<ProductBean> pList=new ArrayList<ProductBean>();
		ProductBean pBean=null;
		String query="SELECT detail.id,product.id,product.catagory_id,product.name,product.description,product.image,product.quantity,\r\n"
				+ "				detail.unit,detail.price,detail.per_quantity,category.name,product.unit\r\n"
				+ "				 FROM mydb.detail INNER JOIN mydb.product ON detail.product_id=product.id\r\n"
				+ "                 INNER JOIN mydb.category ON product.catagory_id=category.id\r\n"
				+ "                 WHERE product.status=1 AND detail.status=1 AND catagory_id=? AND product.quantity>0;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setInt(1, catagoryId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				pBean=new ProductBean();
				pBean.setId(rs.getInt(1));
				pBean.setProductId(rs.getInt(2));
				pBean.setCategoryId(rs.getInt(3));
				pBean.setProductName(rs.getString(4));
				pBean.setDescription(rs.getString(5));
				Blob blob=rs.getBlob(6);
				pBean.setProductPhotoByte(blob.getBytes(1, (int)blob.length()));
				pBean.setQuantity(rs.getDouble(7));
				pBean.setUnit(rs.getString(8));
				pBean.setPrice(rs.getDouble(9));
				pBean.setPer_quantity(rs.getInt(10));
				pBean.setCategoryName(rs.getString(11));
				pBean.setProductUnit(rs.getString(12));
				pList.add(pBean);
				
			}
		} catch (SQLException e) {
			System.out.println("Show All Product Error "+e.getMessage());
		}
		return pList;
	}
	public int updateFavourite(int productId,int userId) {
		int i=0;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT * FROM mydb.favourite WHERE user_id=? AND product_id=?;";
		//String query="INSERT INTO mydb.favourite (user_id,product_id) VALUES (?,?); ";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setInt(2, productId);
			//i=ps.executeUpdate();
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				query="DELETE FROM mydb.favourite WHERE user_id = ? AND product_id=?;";
				ps=cn.prepareStatement(query);
				ps.setInt(1, userId);
				ps.setInt(2, productId);
				ps.executeUpdate();
				i=0;
			}else {
				query="INSERT INTO mydb.favourite (user_id,product_id) VALUES (?,?); ";
				ps=cn.prepareStatement(query);
				ps.setInt(1, userId);
				ps.setInt(2, productId);
				i=ps.executeUpdate();
				
			}
		} catch (SQLException e) {
			System.out.println("Updating Favourite Error "+e.getMessage());
		}
		
		return i;
	}
	public List<ProductBean> showFavProducts(int userId){
		List<ProductBean> favList=new ArrayList<ProductBean>();
		ProductBean pBean=null;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT detail.id,product.id,product.catagory_id,product.name,product.description,product.image,product.quantity,\r\n"
				+ "				detail.unit,detail.price,detail.per_quantity,user_id,favourite.id,category.name,product.unit FROM mydb.favourite INNER JOIN mydb.product ON favourite.product_id=product.id \r\n"
				+ "				INNER JOIN mydb.detail ON favourite.product_id=detail.product_id\r\n"
				+ "                INNER JOIN mydb.category ON product.catagory_id=category.id\r\n"
				+ "                WHERE user_id=? AND product.status=1 AND detail.status=1 AND product.quantity>0;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setInt(1, userId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				pBean=new ProductBean();
				pBean.setId(rs.getInt(1));
				pBean.setProductId(rs.getInt(2));
				pBean.setCategoryId(rs.getInt(3));
				pBean.setProductName(rs.getString(4));
				pBean.setDescription(rs.getString(5));
				Blob blob=rs.getBlob(6);
				pBean.setProductPhotoByte(blob.getBytes(1, (int)blob.length()));
				pBean.setQuantity(rs.getDouble(7));
				pBean.setUnit(rs.getString(8));
				pBean.setPrice(rs.getDouble(9));
				pBean.setPer_quantity(rs.getInt(10));
				pBean.setCategoryName(rs.getString(13));
				pBean.setProductUnit(rs.getString(14));
				favList.add(pBean);
			}
		} catch (SQLException e) {
			System.out.println("Show Fav Product Error "+e.getMessage());
		}
		return favList;
	}
	
	public int unFavorite(int productId,int userId) {
		int i=0;
		Connection cn=LinkConnection.linkConnection();
		String query="DELETE FROM mydb.favourite WHERE user_id = ?  AND product_id=?;";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setInt(1, userId);
			ps.setInt(2, productId);
			i=ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("UnFav Erro :"+e.getMessage());
		}
		return i;
	}
	
	public List<ProductBean> searchProducts(String searchWords){
		List<ProductBean> searchedList=new ArrayList<ProductBean>();
		ProductBean productBean=null;
		Connection cn=LinkConnection.linkConnection();
		String query = "SELECT detail.id, product.id, product.catagory_id, product.name, product.description, product.image, \r\n"
				+ "       product.quantity, detail.unit, detail.price, detail.per_quantity, category.name, product.unit\r\n"
				+ "FROM mydb.detail \r\n"
				+ "INNER JOIN mydb.product ON detail.product_id = product.id\r\n"
				+ "INNER JOIN mydb.category ON product.catagory_id = category.id\r\n"
				+ "WHERE product.name LIKE ? \r\n"
				+ "  AND product.status = 1 \r\n"
				+ "  AND detail.status = 1 \r\n"
				+ "  AND category.status = 1 \r\n"
				+ "  AND product.quantity > 0;\r\n"
				+ ";";
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ps.setString(1, "%" + searchWords + "%");
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				productBean=new ProductBean();
				productBean.setId(rs.getInt(1));
				productBean.setProductId(rs.getInt(2));
				productBean.setCategoryId(rs.getInt(3));
				productBean.setProductName(rs.getString(4));
				productBean.setDescription(rs.getString(5));
				Blob blob=rs.getBlob(6);
				productBean.setProductPhotoByte(blob.getBytes(1, (int)blob.length()));
				productBean.setQuantity(rs.getDouble(7));
				productBean.setUnit(rs.getString(8));
				productBean.setPrice(rs.getDouble(9));
				productBean.setPer_quantity(rs.getInt(10));
				productBean.setCategoryName(rs.getString(11));	
				productBean.setProductUnit(rs.getString(12));;
				searchedList.add(productBean);
				
			}
		} catch (SQLException e) {
			System.out.println("Searched Products Error "+e.getMessage());
		}
		
		
		
		return searchedList;
	}
	
	public List<ProductBean> getPopularItems(){
		List<ProductBean> popularList=new ArrayList<ProductBean>();
		ProductBean productBean=null;
		Connection cn=LinkConnection.linkConnection();
		String query="SELECT detail.id, product.id, product.catagory_id, product.name, product.description, product.image, \r\n"
				+ "       product.quantity, detail.unit, detail.price, detail.per_quantity, category.name, product.unit\r\n"
				+ "FROM mydb.detail\r\n"
				+ "INNER JOIN mydb.product ON detail.product_id = product.id\r\n"
				+ "INNER JOIN mydb.category ON product.catagory_id = category.id\r\n"
				+ "WHERE product.popularity > 0\r\n"
				+ "  AND product.status = 1\r\n"
				+ "  AND detail.status = 1\r\n"
				+ "  AND product.quantity > 0\r\n"
				+ "  AND category.status = 1 -- Added this in case it's necessary for consistency\r\n"
				+ "ORDER BY product.popularity DESC -- Order by popularity to get the most popular products first\r\n"
				+ "LIMIT 8; "
				;
		try {
			PreparedStatement ps=cn.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				productBean=new ProductBean();
				productBean.setId(rs.getInt(1));
				productBean.setProductId(rs.getInt(2));
				productBean.setCategoryId(rs.getInt(3));
				productBean.setProductName(rs.getString(4));
				productBean.setDescription(rs.getString(5));
				Blob blob=rs.getBlob(6);
				productBean.setProductPhotoByte(blob.getBytes(1, (int)blob.length()));
				productBean.setQuantity(rs.getDouble(7));
				productBean.setUnit(rs.getString(8));
				productBean.setPrice(rs.getDouble(9));
				productBean.setPer_quantity(rs.getInt(10));
				productBean.setCategoryName(rs.getString(11));
				productBean.setProductUnit(rs.getString(12));
				
				popularList.add(productBean);
			}
		} catch (SQLException e) {
			System.out.println("Get Popular Items "+e.getMessage());
		}
		return popularList;
	}
	
	public int getTotalPages() {
	    Connection cn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    int totalPages = 0;

	    try {
	        // Establish the connection
	        cn = LinkConnection.linkConnection();

	        // Prepare the SQL query
	        String query = "SELECT COUNT(DISTINCT category.id) AS category_count " +
	                       "FROM category " +
	                       "INNER JOIN product ON product.catagory_id = category.id " +
	                       "INNER JOIN detail ON detail.product_id = product.id " +
	                       "WHERE category.status = 1 " +
	                       "  AND product.status = 1 " +
	                       "  AND detail.status = 1;";

	        // Create a PreparedStatement
	        ps = cn.prepareStatement(query);

	        // Execute the query
	        rs = ps.executeQuery();

	        // Retrieve the count from the ResultSet
	        if (rs.next()) {
	            int totalCount = rs.getInt("category_count");
	            // Calculate the total number of pages
	            totalPages = (int) Math.ceil((double) totalCount / 3);
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // Handle exception (you may want to log it)
	    } finally {
	        // Close the resources
	        try {
	            if (rs != null) rs.close();
	            if (ps != null) ps.close();
	            if (cn != null) cn.close();
	        } catch (Exception e) {
	            e.printStackTrace(); // Handle exception (you may want to log it)
	        }
	    }

	    return totalPages;
	}
	public List<CategoryBean> showPaginatedCategories(int pageNumber, int categoriesPerPage) {
	    List<CategoryBean> categories = new ArrayList<>();
	    Connection cn = LinkConnection.linkConnection();
	    
	    String query = "SELECT  DISTINCT category.* FROM category " +
                "INNER JOIN product ON product.catagory_id = category.id " +
                "INNER JOIN detail ON detail.product_id = product.id " +
                "WHERE category.status = 1 " +
                "AND product.status = 1 " +
                "AND detail.status = 1 " +
                "LIMIT ?, ?";

	    try (PreparedStatement ps = cn.prepareStatement(query)) {
	        ps.setInt(1, (pageNumber - 1) * categoriesPerPage);
	        ps.setInt(2, categoriesPerPage);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            CategoryBean category = new CategoryBean();
	            category.setId(rs.getInt(1));
				category.setName(rs.getString(2));
				Blob blob=rs.getBlob(4);
				category.setPhotoByte(blob.getBytes(1, (int)blob.length()));
	            // Set properties for category from result set
	            categories.add(category);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); // Handle exception
	    }
	    return categories;
	}
}
