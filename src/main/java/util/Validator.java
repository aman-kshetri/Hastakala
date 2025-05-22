// Validator.java
package util;

import model.Product;

public class Validator {
    public static boolean validateEmail(String email) {
        return email != null && email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
    }
    
    public static boolean validatePassword(String password) {
        return password != null && password.length() >= 6;
    }
    
    public static boolean validateName(String name) {
        return name != null && !name.trim().isEmpty();
    }
    
    public static boolean validateProduct(Product product) {
        return product != null && 
               validateName(product.getName()) &&
               product.getPrice() > 0 &&
               product.getStock() >= 0;
    }
}