package controller;

import model.Category;
import service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class CategoryController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CategoryService categoryService;

    @Override
    public void init() {
        categoryService = new CategoryService();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/views/admin/manage_categories.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            categoryService.addCategory(new Category(name, description));
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryService.deleteCategory(id);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            categoryService.updateCategory(new Category(id, name, description));
        }

        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
