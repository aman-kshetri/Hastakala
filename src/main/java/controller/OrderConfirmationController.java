package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Order;
import model.OrderItem;
import service.OrderService;

@WebServlet("/order-confirmation")
public class OrderConfirmationController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("id"));
            Order order = orderService.getOrderById(orderId);
            
            if (order != null) {
                List<OrderItem> items = orderService.getOrderItemsByOrderId(orderId);
                order.setItems(items);
                req.setAttribute("order", order);
                req.getRequestDispatcher("/views/customer/orderConfirmation.jsp")
                   .forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/checkout?error=order_not_found");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/checkout?error=invalid_order_id");
        } catch (SQLException e) {
            resp.sendRedirect(req.getContextPath() + "/checkout?error=database_error");
        }
    }
}