<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/views/common/header.jsp" />

<div class="container">
	<h2 class="page-title">Our Handcrafted Products</h2>

	<c:if test="${not empty message}">
		<div class="alert alert-success">${message}</div>
		<c:remove var="message" scope="session" />
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger">${error}</div>
		<c:remove var="error" scope="session" />
	</c:if>


	<div class="filter-container">
		<form method="get"
			action="${pageContext.request.contextPath}/products"
			class="filter-form">
			<label for="category" class="filter-label">Category:</label> <select
				name="categoryId" id="category" class="filter-select">
				<option value="">All</option>
				<c:forEach var="category" items="${categories}">
					<option value="${category.categoryId}"
						<c:if test="${category.categoryId == param.categoryId}">selected</c:if>>
						${category.name}</option>
				</c:forEach>
			</select>
			<button type="submit" class="filter-button">Filter</button>
		</form>
	</div>

	<div class="products-container">
		<c:forEach var="product" items="${products}">
			<div class="product-card">
				<img src="${pageContext.request.contextPath}/${product.imageUrl}"
					alt="${product.name}" class="product-image" />
				<h3 class="product-name">${product.name}</h3>
				<p class="product-description">${product.description}</p>
				<p class="product-price">
					<strong><fmt:formatNumber value="${product.price}"
							type="currency" currencySymbol="$" /></strong>
				</p>
				<form method="post" action="${pageContext.request.contextPath}/cart">
					<input type="hidden" name="product_id" value="${product.productId}" />
					<input type="hidden" name="action" value="add" /> <input
						type="hidden" name="quantity" value="1" />
					<button type="submit" class="add-to-cart-button">Add to
						Cart</button>
				</form>
			</div>
		</c:forEach>
	</div>
</div>

<style>
	body, html {
        height: 100%;
        margin: 0;
    }
    
    * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

	.container {
		max-width: 1100px;
		margin: 0 auto;
		padding: 20px;
	}

	.page-title {
		font-size: 2rem;
		margin-bottom: 20px;
		text-align: center;
	}

	.alert {
		padding: 10px;
		margin-bottom: 15px;
		border-radius: 5px;
	}

	.alert-success {
		background-color: #d4edda;
		color: #155724;
		border: 1px solid #c3e6cb;
	}

	.alert-danger {
		background-color: #f8d7da;
		color: #721c24;
		border: 1px solid #f5c6cb;
	}

	.filter-container {
		display: flex;
		justify-content: center;
		margin-bottom: 20px;
	}

	.filter-form {
		display: flex;
		align-items: center;
		gap: 10px;
	}

	.filter-label {
		font-size: 1rem;
		font-weight: bold;
	}

	.filter-select {
		padding: 8px;
		border: 1px solid #ccc;
		border-radius: 5px;
		font-size: 1rem;
	}

	.filter-button {
		padding: 8px 16px;
		background-color: #007bff;
		color: white;
		border: none;
		border-radius: 5px;
		font-size: 1rem;
		cursor: pointer;
	}

	.filter-button:hover {
		background-color: #0056b3;
	}

	.products-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	justify-content: center; /* Center cards if fewer columns */
	gap: 40px;
	margin-top: 20px;
}

.product-card {
	background-color: white;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	align-items: center;
	max-width: 300px; /* Add fixed max width */
	width: 100%;
	margin: 0 auto; /* Optional: extra centering */
}
	

	.product-image {
		width: 100%;
		height: 300px;
		object-fit: cover;
		border-radius: 5px;
		margin-bottom: 10px;
	}

	.product-name {
		font-size: 1.2rem;
		margin-bottom: 10px;
	}

	.product-description {
		font-size: 1rem;
		color: #555;
		margin-bottom: 10px;
	}

	.product-price {
		font-size: 1.2rem;
		font-weight: bold;
		margin-bottom: 15px;
		color: #007bff;
	}

	.add-to-cart-button {
		padding: 10px 20px;
		background-color: #007bff;
		color: white;
		border: none;
		border-radius: 5px;
		font-size: 1rem;
		cursor: pointer;
		transition: background-color 0.3s ease;
		width: 100%; /* Make button fill the width of the card */
	}

	.add-to-cart-button:hover {
		background-color: #0056b3;
	}
</style>

<jsp:include page="/views/common/footer.jsp" />