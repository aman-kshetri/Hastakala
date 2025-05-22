<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../common/header.jsp" />

<div class="profile-card">

    <div class="profile-info">
        <h2>My Profile</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form method="post" id="profileForm">
            <div class="form-group">
                <label>Name</label>
                <input type="text" name="name" value="${user.name}" class="form-control" readonly>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" value="${user.email}" class="form-control" readonly>
            </div>
            <div class="form-group">
                <label>Phone</label>
                <input type="text" name="phone" value="${user.phone}" class="form-control" readonly>
            </div>
            <div class="form-group">
                <label>Address</label>
                <textarea name="address" class="form-control" readonly>${user.address}</textarea>
            </div>
            <div class="form-group">
                <label>Role</label>
                <input type="text" value="${user.role}" class="form-control" readonly>
            </div>
            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="password" placeholder="Leave blank to keep unchanged" class="form-control" readonly>
            </div>

            <div class="btn-group">
                <button type="button" class="btn" id="editBtn">Edit</button>
                <button type="submit" class="btn d-none" id="updateBtn">Update</button>
            </div>
        </form>
    </div>
</div>


<script>
    const editBtn = document.getElementById('editBtn');
    const updateBtn = document.getElementById('updateBtn');
    const formInputs = document.querySelectorAll('#profileForm input:not([type="email"]):not([type="text"][value="${user.role}"]), #profileForm textarea');

    editBtn.addEventListener('click', function () {
        formInputs.forEach(input => input.removeAttribute('readonly'));
        editBtn.classList.add('d-none');
        updateBtn.classList.remove('d-none');
    });
</script>

<style>
/* Profile Card Layout */
.profile-card {
    max-width: 700px;
    margin: 40px auto;
    background: #fff;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    display: flex;
    gap: 30px;
    flex-wrap: wrap;
    align-items: flex-start;
}

/* Profile Info Form */
.profile-info {
    flex: 2 1 400px;
}

.profile-info h2 {
    font-size: 24px;
    margin-bottom: 20px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 10px;
    color: #333;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: 500;
    color: #555;
    display: block;
    margin-bottom: 6px;
}

.form-control {
    width: 100%;
    border: 1px solid #ccc;
    padding: 10px 12px;
    border-radius: 6px;
    font-size: 15px;
}

.form-control[readonly] {
    background-color: #f9f9f9;
    color: #555;
}

/* Buttons */
.btn-group {
    margin-top: 20px;
}

.btn-group button {
    padding: 10px 20px;
    font-weight: 500;
    margin-right: 10px;
}

#editBtn {
    background-color: #007bff;
    border: none;
    color: white;
}

#updateBtn {
    background-color: #28a745;
    border: none;
    color: white;
}

/* Alert Messages */
.alert {
    margin-bottom: 20px;
    padding: 12px;
    border-radius: 5px;
    font-size: 14px;
}

.alert-success {
    background-color: #d4edda;
    color: #155724;
}

.alert-danger {
    background-color: #f8d7da;
    color: #721c24;
}

/* Responsive Design */
@media (max-width: 768px) {
    .profile-card {
        flex-direction: column;
        align-items: center;
    }

    .profile-info {
        width: 100%;
    }

    .btn-group {
        text-align: center;
    }

    .btn-group button {
        width: 100%;
        margin-bottom: 10px;
    }
}
</style>


<jsp:include page="../common/footer.jsp" />


