<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #1d2634 ; /* Set background color to black */
            color: #ffffff; /* Set text color to white */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            max-width: 600px;
            width: 100%;
            padding: 20px;
            background-color: #222; /* Darker background for the form */
            border-radius: 8px;
            box-shadow: 0px 4px 12px rgba(255, 255, 255, 0.1); /* Light shadow for contrast */
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-container .btn-primary {
            background-color: #007bff; /* Primary button color */
            border-color: #007bff;
        }

        .form-container .btn-primary:hover {
            background-color: #0056b3; /* Darker on hover */
            border-color: #004085;
        }

        .form-container .btn-secondary {
            background-color: #6c757d; /* Secondary button color */
            border-color: #6c757d;
        }

        .form-container .btn-secondary:hover {
            background-color: #5a6268; /* Darker on hover */
            border-color: #545b62;
        }

        .alert {
            margin-bottom: 20px;
        }

        /* Override the input colors to be white text on dark background */
        .form-container input,
        .form-container textarea {
            background-color: #333; /* Dark background for inputs */
            color: #ffffff; /* White text color for inputs */
            border: 1px solid #555; /* Border color for inputs */
        }

        .form-container input::placeholder,
        .form-container textarea::placeholder {
            color: #aaaaaa; /* Light grey placeholder text */
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Edit Product</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form:form method="post" action="${pageContext.request.contextPath}/updateProducts/${product.id}" 
                    modelAttribute="product" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="name" class="form-label">Product Name:</label>
                <form:input path="productName" id="productName" class="form-control" required="required"/>
            </div>
            <div class="mb-3">
                <label for="image" class="form-label">Upload new photo (optional):</label> 
                <form:input path="productPhotoFile" id="productPhotoFile" type="file" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="popularity" class="form-label">Popularity :</label>
                <form:input path="popularity" id="popularity" class="form-control" type="number" readonly="true"/>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <form:textarea path="description" id="description" rows="3" class="form-control" placeholder="Enter product description" required="true"/>
            </div>
            <div class="mb-3">
                <label for="quantity" class="form-label">Quantity :</label>
                <form:input path="quantity" id="quantity" class="form-control" type="number" required="required"/>
            </div>
            <button type="submit" class="btn btn-primary w-100">Update Product</button>
        </form:form>

        <a href="${pageContext.request.contextPath}/viewProducts/${product.category.id}" class="btn btn-secondary w-100 mt-3">Back to Product List</a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
