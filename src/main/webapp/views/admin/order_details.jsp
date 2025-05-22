<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order_details.css">

<div class="admin-container">
    <div class="admin-sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products">Manage Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/categories">Manage Categories</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/report">Sales Report</a></li>
        </ul>
    </div>
    
    <div class="admin-content">
        <div class="detail-card">
            <h2 class="detail-title">Order Details #${order.orderId}</h2>
            
            <h3 class="section-title">Customer Information</h3>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Name:</span>
                    <span class="info-value">${order.fullName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${order.email}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Phone:</span>
                    <span class="info-value">${order.phone}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Shipping Address:</span>
                    <span class="info-value">${order.shippingAddress}</span>
                </div>
            </div>
            
            <h3 class="section-title">Order Information</h3>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Status:</span>
                    <span class="info-value">
                        <span class="status status-${order.status.toLowerCase()}">${order.status}</span>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Payment Method:</span>
                    <span class="info-value">${order.paymentMethod}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Order Date:</span>
                    <span class="info-value"><fmt:formatDate value="${order.createdAt}" pattern="MMM d, yyyy hh:mm a"/></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Total Amount:</span>
                    <span class="info-value"><fmt:formatNumber value="${order.totalAmount}" type="currency"/></span>
                </div>
            </div>
            
            <h3 class="section-title">Order Items</h3>
            <table class="items-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th class="text-right">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td>${item.productName}</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price}" type="currency"/></td>
                            <td class="text-right"><fmt:formatNumber value="${item.price * item.quantity}" type="currency"/></td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="3" class="text-right"><strong>Total:</strong></td>
                        <td class="text-right"><strong><fmt:formatNumber value="${order.totalAmount}" type="currency"/></strong></td>
                    </tr>
                </tbody>
            </table>
            
            <div style="margin-top: 25px; text-align: right;">
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-primary">Back to Orders</a>
            </div>
        </div>
    </div>
</div>
