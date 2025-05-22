package service;

import dao.CartDAO;
import model.CartItem;
import util.DBUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class CartService {
    private CartDAO cartDAO;

    public CartService() {
        this.cartDAO = new CartDAO();
    }

    public List<CartItem> getCartItems(int userId) throws SQLException {
        System.out.println("DEBUG: Fetching cart for user ID: " + userId);
        int cartId = cartDAO.getOrCreateCartId(userId);
        List<CartItem> items = cartDAO.getCartItems(cartId);
        System.out.println("DEBUG: Found " + items.size() + " items in cart");
        return items;
    }

    public boolean addToCart(int userId, int productId, int quantity) throws SQLException {
        int cartId = cartDAO.getOrCreateCartId(userId);
        return cartDAO.addItem(cartId, productId, quantity);
    }

    public boolean removeFromCart(int userId, int productId) throws SQLException {
        int cartId = cartDAO.getOrCreateCartId(userId);
        return cartDAO.removeItem(cartId, productId);
    }
    
    public boolean decrementOrRemoveFromCart(int userId, int productId) throws SQLException {
        int cartId = cartDAO.getOrCreateCartId(userId);
        return cartDAO.decrementOrRemoveItem(cartId, productId);
    }

    public boolean clearCart(int userId) throws SQLException {
        Connection conn = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            int cartId = cartDAO.getOrCreateCartId(userId);
            boolean cleared = cartDAO.clearCart(cartId);
            
            if (cleared) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { /* log error */ }
            }
        }
    }

    public int getCartItemCount(int userId) throws SQLException {
        int cartId = cartDAO.getOrCreateCartId(userId);
        return cartDAO.getCartItemCount(cartId);
    }
    
    // Add this method for user registration
    public void createCartForUser(int userId) throws SQLException {
        cartDAO.getOrCreateCartId(userId); // This will create cart if doesn't exist
    }
}