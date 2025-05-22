<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />

<style>
    .cart-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }
    .cart-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    .cart-table th, .cart-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    .cart-table th {
        background-color: #f2f2f2;
    }
    .product-img {
        width: 50px;
        height: 50px;
        object-fit: cover;
        margin-right: 10px;
    }
    .btn {
        padding: 8px 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }
    .btn-remove {
        background-color: #f44336;
        color: white;
    }
    .btn-add {
        background-color: #4CAF50;
        color: white;
    }
    .btn-clear {
        background-color: #ff9800;
        color: white;
    }
    .btn-checkout {
        background-color: #2196F3;
        color: white;
    }
    .btn-continue {
        background-color: #2196F3;
        color: white;
    }
    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border: 1px solid transparent;
        border-radius: 4px;
    }
    .alert-success {
        color: #3c763d;
        background-color: #dff0d8;
        border-color: #d6e9c6;
    }
    .alert-danger {
        color: #a94442;
        background-color: #f2dede;
        border-color: #ebccd1;
    }
</style>

<div class="cart-container">
    <h2>Your Shopping Cart</h2>
    
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
        <c:remove var="message" scope="session" />
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
        <c:remove var="error" scope="session" />
    </c:if>

    <c:if test="${empty items}">
        <p>Your cart is empty.</p>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-continue">Continue Shopping</a>
    </c:if>

    <c:if test="${not empty items}">
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td>
                            <img src="${pageContext.request.contextPath}/${not empty item.product.imageUrl ? item.product.imageUrl : 'images/default-product.png'}" 
     class="product-img" 
     alt="${item.product.name}" />
                            ${item.product.name}
                        </td>
                        <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="$" /></td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.quantity * item.product.price}" type="currency" currencySymbol="$" /></td>
                        <td>
                            <td>
    <form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline;">
        <input type="hidden" name="product_id" value="${item.product.productId}" />
        <input type="hidden" name="action" value="remove" />
        <button type="submit" class="btn btn-sm btn-danger">-</button>
    </form>
    
    <span style="margin:0 5px;">${item.quantity}</span>
    
    <form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline;">
        <input type="hidden" name="product_id" value="${item.product.productId}" />
        <input type="hidden" name="action" value="add" />
        <button type="submit" class="btn btn-sm btn-success">+</button>
    </form>
</td>
               
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3" style="text-align: right;"><strong>Grand Total:</strong></td>
                    <td><strong><fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="$" /></strong></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>

        <div style="margin-top: 20px;">
            <form method="post" action="${pageContext.request.contextPath}/cart" style="display: inline-block; margin-right: 10px;">
                <input type="hidden" name="action" value="clear" />
                <button type="submit" class="btn btn-clear">Clear Cart</button>
            </form>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-continue">Continue Shopping</a>
			<form action="${pageContext.request.contextPath}/checkout" method="get" style="display: inline; float: right;">
    <button type="submit" class="btn btn-checkout">Proceed to Checkout</button>
    </form>
        </div>
    </c:if>
</div>

<jsp:include page="../common/footer.jsp" />