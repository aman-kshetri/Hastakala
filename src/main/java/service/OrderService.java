package service;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;

import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private final OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }
    
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        return orderDAO.getOrderItemsByOrderId(orderId);
    }

    public List<Order> getAllOrders() {
        List<Order> orders = orderDAO.getAllOrders();
        return orders;
    }
    
    public List<Order> getRecentOrders(int limit) {
        return orderDAO.getRecentOrders(limit);
    }


    public List<Order> getOrdersByUserId(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }

    public double getTotalRevenue() {
        return orderDAO.getTotalRevenue();
    }

    public int getTotalOrders() {
        return orderDAO.getTotalOrders();
    }

    public int getTotalCustomers() {
        return orderDAO.getTotalCustomers();
    }
    
    public List<Object[]> getSalesReportByCategory() {
        return orderDAO.getSalesReportByCategory();
    }
    
    public int placeOrder(int userId, String fullName, String email, String phone,
            String shippingAddress, String paymentMethod, 
            double totalAmount) {
try {
return orderDAO.createOrder(
   userId,
   fullName,
   email,
   phone,
   shippingAddress,
   paymentMethod,
   totalAmount
);
} catch (SQLException e) {
e.printStackTrace();
return -1;
}
}
    
    public Order getOrderById(int orderId) throws SQLException {
        return orderDAO.getOrderById(orderId);
    }
    
    public List<Order> getActiveOrders() {
        return orderDAO.getAllOrders();
    }

    public List<Order> getAllOrdersIncludingDelivered() {
        return orderDAO.getAllOrdersIncludingDelivered();
    }

public Order getOrderDetails(int orderId) throws SQLException {
return orderDAO.getOrderById(orderId);
}
}

