<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Category</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color:  #1d2634;; /* Dark black background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #ffffff; /* White text color */
        }

        .form-container {
            max-width: 600px;
            width: 100%;
            padding: 20px;
            background-color:  #3a4f63;; /* Dark gray for form container */
            border-radius: 8px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.5);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #ffffff;
        }

        .form-container .btn-primary {
            background-color: #333333; /* Dark gray for primary button */
            border-color: #333333;
        }

        .form-container .btn-primary:hover {
            background-color: #555555; /* Slightly lighter gray on hover */
            border-color: #555555;
        }

        .form-container .btn-secondary {
            margin-top: 10px;
            background-color: #444444; /* Darker gray for secondary button */
            border-color: #444444;
            color: #ffffff;
        }

        .form-container .btn-secondary:hover {
            background-color: #666666;
            border-color: #666666;
        }

        .alert {
            margin-bottom: 20px;
            background-color: #ff4444; /* Red alert for errors */
            color: #ffffff;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Edit Category</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form:form method="post" action="${pageContext.request.contextPath}/update/${category.id}"
               modelAttribute="category" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="name" class="form-label">Category Name:</label>
            <form:input path="name" id="name" class="form-control" required="required" style="background-color: #333333; color: #ffffff;" />
        </div>
        <div class="mb-3">
            <label for="photo" class="form-label">Upload new photo (optional):</label>
            <form:input path="file" id="photo" type="file" class="form-control" style="background-color: #333333; color: #ffffff;" />
        </div>
        <button type="submit" class="btn btn-primary w-100">Update Category</button>
    </form:form>

    <a href="${pageContext.request.contextPath}/categoryList" class="btn btn-secondary w-100 mt-3">Back to Category List</a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
