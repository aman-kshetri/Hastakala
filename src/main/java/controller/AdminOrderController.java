package controller;

import model.Order;
import model.OrderItem;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/orders", "/admin/orders/update", "/admin/orders/details"})
public class AdminOrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderService orderService;

    @Override
    public void init() {
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if (path.equals("/admin/orders/details")) {
            // Handle order details view
            try {
                int orderId = Integer.parseInt(req.getParameter("id"));
                Order order = orderService.getOrderById(orderId);
                if (order != null) {
                    List<OrderItem> items = orderService.getOrderItemsByOrderId(orderId);
                    order.setItems(items);
                    req.setAttribute("order", order);
                    req.getRequestDispatcher("/views/admin/order_details.jsp").forward(req, resp);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }
        
        // Default case - show all orders
        List<Order> orders = orderService.getAllOrders();
        for (Order order : orders) {
            List<OrderItem> items = orderService.getOrderItemsByOrderId(order.getOrderId());
            order.setItems(items);
        }
        
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/admin/manage_orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getServletPath().equals("/admin/orders/update")) {
            try {
                int orderId = Integer.parseInt(req.getParameter("order_id"));
                String status = req.getParameter("status");
                
                boolean updated = orderService.updateOrderStatus(orderId, status);
                
                if (updated) {
                    req.getSession().setAttribute("message", "Order #" + orderId + " status updated to " + status);
                } else {
                    req.getSession().setAttribute("error", "Failed to update order #" + orderId);
                }
            } catch (Exception e) {
                System.err.println("Error updating order status: " + e.getMessage());
                e.printStackTrace();
                req.getSession().setAttribute("error", "Error updating order: " + e.getMessage());
            }
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/orders");
    }
}