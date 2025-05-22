<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../common/header.jsp" />
<h2>${product.name}</h2>

<img src="${pageContext.request.contextPath}/${product.imageUrl}" width="150" alt="${product.name}" />
<p>${product.description}</p>
<p><strong>Price:</strong> $${product.price}</p>

<form method="post" action="${pageContext.request.contextPath}/cart">
    <input type="hidden" name="product_id" value="${product.productId}" />
    <label>Quantity:</label>
    <input type="number" name="quantity" value="1" min="1"/>
    <button type="submit">Add to Cart</button>
</form>

<jsp:include page="../common/footer.jsp" />
