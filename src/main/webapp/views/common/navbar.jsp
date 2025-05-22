<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar">
	<!-- Common: Logo on the left -->
	<div class="nav-left">
		<a href="${pageContext.request.contextPath}/" class="logo">Hastakala</a>
	</div>

	<!-- Guest (Default) View -->
	<c:if test="${empty sessionScope.user}">
		<div class="nav-center">
			<a href="${pageContext.request.contextPath}/common/about-us">About
				Us</a> <a href="${pageContext.request.contextPath}/common/contact-us">Contact
				Us</a>
		</div>
		<div class="nav-right">
			<a href="${pageContext.request.contextPath}/auth/login">Login</a> <a
				href="${pageContext.request.contextPath}/auth/register">Register</a>
		</div>
	</c:if>

	<!-- Customer View -->
	<!-- Customer View -->
<c:if test="${sessionScope.user != null && sessionScope.user.role == 'CUSTOMER'}">
	<div class="nav-center">
		<a href="${pageContext.request.contextPath}/products">Browse</a>
		<a href="${pageContext.request.contextPath}/cart">Cart</a>
		<a href="${pageContext.request.contextPath}/customer/profile">Profile</a>
		<a href="${pageContext.request.contextPath}/common/about-us">About Us</a>

		<!-- Search Form -->
		<form method="get" action="${pageContext.request.contextPath}/products" style="display: flex; gap: 0.5rem;">
    <input type="text" name="query" placeholder="Search products..." value="${param.query}" 
           style="padding: 0.4rem; border: 1px solid #ccc; border-radius: 4px; width: 200px;" />
    <button type="submit" style="padding: 0.4rem 0.8rem; border: none; background-color: #007b5e; color: white; border-radius: 4px; cursor: pointer;">
        Search
    </button>
</form>
	</div>

	<div class="nav-right">
		<form method="post" action="${pageContext.request.contextPath}/auth/logout" style="display: inline;">
			<button type="submit" class="logout-btn">Logout</button>
		</form>
	</div>
</c:if>
	

	<!-- Admin View -->
	<c:if
		test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
		<div class="nav-center">
			<span class="welcome-msg">Welcome, admin: ${sessionScope.user.name}</span>
		</div>
		<div class="nav-right">
			<form method="post"
				action="${pageContext.request.contextPath}/auth/logout"
				style="display: inline;">
				<button type="submit" class="logout-btn">Logout</button>
			</form>

		</div>
	</c:if>
</nav>
<style>
.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #f5f5f5;
	padding: 1rem 2rem;
	border-bottom: 1px solid #ccc;
}

.nav-left, .nav-center, .nav-right {
	display: flex;
	align-items: center;
	gap: 1.5rem;
}

.nav-left .logo {
	font-size: 1.5rem;
	font-weight: bold;
	color: #007b5e;
	text-decoration: none;
}

.nav-center a, .nav-right a {
	text-decoration: none;
	color: #333;
	font-weight: 500;
}

.nav-right form {
	margin: 0;
}

.logout-btn {
	background: none;
	border: none;
	color: #d9534f;
	font-weight: 500;
	cursor: pointer;
	padding: 0.5rem 1rem;
}

.navbar form input[type="text"]:focus {
    outline: none;
    border-color: #007b5e;
}
.navbar form button:hover {
    background-color: #005f4a;
}

.dropdown-toggle {
	background: none;
	border: none;
	font-weight: 500;
	cursor: pointer;
}

.dropdown-menu {
	position: absolute;
	top: 100%;
	right: 0;
	display: none;
	background: white;
	list-style: none;
	padding: 0.5rem 0;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
}

.dropdown:hover .dropdown-menu {
	display: block;
}

.dropdown-menu li {
	padding: 0.5rem 1rem;
}
</style>