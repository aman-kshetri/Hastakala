package dao;

import model.Order;
import model.OrderItem;
import model.User;
import util.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

	public int createOrder(int userId, String fullName, String email, String phone,
            String shippingAddress, String paymentMethod, 
            double totalAmount) throws SQLException {
String orderSql = "INSERT INTO orders (user_id, full_name, email, phone, " +
           "shipping_address, payment_method, total_amount, status) " +
           "VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING')";

String itemSql = "INSERT INTO order_item (order_id, product_id, quantity, price) " +
          "SELECT ?, ci.product_id, ci.quantity, p.price " +
          "FROM cart_item ci JOIN product p ON ci.product_id = p.product_id " +
          "WHERE ci.cart_id = (SELECT cart_id FROM cart WHERE user_id = ?)";

String clearCartSql = "DELETE FROM cart_item WHERE cart_id = " +
               "(SELECT cart_id FROM cart WHERE user_id = ?)";

try (Connection conn = DBUtils.getConnection()) {
conn.setAutoCommit(false);

// Insert order
PreparedStatement orderStmt = conn.prepareStatement(orderSql, 
                    Statement.RETURN_GENERATED_KEYS);
orderStmt.setInt(1, userId);
orderStmt.setString(2, fullName);
orderStmt.setString(3, email);
orderStmt.setString(4, phone);
orderStmt.setString(5, shippingAddress);
orderStmt.setString(6, paymentMethod);
orderStmt.setDouble(7, totalAmount);
orderStmt.executeUpdate();

ResultSet rs = orderStmt.getGeneratedKeys();
if (!rs.next()) {
  throw new SQLException("Failed to create order");
}
int orderId = rs.getInt(1);

// Insert order items
PreparedStatement itemStmt = conn.prepareStatement(itemSql);
itemStmt.setInt(1, orderId);
itemStmt.setInt(2, userId);
itemStmt.executeUpdate();

// Clear cart
PreparedStatement clearStmt = conn.prepareStatement(clearCartSql);
clearStmt.setInt(1, userId);
clearStmt.executeUpdate();

conn.commit();
return orderId;
}
}

	public List<Order> getAllOrders() {
	    List<Order> orders = new ArrayList<>();
	    // Add WHERE clause to filter out DELIVERED orders
	    String sql = "SELECT order_id, user_id, full_name, email, phone, " +
	                 "total_amount, status, payment_method, shipping_address, created_at " +
	                 "FROM orders WHERE status != 'DELIVERED' ORDER BY created_at DESC";
	    
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        
	        while (rs.next()) {
	            Order order = new Order();
	            order.setOrderId(rs.getInt("order_id"));
	            order.setUserId(rs.getInt("user_id"));
	            order.setFullName(rs.getString("full_name"));
	            order.setEmail(rs.getString("email"));
	            order.setPhone(rs.getString("phone"));
	            order.setTotalAmount(rs.getDouble("total_amount"));
	            order.setStatus(rs.getString("status"));
	            order.setPaymentMethod(rs.getString("payment_method"));
	            order.setShippingAddress(rs.getString("shipping_address"));
	            order.setCreatedAt(rs.getTimestamp("created_at"));
	            
	            orders.add(order);
	        }
	    } catch (SQLException e) {
	        System.err.println("ERROR in getAllOrders: " + e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return orders;
	}
	
	public List<Order> getAllOrdersIncludingDelivered() {
	    List<Order> orders = new ArrayList<>();
	    String sql = "SELECT order_id, user_id, full_name, email, phone, " +
	                 "total_amount, status, payment_method, shipping_address, created_at " +
	                 "FROM orders ORDER BY created_at DESC";
	    
	    try (Connection conn = DBUtils.getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql);
		         ResultSet rs = ps.executeQuery()) {
		        
		        while (rs.next()) {
		            Order order = new Order();
		            order.setOrderId(rs.getInt("order_id"));
		            order.setUserId(rs.getInt("user_id"));
		            order.setFullName(rs.getString("full_name"));
		            order.setEmail(rs.getString("email"));
		            order.setPhone(rs.getString("phone"));
		            order.setTotalAmount(rs.getDouble("total_amount"));
		            order.setStatus(rs.getString("status"));
		            order.setPaymentMethod(rs.getString("payment_method"));
		            order.setShippingAddress(rs.getString("shipping_address"));
		            order.setCreatedAt(rs.getTimestamp("created_at"));
		            
		            orders.add(order);
		        }
		    } catch (SQLException e) {
		        System.err.println("ERROR in getAllOrders: " + e.getMessage());
		        e.printStackTrace();
		    }
		    
		    return orders;
	}

	public Order getOrderById(int orderId) throws SQLException {
	    String sql = "SELECT * FROM orders WHERE order_id = ?";
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, orderId);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            Order order = new Order();
	            order.setOrderId(rs.getInt("order_id"));
	            order.setUserId(rs.getInt("user_id"));
	            order.setFullName(rs.getString("full_name"));
	            order.setEmail(rs.getString("email"));
	            order.setPhone(rs.getString("phone"));
	            order.setShippingAddress(rs.getString("shipping_address"));
	            order.setPaymentMethod(rs.getString("payment_method"));
	            order.setTotalAmount(rs.getDouble("total_amount"));
	            order.setStatus(rs.getString("status"));
	            order.setCreatedAt(rs.getTimestamp("created_at"));
	            return order;
	        }
	    }
	    return null;
	}
	
	public List<Order> getRecentOrders(int limit) {
	    List<Order> orders = new ArrayList<>();
	    String sql = "SELECT o.*, u.name, u.email FROM orders o JOIN user u ON o.user_id = u.user_id ORDER BY o.created_at DESC LIMIT ?";
	    
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, limit);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Order o = new Order();
	            o.setOrderId(rs.getInt("order_id"));
	            o.setUserId(rs.getInt("user_id"));
	            o.setStatus(rs.getString("status"));
	            o.setPaymentMethod(rs.getString("payment_method"));
	            o.setTotalAmount(rs.getDouble("total_amount"));
	            o.setCreatedAt(rs.getTimestamp("created_at"));

	            User user = new User();
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            o.setUser(user);

	            orders.add(o);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return orders;
	}


	public List<OrderItem> getOrderItemsByOrderId(int orderId) {
	    List<OrderItem> items = new ArrayList<>();
	    String sql = "SELECT oi.*, p.name as product_name " +
	                 "FROM order_item oi JOIN product p ON oi.product_id = p.product_id " +
	                 "WHERE oi.order_id = ?";
	    try (Connection conn = DBUtils.getConnection(); 
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, orderId);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            OrderItem item = new OrderItem();
	            item.setOrderItemId(rs.getInt("order_item_id"));
	            item.setOrderId(orderId);
	            item.setProductId(rs.getInt("product_id"));
	            item.setProductName(rs.getString("product_name"));
	            item.setQuantity(rs.getInt("quantity"));
	            item.setPrice(rs.getDouble("price"));
	            items.add(item);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return items;
	}

	public List<Order> getOrdersByUserId(int userId) {
		List<Order> orders = new ArrayList<>();
		String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
		try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setOrderId(rs.getInt("order_id"));
				order.setUserId(rs.getInt("user_id"));
				order.setFullName(rs.getString("full_name"));
				order.setEmail(rs.getString("email"));
				order.setPhone(rs.getString("phone"));
				order.setShippingAddress(rs.getString("shipping_address"));
				order.setPaymentMethod(rs.getString("payment_method"));
				order.setTotalAmount(rs.getDouble("total_amount"));
				order.setStatus(rs.getString("status"));
				order.setCreatedAt(rs.getTimestamp("created_at"));
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}


	public boolean updateOrderStatus(int orderId, String status) {
	    String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, status);
	        ps.setInt(2, orderId);
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}


	public double getTotalRevenue() {
	    String sql = "SELECT SUM(oi.quantity * oi.price) AS total " +
	                 "FROM order_item oi " +
	                 "JOIN orders o ON oi.order_id = o.order_id " +
	                 "WHERE o.status = 'DELIVERED'";
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        return rs.next() ? rs.getDouble("total") : 0.0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return 0.0;
	    }
	}

	public int getTotalOrders() {
		String sql = "SELECT COUNT(*) FROM orders";
		try (Connection conn = DBUtils.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt(1) : 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	public int getTotalCustomers() {
		String sql = "SELECT COUNT(DISTINCT user_id) FROM orders";
		try (Connection conn = DBUtils.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			return rs.next() ? rs.getInt(1) : 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	public List<Object[]> getSalesReportByCategory() {
	    List<Object[]> report = new ArrayList<>();
	    String sql = "SELECT c.name AS category_name, " + 
	                 "SUM(oi.quantity * oi.price) AS total_sales, " +
	                 "COUNT(DISTINCT o.order_id) AS order_count " + 
	                 "FROM order_item oi " +
	                 "JOIN product p ON oi.product_id = p.product_id " +
	                 "JOIN category c ON p.category_id = c.category_id " + 
	                 "JOIN orders o ON oi.order_id = o.order_id " +
	                 "WHERE o.status = 'DELIVERED' " +
	                 "GROUP BY c.name " + 
	                 "ORDER BY total_sales DESC";

	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        while (rs.next()) {
	            Object[] row = new Object[3];
	            row[0] = rs.getString("category_name");
	            row[1] = rs.getDouble("total_sales");
	            row[2] = rs.getInt("order_count");
	            report.add(row);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return report;
	}

}
