package service;

import dao.UserDAO;
import dao.CartDAO;
import model.User;
import util.PasswordUtil;
import util.Validator;

public class AuthService {
    private UserDAO userDao;
    private CartDAO cartDao;

    public AuthService() {
        this.userDao = new UserDAO();
        this.cartDao = new CartDAO();
    }

    public User login(String email, String password) {
        if (!Validator.validateEmail(email) || !Validator.validatePassword(password)) {
            return null;
        }

        User user = userDao.getUserByEmail(email);
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public boolean register(User user) {
        if (!Validator.validateEmail(user.getEmail()) || 
            !Validator.validatePassword(user.getPassword()) || 
            !Validator.validateName(user.getName())) {
            return false;
        }

        if (userDao.getUserByEmail(user.getEmail()) != null) {
            return false; // Email already exists
        }

        // Hash password before saving
        String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);

        try {
            // Create user
            boolean userCreated = userDao.createUser(user);
            if (!userCreated) {
                return false;
            }

            // Get the newly created user with ID
            User newUser = userDao.getUserByEmail(user.getEmail());
            if (newUser == null) {
                return false;
            }

            // Create cart for the new user
            cartDao.getOrCreateCartId(newUser.getUserId());
            
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}