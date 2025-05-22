package controller;

import model.Product;
import service.ProductService;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet({"/products", "/admin/products", "/admin/products/add", "/admin/products/edit", "/admin/products/delete"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;
    private String uploadPath;

    @Override
    public void init() {
        productService = new ProductService();

        // ✅ Use getRealPath("/uploads") to map to webapp/uploads
        this.uploadPath = getServletContext().getRealPath("/uploads");

        File uploadDir = new File(this.uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
            System.out.println("Upload directory created: " + created + " at " + this.uploadPath);
        }

        if (!uploadDir.canWrite()) {
            System.err.println("WARNING: Cannot write to upload directory: " + this.uploadPath);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        String categoryIdParam = req.getParameter("categoryId");
        String searchQuery = req.getParameter("query");

        if (path.equals("/products")) {
            List<Product> products;

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                products = productService.searchProducts(searchQuery.trim());
            } else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                products = productService.getProductsByCategoryId(Integer.parseInt(categoryIdParam));
            } else {
                products = productService.getAllProducts();
            }

            req.setAttribute("products", products);
            req.setAttribute("categories", productService.getAllCategories());
            req.setAttribute("searchQuery", searchQuery); // send back to view
            req.getRequestDispatcher("/views/customer/product.jsp").forward(req, resp);

        } else if (path.equals("/admin/products")) {
            req.setAttribute("products", productService.getAllProducts());
            req.getRequestDispatcher("/views/admin/manage_products.jsp").forward(req, resp);

        } else if (path.equals("/admin/products/add")) {
            req.setAttribute("categories", productService.getAllCategories()); // Add this line
            req.getRequestDispatcher("/views/admin/product_form.jsp").forward(req, resp);

        } else if (path.equals("/admin/products/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getProductById(id);
            req.setAttribute("product", product);
            req.setAttribute("categories", productService.getAllCategories()); // Add this line
            req.getRequestDispatcher("/views/admin/product_form.jsp").forward(req, resp);

        } else if (path.equals("/admin/products/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.deleteProduct(id);
                req.getSession().setAttribute("message", "Product deleted successfully.");
            } catch (Exception e) {
                req.getSession().setAttribute("error", "Cannot delete product. It may be part of an order.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Product product = new Product();
        product.setName(req.getParameter("name"));
        product.setDescription(req.getParameter("description"));
        product.setPrice(Double.parseDouble(req.getParameter("price")));
        product.setStock(Integer.parseInt(req.getParameter("stock")));
        product.setCategoryId(Integer.parseInt(req.getParameter("category_id")));

        Part imagePart = req.getPart("imageFile");
        String fileName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            String contentType = imagePart.getContentType();
            if (!contentType.startsWith("image/")) {
                req.getSession().setAttribute("error", "Only image files are allowed");
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String extension = originalFileName.contains(".") ?
                    originalFileName.substring(originalFileName.lastIndexOf(".")) : "";
            fileName = System.currentTimeMillis() + "_" + originalFileName.replaceAll("[^a-zA-Z0-9.-]", "_");

            File file = new File(this.uploadPath + File.separator + fileName);
            imagePart.write(file.getAbsolutePath());

            fileName = "uploads/" + fileName.replace(File.separator, "/"); // relative path
        }

        String idParam = req.getParameter("productId");
        try {
            if (idParam != null && !idParam.isEmpty()) {
                product.setProductId(Integer.parseInt(idParam));
                if (fileName != null) {
                    product.setImageUrl(fileName);
                } else {
                    product.setImageUrl(req.getParameter("existingImageUrl"));
                }
                productService.updateProduct(product);
            } else {
                product.setImageUrl(fileName != null ? fileName : "images/default-product.png");
                productService.addProduct(product);
            }
            req.getSession().setAttribute("message", "Product saved successfully");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error saving product: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
