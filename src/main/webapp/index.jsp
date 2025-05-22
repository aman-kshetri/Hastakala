<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="views/common/header.jsp" />

<div class="content">
    <c:choose>
        <%-- Customer View --%>
        <c:when test="${sessionScope.user.role == 'CUSTOMER'}">
            <section class="welcome-banner">
                <h1>Welcome back, ${sessionScope.user.name}!</h1>
                <p>Ready to discover more handcrafted treasures?</p>
            </section>
            
            
            <section class="featured-products">
                <h2 class="section-title">Featured Products</h2>
                <div class="category-showcase">
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/jwellery.jpg" alt="Jewelry">
                        <div class="category-overlay">
                            <h3>Handcrafted Jewelry</h3>
                        </div>
                    </div>
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/baskets.webp" alt="Baskets">
                        <div class="category-overlay">
                            <h3>Woven Baskets</h3>
                        </div>
                    </div>
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/sandals.jpg" alt="Sandals">
                        <div class="category-overlay">
                            <h3>Artisan Footwear</h3>
                        </div>
                    </div>
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/polished-pottery.jpg" alt="Pottery">
                        <div class="category-overlay">
                            <h3>Ceramic Pottery</h3>
                        </div>
                    </div>
                </div>
                
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
                </div>
            </section>
        </c:when>
        
        <%-- Admin View --%>
        <c:when test="${sessionScope.user.role == 'ADMIN'}">
            <jsp:forward page="/admin/dashboard" />
        </c:when>
        
        <%-- Guest View (Default) --%>
        <c:otherwise>
            <section class="hero">
                <div class="hero-content">
                    <h1>Discover Unique Handcrafted Items</h1>
                    <p>Support artisans and find one-of-a-kind creations</p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Shop Now</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Join Our Community</a>
                    </div>
                </div>
                <div class="hero-image">
                    <img src="${pageContext.request.contextPath}/uploads/hero-banner.jpg" alt="Handcrafted items">
                </div>
            </section>
            
            <section class="featured-products">
                <h2 class="section-title">Our Collections</h2>
                <div class="category-showcase">
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/jwellery.jpg" alt="Jewelry">
                        
                    </div>
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/baskets.webp" alt="Baskets">
                        
                    </div>
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/sandals.jpg" alt="Sandals">
                        
                    </div>
                    <div class="category-card">
                        <img src="${pageContext.request.contextPath}/uploads/polished-pottery.jpg" alt="Pottery">
                        
                    </div>
                </div>
                
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Explore All Products</a>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</div>

<style>
/* ===== Base Styles & Variables ===== */
:root {
    --primary-color: #8c6e52;
    --primary-dark: #7a5d43;
    --secondary-color: #f8f4e9;
    --text-dark: #5a4a3a;
    --text-light: #7a6a5a;
    --border-color: #e0d6c9;
    --white: #ffffff;
    --shadow-sm: 0 2px 4px rgba(0,0,0,0.05);
    --shadow-md: 0 4px 8px rgba(0,0,0,0.1);
    --shadow-lg: 0 6px 12px rgba(0,0,0,0.15);
    --transition: all 0.3s ease;
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: var(--text-dark);
    background-color: var(--white);
}

.content {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1rem;
}

/* ===== Typography ===== */
h1, h2, h3, h4 {
    font-weight: 600;
    line-height: 1.2;
}

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.5rem; }

.section-title {
    text-align: center;
    margin-bottom: 3rem;
    position: relative;
    padding-bottom: 1rem;
}

.section-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 3px;
    background-color: var(--primary-color);
}

/* ===== Buttons ===== */
.btn {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    border-radius: 4px;
    font-weight: 500;
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    transition: var(--transition);
    border: 2px solid transparent;
}

.btn-primary {
    background-color: var(--primary-color);
    color: var(--white);
}

.btn-primary:hover {
    background-color: var(--primary-dark);
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

.btn-secondary {
    background-color: var(--secondary-color);
    color: var(--text-dark);
    border-color: var(--border-color);
}

.btn-secondary:hover {
    background-color: var(--border-color);
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

.btn-outline {
    background-color: transparent;
    color: var(--white);
    border: 2px solid var(--white);
}

.btn-outline:hover {
    background-color: rgba(255,255,255,0.1);
}

/* ===== Welcome Banner ===== */
.welcome-banner {
    background-color: var(--secondary-color);
    padding: 3rem 2rem;
    border-radius: 8px;
    margin-bottom: 3rem;
    text-align: center;
    box-shadow: var(--shadow-sm);
}

.welcome-banner h1 {
    color: var(--text-dark);
    margin-bottom: 1rem;
}

.welcome-banner p {
    color: var(--text-light);
    font-size: 1.2rem;
    max-width: 600px;
    margin: 0 auto;
}



/* ===== Category Showcase ===== */
.category-showcase {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem;
    margin: 3rem 0;
}

.category-card {
    position: relative;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: var(--shadow-md);
    aspect-ratio: 1/1;
    transition: var(--transition);
}

.category-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-lg);
}

.category-card img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

.category-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
    padding: 2rem 1rem 1rem;
    color: var(--white);
    text-align: center;
}

.category-overlay h3 {
    margin-bottom: 1rem;
    font-size: 1.3rem;
}

/* ===== Hero Section ===== */
.hero {
    display: flex;
    flex-direction: column;
    gap: 2rem;
    margin-bottom: 4rem;
    align-items: center;
}

.hero-content {
    text-align: center;
}

.hero-image {
    width: 100%;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: var(--shadow-lg);
}

.hero-image img {
    width: 100%;
    height: auto;
    display: block;
}

.hero h1 {
    color: var(--text-dark);
    margin-bottom: 1.5rem;
    font-size: 2.5rem;
}

.hero p {
    color: var(--text-light);
    margin-bottom: 2rem;
    font-size: 1.2rem;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
}

.hero-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
}

.view-all {
    text-align: center;
    margin-top: 3rem;
}

/* ===== Responsive Adjustments ===== */
@media (min-width: 768px) {
    .hero {
        flex-direction: row;
        gap: 4rem;
    }
    
    .hero-content {
        text-align: left;
        flex: 1;
    }
    
    .hero-image {
        flex: 1;
    }
    
    .hero h1 {
        font-size: 3rem;
    }
    
    .hero-buttons {
        justify-content: flex-start;
    }
    
    .section-title {
        font-size: 2.5rem;
    }
}

@media (max-width: 480px) {
    .hero h1 {
        font-size: 2rem;
    }
    
    .hero-buttons .btn {
        width: 100%;
    }
    
    .category-showcase {
        grid-template-columns: 1fr;
    }
}
</style>
<jsp:include page="views/common/footer.jsp" />