package controller;

import model.User;
import model.CartItem;  // Add this import
import service.CartService;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;  // Add this import

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CartService cartService;
    private OrderService orderService;

    @Override
    public void init() {
        cartService = new CartService();
        orderService = new OrderService();
    }

    // Handle GET requests (showing the checkout page)
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<CartItem> items = cartService.getCartItems(user.getUserId());
            if (items == null || items.isEmpty()) {
                session.setAttribute("error", "Your cart is empty");
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            double grandTotal = items.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();

            req.setAttribute("items", items);
            req.setAttribute("grandTotal", grandTotal);
            req.getRequestDispatcher("/views/customer/checkout.jsp").forward(req, resp);

        } catch (SQLException e) {
            session.setAttribute("error", "Error loading checkout: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            String shippingAddress = req.getParameter("shippingAddress");
            String paymentMethod = req.getParameter("paymentMethod");
            
            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                req.setAttribute("error", "Shipping address is required");
                doGet(req, resp);
                return;
            }

            List<CartItem> items = cartService.getCartItems(user.getUserId());
            double totalAmount = items.stream()
                .mapToDouble(item -> item.getQuantity() * item.getProduct().getPrice())
                .sum();

            // Use user details from session
            int orderId = orderService.placeOrder(
                user.getUserId(),
                user.getName(),    // Full name from user object
                user.getEmail(),   // Email from user object
                user.getPhone(),   // Phone from user object
                shippingAddress,
                paymentMethod,
                totalAmount
            );

            if (orderId > 0) {
                resp.sendRedirect(req.getContextPath() + "/order-confirmation?id=" + orderId);
            } else {
                req.setAttribute("error", "Failed to place order");
                doGet(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            doGet(req, resp);
        }
    }
}