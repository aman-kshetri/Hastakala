package controller;

import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/report")
public class AdminReportController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("totalOrders", orderService.getTotalOrders());
        req.setAttribute("totalRevenue", orderService.getTotalRevenue());
        req.setAttribute("totalCustomers", orderService.getTotalCustomers());
        req.setAttribute("report", orderService.getSalesReportByCategory());

        req.getRequestDispatcher("/views/admin/report.jsp").forward(req, resp);
    }

}
