
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hastakala - Handcrafted Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Load role-specific CSS only when needed -->
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    </c:if>
    <c:if test="${sessionScope.user.role == 'CUSTOMER'}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
    </c:if>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <main class="container">