// Cart.java
package model;

import java.sql.Timestamp;
import java.util.List;

public class Cart {
    private int cartId;
    private int userId;
    private Timestamp createdAt;
    private List<CartItem> items;
    
    // Constructors, getters, setters
    public Cart() {}
    
    public Cart(int userId) {
        this.userId = userId;
    }

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}
    
    
}