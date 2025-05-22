<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_form.css">

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
        <div class="form-card">
            <h2 class="form-title">${product != null ? "Edit" : "Add"} Product</h2>
            
            <form method="post"
                  enctype="multipart/form-data"
                  action="${pageContext.request.contextPath}/admin/products">
                  
                <c:if test="${product != null}">
                    <input type="hidden" name="productId" value="${product.productId}" />
                    <input type="hidden" name="existingImageUrl" value="${product.imageUrl}" />
                </c:if>

                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" class="form-control" name="name" value="${product.name}" required/>
                </div>

                <div class="form-group">
                    <label>Product Image:</label>
                    <input type="file" class="form-control" name="imageFile" accept="image/*" />
                </div>

                <c:if test="${product != null && not empty product.imageUrl}">
                    <div class="current-image">
                        <p>Current Image:</p>
                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" width="120"/>
                    </div>
                </c:if>

                <div class="form-group">
                    <label>Description:</label>
                    <textarea class="form-control" name="description" required>${product.description}</textarea>
                </div>

                <div class="form-group">
                    <label>Price:</label>
                    <input type="number" class="form-control" step="0.01" name="price" value="${product.price}" min="0" required/>
                </div>

                <div class="form-group">
                    <label>Stock:</label>
                    <input type="number" class="form-control" name="stock" value="${product.stock}" min="0" required/>
                </div>

                <div class="form-group">
                    <label>Category:</label>
                    <select class="form-control" name="category_id" required>
                        <option value="">Select Category</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.categoryId}" 
                                ${product != null && product.categoryId == category.categoryId ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">${product != null ? "Update" : "Add"} Product</button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("form");
        const imageInput = form.querySelector('input[name="imageFile"]');
        const productIdInput = form.querySelector('input[name="productId"]');

        form.addEventListener("submit", function (e) {
            const isEdit = productIdInput !== null; // true if editing

            if (!isEdit && imageInput.files.length === 0) {
                alert("Image is required when adding a new product.");
                e.preventDefault(); // Stop form submission
            }
        });
    });
</script>

