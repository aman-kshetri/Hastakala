package dao;

import model.CartItem;
import model.Product;
import util.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
	
	private static final String GET_CART_ID = "SELECT cart_id FROM cart WHERE user_id = ?";
	
	private static final String CREATE_CART = "INSERT INTO cart (user_id) VALUES (?)";
	
    private static final String GET_CART_ITEMS = 
        "SELECT ci.*, p.* FROM cart_item ci " +
        "JOIN product p ON ci.product_id = p.product_id " +
        "WHERE ci.cart_id = ?";
    
    private static final String ADD_ITEM = 
        "INSERT INTO cart_item (cart_id, product_id, quantity) " +
        "VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE quantity = quantity + ?";
    
    private static final String DECREMENT_ITEM = 
    	    "UPDATE cart_item SET quantity = quantity - 1 WHERE cart_id = ? AND product_id = ? AND quantity > 1";
    
    private static final String REMOVE_ITEM = 
        "DELETE FROM cart_item WHERE cart_id = ? AND product_id = ?";
    
    private static final String CLEAR_CART = 
        "DELETE FROM cart_item WHERE cart_id = ?";

    public List<CartItem> getCartItems(int cartId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_CART_ITEMS)) {
            
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setCartId(cartId);
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                
                item.setProduct(product);
                items.add(item);
            }
        }
        return items;
    }
    
    public int getOrCreateCartId(int userId) throws SQLException {
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_CART_ID)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }
            
            // Cart doesn't exist, create one
            try (PreparedStatement createStmt = conn.prepareStatement(
                    CREATE_CART, Statement.RETURN_GENERATED_KEYS)) {
                createStmt.setInt(1, userId);
                createStmt.executeUpdate();
                
                ResultSet generatedKeys = createStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        }
        throw new SQLException("Failed to get or create cart");
    }

    public boolean addItem(int cartId, int productId, int quantity) throws SQLException {
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(ADD_ITEM)) {
            
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setInt(4, quantity);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean decrementOrRemoveItem(int cartId, int productId) throws SQLException {
        // First try to decrement
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DECREMENT_ITEM)) {
            
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            int updatedRows = stmt.executeUpdate();
            
            if (updatedRows == 0) {
                // If quantity was 1, remove the item completely
                return removeItem(cartId, productId);
            }
            return true;
        }
    }

    public boolean removeItem(int cartId, int productId) throws SQLException {
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(REMOVE_ITEM)) {
            
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean clearCart(int cartId) throws SQLException {
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(CLEAR_CART)) {
            stmt.setInt(1, cartId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows >= 0; // Even if 0 rows were there to delete
        }
    }

    public int getCartItemCount(int cartId) throws SQLException {
        final String COUNT_ITEMS = "SELECT COUNT(*) FROM cart_item WHERE cart_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(COUNT_ITEMS)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}