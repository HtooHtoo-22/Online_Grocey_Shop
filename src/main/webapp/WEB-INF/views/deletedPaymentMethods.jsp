<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Deleted Payment Methods</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #2C3E50; /* Dark background */
            color: #ECF0F1; /* Light text color */
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #34495E; /* Darker shade */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 30px;
            margin-top: 30px;
        }
        h2 {
            color: #ECF0F1;
            text-align: center;
            margin-bottom: 20px;
        }
        .table {
            background-color: #3C4A58; /* Darker table background */
            color: #ECF0F1;
        }
        .table th, .table td {
            padding: 15px;
            text-align: center;
        }
        .table th {
            background-color: #1ABC9C; /* Accent color for headers */
            color: #fff;
        }
        .table td img {
            border-radius: 5px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            text-decoration: none;
        }
        .btn-success {
            background-color: #2ECC71; /* Green accent for restore button */
            color: #fff;
        }
        .btn-success:hover {
            background-color: #27AE60;
        }
        .btn-primary {
            background-color: #3498DB; /* Blue accent for the back button */
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #2980B9;
        }
        .alert-warning {
            background-color: #F39C12;
            color: #fff;
            border-radius: 5px;
            padding: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Deleted Payment Methods</h2>

    <c:if test="${not empty deletedPaymentMethods}">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Payment Method Name</th>
                    <th>QR Code</th>
                    <th>Logo</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="paymentMethod" items="${deletedPaymentMethods}">
                    <tr>
                        <td>${paymentMethod.id}</td>
                        <td>${paymentMethod.payment_method_name}</td>
                        <td><img src="data:image/png;base64,${paymentMethod.getBase64()}" alt="QR Code" height="50"></td>
                        <td><img src="data:image/png;base64,${paymentMethod.logoGetBase64()}" alt="Logo" height="50"></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/restorePayment/${paymentMethod.id}" class="btn btn-success">Restore</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty deletedPaymentMethods}">
        <div class="alert alert-warning">No deleted payment methods found.</div>
    </c:if>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/paymentMethodList" class="btn btn-primary">Back to Payment Method List</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
