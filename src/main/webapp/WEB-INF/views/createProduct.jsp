<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Product</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        body {
            background-color: #1d2634 ; /* Pure black background */
            color: #ffffff; /* White text */
        }
        h2 {
            margin-bottom: 20px;
            color: #ffffff; /* White heading */
        }
        .error-message {
            color: #dc3545; /* Bootstrap danger color */
        }
        .success-message {
            color: #28a745; /* Bootstrap success color */
        }
        .form-section {
            background-color: #1a1a1a; /* Dark gray for form section */
            border-radius: 0.5rem;
            box-shadow: 0 2px 5px rgba(255, 255, 255, 0.1); /* Light shadow for depth */
            padding: 20px;
            margin-bottom: 20px;
        }
        .custom-file-label::after {
            content: "Choose file";
        }
        .form-control {
            background-color: #333333; /* Darker input fields */
            color: #ffffff; /* White text in input fields */
            border: 1px solid #555555; /* Medium grey border */
        }
        .form-control:focus {
            background-color: #444444; /* Darker input focus */
            color: #ffffff; /* White text on focus */
            border-color: #80bdff; /* Blue border on focus */
        }
        .btn-success {
            background-color: #28a745; /* Bootstrap success color */
            border: none;
        }
        .btn-secondary {
            background-color: #444444; /* Darker grey for secondary button */
            border: none;
        }
        .btn-success:hover, .btn-secondary:hover {
            opacity: 0.8; /* Slightly transparent on hover */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2>Create New Product</h2>

    <p>Category: <strong>${category.name}</strong></p>
    
    <!-- Display error messages (if any) -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>

    <!-- Display success message -->
    <c:if test="${not empty message}">
        <div class="alert alert-success" role="alert">
            ${message}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/createProduct" method="post" enctype="multipart/form-data">
        <input type="hidden" name="category.id" value="${product.category.id}">

        <div class="form-group">
            <label for="name">Product Name:</label>
            <input type="text" name="productName" id="productName" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea name="description" id="description" class="form-control" required></textarea>
        </div>

        <div class="form-group">
            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" id="quantity" class="form-control" required>
        </div>
        <div class="form-group">
    <label for="productUnit">Unit:</label>
    <select name="productUnit" id="productUnit" class="form-control" required>
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
            <label for="file">Product Image:</label>
            <input type="file" name="file" id="productPhotoFile" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success">Create Product</button>
    </form>

    <a href="${pageContext.request.contextPath}/viewProducts/${product.category.id}" class="btn btn-secondary">View Products By Category</a>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
