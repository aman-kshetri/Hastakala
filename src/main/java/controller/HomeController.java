package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.ProductService;
import model.Product;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductService productService;
    
    @Override
    public void init() {
        productService = new ProductService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Product> featuredProducts = productService.getAllProducts();
        // You could modify this to get truly featured products (e.g., newest, best sellers)
        request.setAttribute("featuredProducts", featuredProducts);
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}