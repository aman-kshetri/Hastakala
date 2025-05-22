package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Order;
import model.User;
import service.OrderService;

@WebServlet("/customer/orders")
public class CustomerOrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        this.orderService = new OrderService();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // Check if user is logged in
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Get orders for the current user
        List<Order> orders = orderService.getOrdersByUserId(user.getUserId());

        // Load order items for each order
        for (Order order : orders) {
            order.setItems(orderService.getOrderItemsByOrderId(order.getOrderId()));
        }

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/customer/orders.jsp").forward(req, resp);
    }
}