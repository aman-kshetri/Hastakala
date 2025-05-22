<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />

<div class="container mt-4">
    <c:choose>
        <c:when test="${not empty order}">
            <div class="card">
                <div class="card-header success-header">
                    <h4>Order Confirmation #${order.orderId}</h4>
                </div>
                <div class="card-body">
                    <div class="alert alert-success">
                        <h4>Thank you for your order!</h4>
                        <p>Your order has been placed successfully.</p>
                    </div>

                    <div class="row order-details">
                        <div class="col-md-6 order-summary-section">
                            <h5>Order Summary</h5>
                            <table class="order-summary-table">
                                <c:forEach items="${order.items}" var="item">
                                    <tr>
                                        <td>${item.quantity} x Product ID ${item.productId}</td>
                                        <td><fmt:formatNumber value="${item.price}" type="currency"/></td>
                                    </tr>
                                </c:forEach>
                                <tr class="font-weight-bold">
                                    <td>Total:</td>
                                    <td><fmt:formatNumber value="${order.totalAmount}" type="currency"/></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-6 shipping-info-section">
                            <h5>Shipping Information</h5>
                            <p class="shipping-address">${order.shippingAddress}</p>
                            <p>Payment Method: ${order.paymentMethod}</p>
                            <p>Status: ${order.status}</p>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary continue-shopping-btn">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-danger">
                <h4>Order Not Found</h4>
                <p>We couldn't find your order details. Please check your order history.</p>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary view-orders-btn">
                    View My Orders
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}

.card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.card-header {
  padding: 15px;
  border-bottom: 1px solid #ddd;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}

.success-header{
    background-color: #28a745;
    color: #fff;
}

.card-body {
  padding: 20px;
}

.alert {
  padding: 15px;
  border-radius: 8px;
  margin-bottom: 20px;
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

h4 {
  margin-top: 0;
  margin-bottom: 10px;
}


.row {
  display: flex;
  flex-wrap: wrap;
  margin-left: -15px;
  margin-right: -15px;
  justify-content: center; /* Center the columns */
}
.col-md-6{
    flex: 0 0 50%;
    max-width: 50%;
    padding-left: 15px;
    padding-right: 15px;
}

.order-summary-section, .shipping-info-section {
    /*width: 400px;  Adjust as needed */
    margin-right: 20px; /* Add spacing between the two sections */
    margin-bottom: 20px; /* Add spacing below  */
}


.order-summary-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

.order-summary-table th,
.order-summary-table td {
  padding: 8px;
  border-bottom: 1px solid #ddd;
}

.order-summary-table th {
  text-align: left;
}

.order-summary-table .font-weight-bold {
  font-weight: bold;
}

.shipping-address {
  margin-bottom: 10px;
  white-space: pre-line;
}

.btn {
  display: inline-block;
  padding: 10px 20px;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.3s ease, color 0.3s ease;
}

.btn-primary {
  background-color: #007bff;
  color: #fff;
}

.btn-primary:hover {
  background-color: #0056b3;
}
.btn-secondary {
  background-color: #6c757d;
  color: #fff;
}

.btn-secondary:hover {
  background-color: #5a6268;
}

.continue-shopping-btn{
    margin-top: 20px;
}
.view-orders-btn{
    margin-top: 20px;
}

/* Responsive */
@media (max-width: 768px) {
  .row {
    flex-direction: column;
  }
  .col-md-6 {
    flex: 0 0 100%;
    max-width: 100%;
}
.order-summary-section, .shipping-info-section{
    margin-right: 0;
}
}
</style>

<jsp:include page="../common/footer.jsp" />
