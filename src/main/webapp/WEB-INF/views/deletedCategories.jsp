<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deleted Categories</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Dark Theme Styling */
        body {
            background-color: #121212;
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.3);
            max-width: 800px;
            width: 100%;
        }

        .table {
            background-color: #2c2c2c;
            color: #ffffff;
        }

        .table thead {
            background-color: #333333;
            color: #ffffff;
        }

        .table tbody tr:nth-child(even) {
            background-color: #2b2b2b;
        }

        .table tbody tr:nth-child(odd) {
            background-color: #242424;
        }

        .table th, .table td {
            border-color: #444444;
        }

        .btn-primary, .btn-success {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover, .btn-success:hover {
            background-color: #0056b3;
        }

        .alert-warning {
            background-color: #333333;
            color: #ffc107;
            border-color: #ffc107;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Deleted Categories</h2>

    <c:if test="${not empty deletedCategories}">
        <table class="table table-bordered">
            <thead>
                <tr>
                   
                    <th>Name</th>
                    <th>Photo</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${deletedCategories}">
                    <tr>
                        
                        <td>${category.name}</td>
                        <td>
                            <c:if test="${not empty category.photoByte}">
                                <img src="data:image/jpeg;base64,${fn:escapeXml(category.base64)}" alt="Category Photo" width="100"/>
                            </c:if>
                            <c:if test="${empty category.photoByte}">
                                No Photo Available
                            </c:if>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/restore/${category.id}" class="btn btn-success btn-sm">Restore</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty deletedCategories}">
        <div class="alert alert-warning">No deleted categories found.</div>
    </c:if>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/categoryList" class="btn btn-primary">Back to Category List</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
