<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp" />

<!-- Modern CSS Styling -->
<style>
    .contact-container {
        max-width: 700px;
        margin: 50px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }

    .contact-container h1, .contact-container h2 {
        text-align: center;
        color: #333;
    }

    .contact-info {
        margin-bottom: 30px;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 8px;
    }

    .contact-info p {
        margin: 10px 0;
        font-size: 1rem;
    }

    form label {
        font-weight: 500;
        display: block;
        margin-bottom: 6px;
    }

    form input[type="text"],
    form input[type="email"],
    form textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1rem;
    }

    form textarea {
        resize: vertical;
    }

    form button {
        width: 100%;
        background-color: #007bff;
        color: white;
        padding: 12px;
        border: none;
        border-radius: 6px;
        font-size: 1rem;
        cursor: pointer;
        transition: 0.3s background;
    }

    form button:hover {
        background-color: #0056b3;
    }

    .success-message, .error-message {
        text-align: center;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .success-message {
        color: green;
    }

    .error-message {
        color: red;
    }
</style>

<!-- Contact Us Content -->
<section class="contact-container">
    <h1>Contact Us</h1>
    <p style="text-align:center;">If you have any questions, suggestions, or need assistance, we’d love to hear from you.</p>

    <div class="contact-info">
        <p><strong>Email:</strong> support@hastakala.com</p>
        <p><strong>Phone:</strong> +977-9805814121</p>
        <p><strong>Address:</strong> Pokhara-30, Nepal</p>
    </div>

    <h2>Send Us a Message</h2>

    <!-- Optional: Success/Error message -->
    <c:if test="${not empty success}">
        <p class="success-message">${success}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error-message">${error}</p>
    </c:if>

    <form method="post" action="#">
        <label>Name:</label>
        <input type="text" name="name" required />

        <label>Email:</label>
        <input type="email" name="email" required />

        <label>Message:</label>
        <textarea name="message" rows="5" required></textarea>

        <button type="submit">Submit</button>
    </form>
</section>

<jsp:include page="footer.jsp" />
