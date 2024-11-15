<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deleted Products</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #000000; /* Set body background to black */
            color: #ffffff; /* Set text color to white */
        }
        h2 {
            margin: 20px 0;
            text-align: center;
            color: #ffffff; /* White text for header */
        }
        .category-header {
            margin-top: 30px;
            color: #007bff; /* Blue color for category headers */
        }
        .product-table {
            margin-bottom: 30px;
            background-color: #212529; /* Dark background for the table */
            color: #ffffff; /* White text in table */
        }
        .product-table th, .product-table td {
            border: 1px solid #454d55; /* Darker borders for table cells */
        }
        .product-image {
            max-width: 100px; /* Set a fixed width for images in the table */
            height: auto;
            border-radius: 0.5rem;
        }
        .btn-success {
            background-color: #28a745; /* Green button color */
            border-color: #218838; /* Darker green for button border */
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray button color */
            border-color: #5a6268; /* Darker gray for button border */
        }
        .alert {
            background-color: #343a40; /* Dark background for alerts */
            color: #ffffff; /* White text for alerts */
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Deleted Products Grouped by Category</h2>

    <c:forEach var="entry" items="${deletedProductsByCategory}">
        <!-- Display Category -->
        <h3 class="category-header">Category: ${entry.key.name}</h3>
        
        <table class="table product-table">
            <thead class="thead-dark">
                <tr>
                    <th>Product Name</th>
                    <th>Product Image</th>
                    <th>Description</th>
                    <th>Product Quantity</th>
                    <th>Popularity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${entry.value}">
                    <tr>
                        <td>${product.productName}</td>
                        <td>
                            <img src="data:image/jpeg;base64,${product.getBase64()}" alt="${product.productName} image" class="product-image" />
                        </td>
                        <td>${product.description}</td>
                        <td>${product.quantity}</td>
                        <td>${product.popularity}</td>
                        <td>
                            <!-- Restore Button for Each Product -->
                            <a href="${pageContext.request.contextPath}/restoringProducts/${product.id}" class="btn btn-success btn-sm">Restore</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:forEach>

    <div class="text-center">
        <a href="${pageContext.request.contextPath}/viewProducts/${categoryId}" class="btn btn-secondary w-100 mt-3">Back to Product List</a>
        <c:if test="${not empty message}">
            <div class="alert mt-3">${message}</div>
        </c:if>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
