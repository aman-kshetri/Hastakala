<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashboard.css">

<jsp:include page="../common/header.jsp" />


<div class="admin-container">
    <!-- Left Sidebar Navigation -->
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
    
    <!-- Right Main Content Area -->
    <div class="admin-content">
        <h2>Admin Dashboard</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Orders</h3>
                <div class="stat-value">${totalOrders}</div>
            </div>
            
            <div class="stat-card">
                <h3>Total Products</h3>
                <div class="stat-value">${totalProducts}</div>
            </div>
            
            <div class="stat-card">
                <h3>Total Categories</h3>
                <div class="stat-value">${totalCategories}</div>
            </div>
            
            <div class="stat-card">
                <h3>Total Customers</h3>
                <div class="stat-value">${totalCustomers}</div>
            </div>
            
            <div class="stat-card">
                <h3>Total Revenue</h3>
                <div class="stat-value"><fmt:formatNumber value="${totalRevenue}" type="currency"/></div>
            </div>
        </div>

        <div class="orders-card">
            <h2>Recent Orders</h3>
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${recentOrders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.user.name}</td>
                            <td><fmt:formatDate value="${order.createdAt}" pattern="MMM d, yyyy"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency"/></td>
                            <td>
                                <span class="status status-${order.status.toLowerCase()}">
                                    ${order.status}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

