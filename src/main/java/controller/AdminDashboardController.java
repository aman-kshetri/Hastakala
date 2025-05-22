package controller;

import model.Order;
import service.CategoryService;
import service.OrderService;
import service.ProductService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductService productService;
    private CategoryService categoryService;
    private UserService userService;
    private OrderService orderService;

    @Override
    public void init() {
        productService = new ProductService();
        categoryService = new CategoryService();
        userService = new UserService();
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int totalProducts = productService.getAllProducts().size();
            int totalCategories = categoryService.getAllCategories().size();
            int totalCustomers = userService.getCustomerCount(); // Only CUSTOMERs
            int totalOrders = orderService.getTotalOrders();
            double totalRevenue = orderService.getTotalRevenue();
            List<Order> recentOrders = orderService.getRecentOrders(5); // Fetch last 5 orders

            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalCategories", totalCategories);
            req.setAttribute("totalCustomers", totalCustomers);
            req.setAttribute("totalOrders", totalOrders);
            req.setAttribute("totalRevenue", totalRevenue);
            req.setAttribute("recentOrders", recentOrders);

            req.getRequestDispatcher("/views/admin/admin_dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/admin_dashboard.jsp").forward(req, resp);
        }
    }
}
