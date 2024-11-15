
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f7f7f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            max-width: 900px;
            margin-top: 50px;
        }

        .card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            padding: 20px;
        }

        .card-header {
            background-color: #007BFF;
            color: #fff;
            padding: 15px;
            font-size: 1.5rem;
            border-radius: 15px 15px 0 0;
            text-align: center;
        }

        .table {
            margin-top: 20px;
        }

        .table thead {
            background-color: #f8f9fa;
        }

        .table th, .table td {
            text-align: center;
            padding: 15px;
            font-size: 1.1rem;
            border: 1px solid #ddd;
        }

        .table tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .total-amount {
            background-color: #28a745;
            color: #fff;
            font-size: 1.2rem;
            padding: 15px;
            border-radius: 8px;
            text-align: right;
            margin-top: 30px;
        }

        .btn-back, .btn-download {
            color: white;
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
        }

        .btn-back {
            background-color: #17a2b8;
        }

        .btn-back:hover {
            background-color: #138496;
        }

        .btn-download {
            background-color: #007bff;
        }

        .btn-download:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="card">
            <div class="card-header">
                Order Details
            </div>

            <!-- Status Message and Download Button -->
            <div class="status-message">
                <c:choose>
                    <c:when test="${history.status == 1}">
                        <p>Please wait for admin response.</p>
                    </c:when>
                    <c:when test="${history.status == 0}">
                        <p>Order has been canceled.</p>
                    </c:when>
                    <c:when test="${history.status == 2}">
                        <p>Order is complete. You can download your voucher below.</p>
                        <a href="${pageContext.request.contextPath}/downloadVoucher/${history.orderId}" class="btn btn-download">Download Voucher</a>
                    </c:when>
                </c:choose>
            </div>


<!-- Order Details Table -->
            <table class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                    <th>#</th>
                        <th>Order Item</th>
                        <th>Order Quantity</th>
                        <th>Pack</th>
                        <th>Price</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="history" items="${historyList}" varStatus="hh">
                        <tr>
                        	<td>${hh.index + 1}</td>
                            <td>${history.orderItem}</td>
                            <td>${history.orderQuantity}</td>
                            <td>${history.perQuantity} ${history.unit}</td>
                            <td>${history.price}</td>
                            <td>${history.totalPrice}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Display Total Amount below the table -->
            <div class="total-amount">
                <h3>Total Amount: ${totalAmount}</h3>  <!-- Access totalAmount here -->
            </div>

            <!-- Back Button -->
            <a href="/Project/history" class="btn-back">Back to Order History</a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>