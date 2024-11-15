<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Detail</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #000000; /* Set body background to black */
            color: #ffffff; /* Set text color to white */
        }
        h2, h3 {
            color: #ffffff; /* White text for headers */
        }
        .form-group label {
            color: #ffffff; /* White text for labels */
        }
        .form-control {
            background-color: #212529; /* Dark background for input fields */
            color: #ffffff; /* White text in input fields */
            border: 1px solid #454d55; /* Dark border for input fields */
        }
        .form-control:focus {
            background-color: #343a40; /* Darker background on focus */
            border-color: #007bff; /* Blue border on focus */
            color: #ffffff; /* Maintain white text on focus */
        }
        .btn-primary {
            background-color: #007bff; /* Blue button color */
            border-color: #0056b3; /* Darker blue for button border */
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray button color */
            border-color: #5a6268; /* Darker gray for button border */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2>Create Detail for Product: ${product.productName}</h2>
    <h3>${error}</h3>
    
    <!-- Display product image -->
    <div class="mb-3">
        <img src="data:image/jpeg;base64,${product.getBase64()}" alt="${product.productName} image" style="max-width: 200px;"/>
    </div>
    
    <!-- Display product description -->
    <p><strong>Description:</strong> ${product.description}</p>

    <form action="${pageContext.request.contextPath}/createDetail" method="post">
        <input type="hidden" name="product.id" value="${detail.product.id}" />

        
<div class="form-group">
            <label for="perQuantity">Per Quantity:</label>
            <input type="number" id="perQuantity" name="perQuantity" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="unit">Unit:</label>
           
            <select name="unit" id="unit" class="form-control" required>
        <option value="kilogram">Kilogram (kg)</option>
        <option value="gram">Gram (g)</option>
        <option value="pieces">Piece (pcs)</option>
        <option value="packs">Pack (pk)</option>
        <option value="box">Box (bk)</option>
        <option value="set">Set (set)</option>
        <option value="bottle">Bottle</option>
        <option value="carton">Carton</option>
        <option value="can">Can</option>
        <option value="pack">Pack</option>
        <option value="bunch">Bunch</option>
    </select>
        </div>
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="number" step="0.01" id="price" name="price" class="form-control" required />
            
        </div>

        

        <button type="submit" class="btn btn-primary">Create Detail</button>
        <a href="${pageContext.request.contextPath}/viewDetails/${detail.product.id}" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
