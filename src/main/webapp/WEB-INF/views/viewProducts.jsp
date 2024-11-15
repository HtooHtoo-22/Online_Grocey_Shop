<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Grouped by Category</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #1d2634; /* Dark background */
            color: #f1f1f1; /* Light text for readability */
        }
        h2 {
            margin: 20px 0;
            text-align: center;
            color: #ffffff; /* White text for the title */
        }
        .category-header {
            margin-top: 30px;
            color: #00bfff; /* Light cyan for category headers */
            font-size: 1.5rem;
        }
        .action-buttons a {
            margin-right: 10px;
            color: #ffffff; /* White text for buttons */
        }
        .action-buttons a:hover {
            color: #f1f1f1; /* Light hover effect for buttons */
        }
        .form-container {
            background-color: #3a4f63; /* Lighter blue-gray for form container */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
            width: 300px;
            margin-top: 20px;
            color: #f1f1f1; /* Light text in the form container */
        }
        .btn-secondary, .btn-primary, .btn-warning, .btn-danger {
            margin-top: 10px;
        }
        .btn-primary {
            background-color: #007bff; /* Blue button */
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .btn-danger {
            background-color: #dc3545; /* Red button */
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        .btn-warning {
            background-color: #ffc107; /* Yellow button */
            color: black;
        }
        .btn-warning:hover {
            background-color: #e0a800; /* Darker yellow on hover */
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray button */
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268; /* Darker gray on hover */
        }
        table {
            color: #f1f1f1; /* Light text for table content */
        }
        th {
            color: #00bfff; /* Light cyan for table headers */
        }
        td {
            color: #f1f1f1; /* Light text for table rows */
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Products Grouped by Category</h2>

    <c:if test="${not empty searchQuery || (categoryId != null)}">
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/adminProductList" class="btn btn-secondary">View All Product List</a>
            <a href="${pageContext.request.contextPath}/categoryList" class="btn btn-secondary">Go to Category List</a>
            
            <c:if test="${categoryId != null}">
                <a href="<c:url value='/showCreateProductForm/${categoryId}'/>" class="btn btn-primary">Add New Product</a>
                <a href="<c:url value='/showDeletedProducts/${categoryId}'/>" class="btn btn-warning">Restoring Products</a>
            </c:if>
        </div>
    </c:if>

    <c:if test="${not empty productsByCategory}">
        <c:forEach var="entry" items="${productsByCategory}">
            <h3 class="category-header">Category: ${entry.key.name}</h3>

            <c:if test="${not empty entry.value}">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Product Image</th>
                            <th>Product Name</th>
                            <th>Description</th>
                            <th>Quantity</th>
                            <th>Unit</th>
                            <th>Popularity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${entry.value}">
                            <tr>
                                <td>
                                    <img src="data:image/jpeg;base64,${product.getBase64()}" alt="${product.productName}" style="max-width: 100px; height: auto;" />
                                </td>
                                <td>${product.productName}</td>
                                <td>${product.description}</td>
                                <td>${product.quantity}</td>
                                <td>${product.productUnit}</td>
                                <td>${product.popularity}</td>
                                <td class="action-buttons">
                                    <a href="<c:url value='/editProduct/${product.id}'/>" class="btn btn-primary">Edit</a>
                                    <a href="<c:url value='/deletingProduct/${product.id}'/>" class="btn btn-danger">Delete</a>
                                    <a href="${pageContext.request.contextPath}/viewDetails/${product.id}" class="btn btn-secondary">View Details</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty entry.value}">
                <p>No products available in this category.</p>
            </c:if>
        </c:forEach>
    </c:if>

    <c:if test="${empty productsByCategory}">
        <p>No products found matching your search criteria.</p>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
