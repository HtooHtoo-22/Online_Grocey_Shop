<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Detail History</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #000000; /* Black background */
            color: #ffffff; /* White text */
        }
        h1 {
            color: #ffffff; /* White heading */
            margin-bottom: 20px; /* Space below heading */
        }
        a {
            color: #007bff; /* Bootstrap primary color for links */
            text-decoration: none; /* Remove underline */
        }
        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
        table {
            width: 100%; /* Full width for table */
            margin-top: 20px; /* Space above table */
            border-collapse: collapse; /* Collapse borders */
        }
        th, td {
            border: 1px solid #454d55; /* Dark border for table cells */
            padding: 10px; /* Padding inside table cells */
            text-align: left; /* Align text to the left */
        }
        th {
            background-color: #212529; /* Dark header background */
            color: #ffffff; /* White text in header */
        }
        tr:nth-child(even) {
            background-color: #343a40; /* Darker background for even rows */
        }
        img {
            width: 100px; /* Fixed width for images */
            height: auto; /* Maintain aspect ratio */
        }
        .no-history {
            margin-top: 20px; /* Space above message */
        }
    </style>
</head>
<body>

    <div class="container mt-5">
       
        <h1>Detail History for Product : ${pdtName}</h1>

        <c:if test="${not empty historyDetails}">
            <table>
                <thead>
                    <tr>
                        <th>Detail ID</th>
                        <th>Unit</th>
                        <th>Price</th>
                        <th>Per Quantity</th>
                        <th>Product Name</th>
                        <th>Product Image</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${historyDetails}">
                        <tr>
                            <td>${detail.id}</td>
                            <td>${detail.unit}</td>
                            <td>${detail.price}</td>
                            <td>${detail.perQuantity}</td>
                            <td>${detail.product.productName}</td>
                            <td>
                                <c:if test="${not empty detail.product.productPhotoByte}">
                                    <img src="data:image/jpeg;base64,${fn:escapeXml(detail.product.getBase64())}" alt="Product Image"/>
                                </c:if>
                            </td>
                            <td>${detail.product.description}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty historyDetails}">
            <p class="no-history">No detail history available for this product.</p>
        </c:if>
         <div>
            <a href="${pageContext.request.contextPath}/viewDetails/${productId}" class="btn btn-secondary">Return to Detail List</a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
