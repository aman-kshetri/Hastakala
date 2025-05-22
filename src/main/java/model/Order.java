package model;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private User user;
    private String fullName;
    private String email;
    private String phone;
    private String shippingAddress;
    private String paymentMethod;
    private double totalAmount;
    private String status;
    private Timestamp createdAt;
    private List<OrderItem> items;
    
    public Order() {};
    
	public Order(int orderId, int userId, String fullName, String email, String phone, String shippingAddress,
			String paymentMethod, double totalAmount, String status, Timestamp createdAt, List<OrderItem> items) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.fullName = fullName;
		this.email = email;
		this.phone = phone;
		this.shippingAddress = shippingAddress;
		this.paymentMethod = paymentMethod;
		this.totalAmount = totalAmount;
		this.status = status;
		this.createdAt = createdAt;
		this.items = items;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public List<OrderItem> getItems() {
		return items;
	}
	public void setItems(List<OrderItem> items) {
		this.items = items;
	}
	
	public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    
}