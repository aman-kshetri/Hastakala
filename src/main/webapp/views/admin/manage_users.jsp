<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage_users.css">

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
			<h2 class="table-title">Manage Users</h2>

			<table class="data-table">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Role</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="u" items="${users}">
						<tr>
							<td>${u.userId}</td>
							<td>${u.name}</td>
							<td>${u.email}</td>
							<td>
								<form method="post"
									action="${pageContext.request.contextPath}/admin/users"
									style="display: inline;">
									<input type="hidden" name="user_id" value="${u.userId}" /> <select
										name="role" class="form-select">
										<option value="CUSTOMER"
											${u.role == 'CUSTOMER' ? 'selected' : ''}>CUSTOMER</option>
										<option value="ADMIN" ${u.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
									</select> <input type="hidden" name="action" value="role" />
									<button type="submit" class="btn btn-primary btn-sm">Update</button>
								</form>
							</td>
							<td>
								<form method="post"
									action="${pageContext.request.contextPath}/admin/users"
									onsubmit="return confirm('Are you sure you want to delete this user?');"
									style="display: inline;">
									<input type="hidden" name="user_id" value="${u.userId}" /> <input
										type="hidden" name="action" value="delete" />
									<button type="submit" class="btn btn-danger btn-sm">Delete</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>