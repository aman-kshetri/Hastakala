<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common/header.jsp" />

<div class="container">
	<h2 class="page-title">Checkout</h2>
	<c:choose>
		<c:when test="${empty items and empty sessionScope.checkoutItems}">
			<div class="alert alert-warning">
				Your cart is empty. <a href="${pageContext.request.contextPath}/products"
					class="alert-link">Continue shopping</a>
			</div>
		</c:when>
		<c:otherwise>
			<c:set var="displayItems"
				value="${not empty items ? items : sessionScope.checkoutItems}" />
			<div class="row justify-content-center">
				<div class="col-md-7" style="margin-right: 20px;">
					<div class="card">
						<div class="card-header">
							<h4>Shipping Information</h4>
						</div>
						<div class="card-body">
							<form action="${pageContext.request.contextPath}/checkout"
								method="post">
								<div class="form-group">
									<label>Full Name</label> <input type="text"
										class="form-control" value="${user.name}" readonly>
								</div>
								<div class="form-group">
									<label>Email</label> <input type="email" class="form-control"
										value="${user.email}" readonly>
								</div>
								<div class="form-group">
									<label>Phone</label> <input type="text" class="form-control"
										value="${user.phone}" readonly>
								</div>
								<div class="form-group">
									<label>Shipping Address*</label>
									<textarea name="shippingAddress" class="form-control"
										rows="3" required></textarea>
								</div>
								<div class="form-group">
									<label>Payment Method*</label> <select name="paymentMethod"
										class="form-control" required>
										<option value="COD">Cash on Delivery</option>
										<option value="CREDIT_CARD">Credit Card</option>
										<option value="PAYPAL">PayPal</option>
									</select>
								</div>
								<div class="form-group">
									<input type="submit" value="Place Order"
										class="btn btn-primary btn-block btn-lg">
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-5">
					<div class="card">
						<div class="card-header">
							<h4>Order Summary</h4>
						</div>
						<div class="card-body">
							<table class="table">
								<thead>
									<tr>
										<th>Product</th>
										<th>Qty</th>
										<th>Price</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${items}">
										<tr>
											<td>${item.product.name}</td>
											<td>${item.quantity}</td>
											<td><fmt:formatNumber value="${item.product.price}"
													type="currency" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<hr>
							<div class="summary-item">
								<h5>Subtotal:</h5>
								<h5>
									<fmt:formatNumber value="${grandTotal}" type="currency" />
								</h5>
							</div>
							<div class="summary-item">
								<h5>Shipping:</h5>
								<h5>
									<fmt:formatNumber value="0" type="currency" />
								</h5>
							</div>
							<hr>
							<div class="summary-item total">
								<h4>Total:</h4>
								<h4 class="text-success">
									<fmt:formatNumber value="${grandTotal}" type="currency" />
								</h4>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<style>
.container {
	max-width: 1200px;
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

.alert-warning {
	background-color: #fff3cd;
	border-color: #ffeeba;
	color: #856404;
}

.alert-warning .alert-link {
	color: #634400;
	text-decoration: underline;
}

.row {
	display: flex;
	flex-wrap: wrap;
	margin-left: -15px;
	margin-right: -15px;
    justify-content: center; /* Center the columns */
}

.col-md-7 {
	flex: 0 0 58.333333%;
	max-width: 58.333333%;
	padding-left: 15px;
	padding-right: 15px;
}

.col-md-5 {
	flex: 0 0 41.666667%;
	max-width: 41.666667%;
	padding-left: 15px;
	padding-right: 15px;
}

.card {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-bottom: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
	background-color: #007bff;
	color: white;
	padding: 10px 15px;
	border-bottom: 1px solid #007bff;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}

.card-header h4 {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 1.5rem;
}

.card-body {
	padding: 15px;
}

.form-group {
	margin-bottom: 15px;
	margin-right: 30px
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #555;
}

.form-control {
	display: block;
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 1rem;
	transition: border-color 0.3s ease;
}

.form-control:focus {
	outline: none;
	border-color: #007bff;
	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.form-control:readonly {
	background-color: #e9ecef;
	cursor: not-allowed;
}

textarea.form-control {
	resize: vertical;
	height: auto;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	font-size: 1rem;
	cursor: pointer;
	transition: background-color 0.3s ease;
	width: 100%;
	text-align: center;
}

.btn-primary {
	background-color: #007bff;
	color: white;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-lg {
	padding: 15px 25px;
	font-size: 1.2rem;
}

.btn-block {
	display: block;
}

.table {
	width: 100%;
	max-width: 100%;
	margin-bottom: 1rem;
	background-color: transparent;
	border-collapse: collapse;
}

.table th, .table td {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.table thead th {
	vertical-align: bottom;
	border-bottom: 2px solid #dee2e6;
}

.table tbody+tbody {
	border-top: 2px solid #dee2e6;
}

.table-borderless th, .table-borderless td, .table-borderless {
	border: 0;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
}

.summary-item h5 {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 1.1rem;
	font-weight: bold;
}

.summary-item.total h4 {
	font-size: 1.5rem;
	color: #28a745;
}

.text-success {
    color: #28a745;
}

/* Responsive Styles */
@media ( max-width: 768px) {
	.col-md-7, .col-md-5 {
		flex: 100%;
		max-width: 100%;
	}
	.row {
		margin-left: 0;
		margin-right: 0;
	}
	.col-md-7 {
		padding-left: 0;
		padding-right: 0;
	}
	.col-md-5 {
		padding-left: 0;
		padding-right: 0;
	}
}
</style>

<jsp:include page="../common/footer.jsp" />
