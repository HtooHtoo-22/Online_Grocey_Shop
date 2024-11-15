<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Details</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #1d2634 ; /* Set body background to black */
            color: #ffffff; /* Set text color to white for readability */
        }
        h2, h3 {
            color: #ffffff; /* White text for headers */
        }
        .table {
            background-color: #212529; /* Dark background for the table */
            color: #ffffff; /* White text in the table */
        }
        .table th, .table td {
            border: 1px solid #454d55; /* Darker border for table cells */
        }
        .btn-primary {
            background-color: #007bff; /* Blue button color */
            border-color: #0056b3; /* Darker blue for button border */
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray button color */
            border-color: #5a6268; /* Darker gray for button border */
        }
        .btn-info {
            background-color: #17a2b8; /* Teal button color */
            border-color: #117a8b; /* Darker teal for button border */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">Details for Product: ${product.productName}</h2>
    
    <!-- Display product image -->
    <div class="mb-3">
        <img src="data:image/jpeg;base64,${product.getBase64()}" alt="${product.productName} image" class="img-fluid" style="max-width: 200px;"/>
    </div>
    
    <!-- Display product description -->
    <p><strong>Description:</strong> ${product.description}</p>

    <h3 class="mt-4">Detail List</h3>
    <table class="table table-striped table-bordered">
        <thead>
            <tr>
                <th>Per Quantity</th>
                <th>Unit</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="detail" items="${details}">
                <tr>
                    <td>${detail.perQuantity}</td>
                    <td>${detail.unit}</td>
                    <td>${detail.price}</td>
                    <td>
                        <a href="<c:url value='/editDetails/${detail.id}'/>" class="btn btn-primary" title="Edit">Edit</a>
                        <a href="<c:url value='/deleteDetails/${detail.id}'/>" class="btn btn-primary" title="Delete">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/showCreateDetail/${product.id}" class="btn btn-primary">Add Detail</a>
        <a href="${pageContext.request.contextPath}/viewProducts/${product.category.id}" class="btn btn-secondary">Back to Product</a>
        <a href="${pageContext.request.contextPath}/viewDetailHistory/${product.id}" class="btn btn-info">View Previous Detail</a>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
