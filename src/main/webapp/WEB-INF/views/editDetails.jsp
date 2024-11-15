<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Detail</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #000000; /* Black background */
            color: #ffffff; /* White text */
        }
        h2 {
            color: #ffffff; /* White for heading */
        }
        .alert {
            margin: 10px 0; /* Space between alerts and form */
        }
        label {
            color: #ffffff; /* White for labels */
        }
        input {
            background-color: #212529; /* Dark input background */
            color: #ffffff; /* White text in inputs */
            border: 1px solid #454d55; /* Dark border */
        }
        input:focus {
            background-color: #343a40; /* Darker background on focus */
            border-color: #007bff; /* Blue border on focus */
            color: #ffffff; /* Keep text white */
        }
        button {
            background-color: #007bff; /* Blue button background */
            color: #ffffff; /* White text */
        }
        a {
            color: #6c757d; /* Gray for cancel link */
        }
        a:hover {
            color: #ffffff; /* White on hover */
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>Edit Detail</h2>

        <!-- Display any error or success messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/updateDetails/${detail.id}" method="post">
            
             <div class="form-group">
                <label for="perQuantity">Per Quantity:</label>
                <input type="number" id="perQuantity" name="perQuantity" value="${detail.perQuantity}" class="form-control" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="unit">Unit:</label>
                <input type="text" id="unit" name="unit" value="${detail.unit}" class="form-control" readonly="readonly">
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" step="0.01" id="price" name="price" value="${detail.price}" class="form-control" required>
            </div>
           

            <input type="hidden" name="product.id" value="${detail.product.id}" /> <!-- Optional: Include product ID -->

            <div>
                <button type="submit" class="btn btn-primary">Update</button>
                <a href="${pageContext.request.contextPath}/viewDetails/${detail.product.id}" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
