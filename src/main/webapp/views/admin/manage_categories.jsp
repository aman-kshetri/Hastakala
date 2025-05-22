<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage_categories.css">
<jsp:include page="../common/header.jsp" />

<div class="admin-container">
	<!-- Left Sidebar Navigation -->
	<div class="admin-sidebar">
		<ul>
			<li><a href="${pageContext.request.contextPath}/admin/dashboard">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/products">Manage
					Products</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/categories">Manage
					Categories</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/users">Manage
					Users</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/orders">Manage
					Orders</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/report">Sales
					Report</a></li>
		</ul>
	</div>

	<!-- Right Main Content Area -->
	<div class="admin-content">
		<div class="table-card">
			<h2 class="table-title">Manage Categories</h2>

			<form method="post"
				action="${pageContext.request.contextPath}/admin/categories"
				class="form-group">
				<input type="hidden" name="action" value="add" /> <input
					type="text" name="name" placeholder="Category Name" required
					class="form-control" /> <input type="text" name="description"
					placeholder="Description" class="form-control"
					style="margin-top: 10px;" />
				<button type="submit" class="btn btn-primary"
					style="margin-top: 10px;">Add Category</button>
			</form>

			<table class="data-table">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Description</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cat" items="${categories}">
						<tr>
							<td>${cat.categoryId}</td>
							<td>${cat.name}</td>
							<td>${cat.description}</td>
							<td>
								<form method="post"
									action="${pageContext.request.contextPath}/admin/categories"
									style="display: inline;">
									<input type="hidden" name="action" value="delete" /> <input
										type="hidden" name="id" value="${cat.categoryId}" />
									<button type="submit" class="btn btn-danger">Delete</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>