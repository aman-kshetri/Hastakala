<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="header.jsp" />

<!-- Modern CSS styling -->
<style>
    body, html {
        height: 100%;
        margin: 0;
    }

    .center-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        height: auto;
        min-height: 100vh;
        padding-top: 40px;
        padding-bottom: 40px;
    }

    .register-container {
        background: #fff;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 500px;
    }

    .register-container h2 {
        text-align: center;
        margin-bottom: 25px;
        color: #333;
    }

    .register-container label {
        display: block;
        margin-bottom: 6px;
        color: #444;
        font-weight: 500;
    }

    .register-container input[type="text"],
    .register-container input[type="email"],
    .register-container input[type="password"],
    .register-container input[type="tel"] {
        width: 100%;
        padding: 10px 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
        transition: 0.2s border-color;
    }

    .register-container input:focus {
        border-color: #007bff;
        outline: none;
    }

    .register-container button {
        width: 100%;
        background: #28a745;
        border: none;
        color: white;
        padding: 12px;
        border-radius: 6px;
        font-size: 1rem;
        cursor: pointer;
        transition: 0.3s background;
    }

    .register-container button:hover {
        background: #218838;
    }

    .error-message {
        color: #d9534f;
        text-align: center;
        margin-top: 10px;
        font-weight: bold;
    }
</style>

<!-- Centered Register Form -->
<div class="center-wrapper">
    <div class="register-container">
        <h2>Register</h2>
        <form method="post" action="${pageContext.request.contextPath}/auth/register">
            <label>Name:</label>
            <input type="text" name="name" required />

            <label>Email:</label>
            <input type="email" name="email" required />

            <label>Password:</label>
            <input type="password" name="password" required />

            <label>Phone:</label>
            <input type="tel" name="phone" required />

            <label>Address:</label>
            <input type="text" name="address" required />

            <button type="submit">Register</button>
        </form>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
    </div>
</div>

<jsp:include page="footer.jsp" />
