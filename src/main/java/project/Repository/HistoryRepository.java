package project.Repository;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import project.Model.HistoryBean;
import project.Model.HistoryModelBoxBean;

@Repository
public class HistoryRepository {
    public List<HistoryBean> showHistory(int userId) {
        List<HistoryBean> history = new ArrayList<>();
        String sql = "SELECT \r\n"
        		+ "    o.order_number AS orderNumber, \r\n"
        		+ "   o.date AS date,\r\n"
        		+ "    GROUP_CONCAT(p.name SEPARATOR ', ') AS orderItems, \r\n"
        		+ "    \r\n"
        		+ "   pay.payment_date AS orderDate, \r\n"
        		+ "    o.address AS orderAddress, \r\n"
        		+ "    o.order_notes AS orderNotes, \r\n"
        		+ "    pay.status AS status,\r\n"
        		+ "    pay.payment_date AS paymentDate -- Optionally include payment date if needed\r\n"
        		+ "FROM \r\n"
        		+ "    `order` o\r\n"
        		+ "JOIN \r\n"
        		+ "    payment pay ON o.id = pay.order_id \r\n"
        		+ "JOIN \r\n"
        		+ "    order_item oi ON o.id = oi.order_id \r\n"
        		+ "JOIN \r\n"
        		+ "    detail d ON oi.detail_id = d.id \r\n"
        		+ "JOIN \r\n"
        		+ "    product p ON d.product_id = p.id \r\n"
        		+ "WHERE \r\n"
        		+ "    o.user_id = ? \r\n"
        		+ "GROUP BY \r\n"
        		+ "    o.order_number,o.date, pay.payment_date, o.address, o.order_notes, pay.status \r\n"
        		+ "ORDER BY \r\n"
        		+ "    pay.payment_date;";

        try (Connection con = LinkConnection.linkConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);  // Set the userId parameter
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HistoryBean orderHistory = new HistoryBean();
                orderHistory.setOrderNumber(rs.getString("orderNumber"));
                orderHistory.setOrderItems(rs.getString("orderItems"));
                
                // Convert SQL Date to LocalDate
                Date paymentSqlDate = rs.getDate("date");
                LocalDate paymentDate = paymentSqlDate != null ? paymentSqlDate.toLocalDate() : null;
                orderHistory.setOrderdate(paymentDate);
                
                orderHistory.setOrderAddress(rs.getString("orderAddress"));
                orderHistory.setStatus(rs.getInt("status"));
                orderHistory.setOrderNotes(rs.getString("orderNotes"));
                
                history.add(orderHistory);
            }
        } catch (SQLException e) {
            System.out.println("History show error: " + e.getMessage());
        }

        return history;
    }
    public List<HistoryModelBoxBean> getOrderHistoryByUserIdAndOrderNumber(int userId, String orderNumber) {
        List<HistoryModelBoxBean> historyList = new ArrayList<>();

        String query = "SELECT \r\n"
        		+ "    p.name AS orderItem, \r\n"
        		+ "    oi.order_quantity AS orderQuantity,\r\n"
        		+ "    d.price AS price, \r\n"
        		+ "    (oi.order_quantity * d.price) AS totalPrice,\r\n"
        		+ "    pm.amount AS totalAmount, \r\n"
        		+ "    pm.status AS paymentStatus,\r\n"
        		+ "    d.unit AS unit,          \r\n"
        		+ "    d.per_quantity AS perQuantity  \r\n"
        		+ "FROM \r\n"
        		+ "    user u\r\n"
        		+ "JOIN \r\n"
        		+ "    `order` o ON u.id = o.user_id\r\n"
        		+ "JOIN \r\n"
        		+ "    payment pm ON o.id = pm.order_id\r\n"
        		+ "JOIN \r\n"
        		+ "    order_item oi ON o.id = oi.order_id\r\n"
        		+ "JOIN \r\n"
        		+ "    detail d ON oi.detail_id = d.id\r\n"
        		+ "JOIN \r\n"
        		+ "    product p ON d.product_id = p.id\r\n"
        		+ " WHERE u.id = ? AND o.order_number = ?;";

        try (Connection conn = LinkConnection.linkConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            // Set the userId and orderNumber parameters
            stmt.setInt(1, userId);
            stmt.setString(2, orderNumber);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                HistoryModelBoxBean history = new HistoryModelBoxBean();
                history.setOrderItem(rs.getString("orderItem"));
                history.setOrderQuantity(rs.getInt("orderQuantity"));
                history.setPrice(rs.getDouble("price"));
                history.setTotalPrice(rs.getDouble("totalPrice"));
                
                // Set the overall totalAmount from payment table
                history.setTotalAmount(rs.getDouble("totalAmount"));
                
                // Set the status from payment table
                history.setStatus(rs.getInt("paymentStatus"));
                history.setUnit(rs.getString("unit"));
                history.setPerQuantity(rs.getInt("perQuantity"));
                
                historyList.add(history);
            }
        } catch (Exception e) {
            System.out.println("History ModelBox Error: " + e.getMessage());
        }
        
        return historyList;
    }


}