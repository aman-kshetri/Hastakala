// ProductService.java
package service;

import dao.ProductDAO;
import model.Category;
import model.Product;

import java.util.Comparator;
import java.util.List;

public class ProductService {
    private ProductDAO productDao;
    
    public ProductService() {
        this.productDao = new ProductDAO();
    }
    
    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }
    
    public List<Product> getProductsByCategoryId(int categoryId) {
        return productDao.getProductsByCategoryId(categoryId); // Add this method in ProductDAO
    }

    public List<Category> getAllCategories() {
        return productDao.getAllCategories(); // Add this method in ProductDAO
    }
    
    public Product getProductById(int productId) {
        return productDao.getProductById(productId);
    }
    
    public List<Product> searchProducts(String keyword) {
        return productDao.searchProducts(keyword);
    }


    
    public boolean addProduct(Product product) {
        if (product.getName() == null || product.getName().isEmpty() ||
            product.getPrice() <= 0 || product.getStock() < 0) {
            return false;
        }
        return productDao.addProduct(product);
    }
    
    public boolean updateProduct(Product product) {
        return productDao.updateProduct(product);
    }

    public boolean deleteProduct(int productId) {
        return productDao.deleteProduct(productId);
    }
    
    public List<Product> getAllProductsSortedByCategory() {
        List<Product> allProducts = productDao.getAllProducts();
        allProducts.sort(Comparator.comparing(Product::getCategoryName));
        return allProducts;
    }
}

