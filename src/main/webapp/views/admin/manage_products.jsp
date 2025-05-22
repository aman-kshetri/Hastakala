<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage_products.css">

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
        <div class="table-card">
            <h2 class="table-title">Manage Products</h2>
            
            <a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-primary">Add New Product</a>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.name}</td>
                            <td><fmt:formatNumber value="${p.price}" type="currency"/></td>
                            <td>${p.stock}</td>
                            <td>${p.categoryId}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.productId}" class="btn btn-primary btn-sm">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/products/delete?id=${p.productId}" 
                                   class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Delete this product?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>