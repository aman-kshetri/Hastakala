<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp" />


<div class="center-place">
    <div class="login-container">
        <h2>Login</h2>
        <form method="post" action="${pageContext.request.contextPath}/auth/login">
            <label>Email:</label>
            <input type="email" name="email" required />

            <label>Password:</label>
            <input type="password" name="password" required />

            <button type="submit">Login</button>
        </form>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
    </div>
</div>

<jsp:include page="footer.jsp" />

<style>
    body, html {
        height: 100%;
        margin: 0;
    }

    .center-place {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 60vh; /* Adjust if header/footer take space */
        padding-top: 60px;
        padding-bottom: 60px;
    }

    .login-container {
        background: #fff;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 400px;
    }

    .login-container h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
    }

    .login-container label {
        display: block;
        margin-bottom: 6px;
        color: #444;
        font-weight: 500;
    }

    .login-container input[type="email"],
    .login-container input[type="password"] {
        width: 100%;
        padding: 10px 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        transition: 0.2s border-color;
    }

    .login-container input:focus {
        border-color: #007bff;
        outline: none;
    }

    .login-container button {
        width: 100%;
        background: #007bff;
        border: none;
        color: white;
        padding: 12px;
        border-radius: 6px;
        font-size: 1rem;
        cursor: pointer;
        transition: 0.3s background;
    }

    .login-container button:hover {
        background: #0056b3;
    }

    .error-message {
        color: #d9534f;
        text-align: center;
        margin-top: 10px;
        font-weight: bold;
    }
</style>