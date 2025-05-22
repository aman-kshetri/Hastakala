<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<footer class="site-footer">
    <div class="footer-grid">
        <!-- Why Hastakala -->
        <div class="footer-section">
            <h4>Why Hastakala?</h4>
            <p>We connect artisans with buyers seeking unique, handcrafted treasures that carry cultural heritage and personal meaning.</p>
            <div class="social-icons">
                <a href="#" aria-label="Facebook"><i class="fab fa-facebook"></i></a>
                <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
            </div>
        </div>

        <!-- Quick Links -->
        <c:choose>
            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'CUSTOMER'}">
                <div class="footer-section quick-links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Shop</a></li>
                        <li><a href="${pageContext.request.contextPath}/customer/profile">Profile</a></li>
                        <li><a href="${pageContext.request.contextPath}/common/about-us">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/common/contact-us">Contact Us</a></li>
                    </ul>
                </div>
            </c:when>

            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                <div class="footer-section quick-links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/products">Manage Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/categories">Manage Categories</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/report">Sales Report</a></li>
                    </ul>
                </div>
            </c:when>

            <c:otherwise>
                <div class="footer-section quick-links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li>Home</li>
                        <li>Shop</li>
                        <li>Profile</li>
                        <li><a href="${pageContext.request.contextPath}/common/about-us">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/common/contact-us">Contact Us</a></li>
                    </ul>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Newsletter -->
        <div class="footer-section">
            <h4>Stay Updated</h4>
            <p class="newsletter-text">Get updates on new products, exclusive offers.</p>
            <div class="newsletter-form">
                <input type="email" placeholder="Enter your email" class="newsletter-input" />
                <button class="newsletter-button">Subscribe</button>
            </div>
        </div>

        <!-- Contact Info -->
        <div class="footer-section">
            <h4>Contact Us</h4>
            <p>Email: support@hastakala.com</p>
            <p>Phone: +977-9866008987</p>
            <p>Address: Pokhara-30, Nepal</p>
        </div>
    </div>

    <div class="footer-bottom">
        <p>&copy; 2025 Hastakala. All rights reserved.</p>
    </div>
</footer>

<style>
.site-footer {
    background-color: #f4f4f4;
    padding: 1.5rem;
    font-size: 0.9rem;
    margin-top: 3rem;
}

.footer-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;
    justify-content: space-between;
}

.footer-section {
    flex: 1;
    min-width: 200px;
}

.quick-links {
    flex: 0.6;
}

.footer-grid h4 {
    margin-bottom: 0.5rem;
    color: #444;
}

.footer-grid ul {
    list-style: none;
    padding: 0;
}

.footer-grid ul li {
    margin: 0.25rem 0;
}

.footer-grid ul li a {
    text-decoration: none;
    color: #555;
}

.footer-grid ul li a:hover {
    text-decoration: underline;
}

/* Social Icons */
.social-icons {
    display: flex;
    gap: 1rem;
    margin-top: 1rem;
}

.social-icons a {
    color: #555;
    font-size: 1.2rem;
    transition: color 0.2s;
}

.social-icons a:hover {
    color: #333;
}

/* Newsletter Styles */
.newsletter-text {
    font-size: 0.85rem;
    color: #555;
    margin-bottom: 0.5rem;
}

.newsletter-form {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.newsletter-input {
    padding: 0.5rem;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 0.9rem;
}

.newsletter-button {
    padding: 0.5rem;
    background-color: #555;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 0.9rem;
    cursor: pointer;
}

.newsletter-button:hover {
    background-color: #333;
}

/* Footer Bottom */
.footer-bottom {
    text-align: center;
    border-top: 1px solid #ddd;
    padding-top: 1rem;
    color: #777;
}

/* Responsive */
@media (max-width: 768px) {
    .newsletter-form {
        flex-direction: column;
    }

    .newsletter-input,
    .newsletter-button {
        width: 100%;
    }
}
</style>
