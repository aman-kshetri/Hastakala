<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">

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
        <h2>Sales Report by Category</h2>

        <c:if test="${empty report}">
            <p>No sales data available.</p>
        </c:if>

        <c:if test="${not empty report}">
            <table class="report-table">
                <tr>
                    <th>Category</th>
                    <th>Total Sales</th>
                    <th>Orders</th>
                </tr>
                <c:forEach var="row" items="${report}">
                    <tr>
                        <td>${row[0]}</td>
                        <td>$${row[1]}</td>
                        <td>${row[2]}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
</div>
