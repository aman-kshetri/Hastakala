<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage_order.css">


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
        <div class="table-card">
            <h2 class="table-title">All Orders</h2>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Payment</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <tr>
                                <td colspan="7" style="text-align: center;">No orders found in database</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td>${order.fullName} (${order.email})</td>
                                    <td><fmt:formatNumber value="${order.totalAmount}" type="currency"/></td>
                                    <td>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/orders/update" class="status-form">
                                            <input type="hidden" name="order_id" value="${order.orderId}" />
                                            <select name="status" class="status-select">
                                                <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                                <option value="PROCESSING" ${order.status == 'PROCESSING' ? 'selected' : ''}>PROCESSING</option>
                                                <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>SHIPPED</option>
                                                <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                                                <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                            </select>
                                            <button type="submit" class="btn btn-success btn-sm">Update</button>
                                        </form>
                                    </td>
                                    <td>${order.paymentMethod}</td>
                                    <td><fmt:formatDate value="${order.createdAt}" pattern="MMM d, yyyy"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/orders/details?id=${order.orderId}" 
                                           class="btn btn-primary btn-sm">Details</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>