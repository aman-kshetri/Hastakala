package controller;

import model.CartItem;
import model.User;
import service.CartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartService cartService;

    @Override
    public void init() {
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            loadCartData(req, user.getUserId());
            req.getRequestDispatcher("/views/customer/cart.jsp").forward(req, resp);
        } catch (SQLException e) {
            handleError(req, "Error loading cart: " + e.getMessage());
            req.getRequestDispatcher("/views/customer/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            String action = req.getParameter("action");
            
            if (action == null) {
                // Handle cases where form submission doesn't specify action
                if (req.getParameter("product_id") != null) {
                    // Default to "add" if product_id is present but no action
                    handleAddItem(req, user.getUserId());
                } else {
                    handleError(req, "No action specified");
                }
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            switch (action.toLowerCase()) {
                case "remove":
                    handleRemoveItem(req, user.getUserId());
                    break;
                case "clear":
                    handleClearCart(req, user.getUserId());
                    break;
                case "add":
                    handleAddItem(req, user.getUserId());
                    break;
                default:
                    handleError(req, "Invalid action specified");
            }
        } catch (NumberFormatException e) {
            handleError(req, "Invalid product or quantity");
        } catch (SQLException e) {
            handleError(req, "Database error: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    // Helper Methods
    
    private void loadCartData(HttpServletRequest req, int userId) throws SQLException {
        List<CartItem> items = cartService.getCartItems(userId);
        req.setAttribute("items", items);
        
        double grandTotal = calculateGrandTotal(items);
        req.setAttribute("grandTotal", grandTotal);
        
        // Store item count in session for header display
        req.getSession().setAttribute("cartItemCount", items.size());
    }

    private double calculateGrandTotal(List<CartItem> items) {
        return items.stream()
                   .mapToDouble(item -> item.getQuantity() * item.getProduct().getPrice())
                   .sum();
    }

    private void handleRemoveItem(HttpServletRequest req, int userId) throws SQLException {
        int productId = Integer.parseInt(req.getParameter("product_id"));
        boolean success = cartService.decrementOrRemoveFromCart(userId, productId);
        
        if (success) {
            req.getSession().setAttribute("message", 
                cartService.getCartItemCount(userId) == 0 ? 
                "Item removed from cart" : "Item quantity decreased");
        } else {
            handleError(req, "Failed to update cart");
        }
    }

    private void handleClearCart(HttpServletRequest req, int userId) throws SQLException {
        int itemCount = cartService.getCartItemCount(userId);
        
        if (itemCount == 0) {
            req.getSession().setAttribute("message", "Your cart is already empty");
            return;
        }

        boolean cleared = cartService.clearCart(userId);
        
        if (cleared) {
            // Clear cart-related session attributes
            req.getSession().removeAttribute("items");
            req.getSession().setAttribute("cartItemCount", 0);
            req.getSession().setAttribute("message", 
                String.format("Successfully cleared %d item%s from cart", 
                    itemCount, itemCount > 1 ? "s" : ""));
        } else {
            handleError(req, "Failed to clear cart");
        }
    }

    private void handleAddItem(HttpServletRequest req, int userId) throws SQLException {
        int productId = Integer.parseInt(req.getParameter("product_id"));
        int quantity = 1;
        
        String quantityStr = req.getParameter("quantity");
        if (quantityStr != null && !quantityStr.isEmpty()) {
            quantity = Integer.parseInt(quantityStr);
        }

        boolean added = cartService.addToCart(userId, productId, quantity);
        
        if (added) {
            req.getSession().setAttribute("message", "Product added to cart!");
        } else {
            handleError(req, "Failed to add product to cart");
        }
    }

    private void handleError(HttpServletRequest req, String message) {
        req.getSession().setAttribute("error", message);
        System.err.println("Cart Error: " + message);
    }
}