<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Payment Method</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>"> <!-- Include your CSS file -->
    <script src="<c:url value='/resources/js/script.js'/>"></script> <!-- Include your JS file -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1d2634 ;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background: #3a4f63;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: white; /* Yellow color for heading */
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #e0e0e0; /* Lighter color for label text */
        }
        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        img {
            margin: 10px 0;
            border: 1px solid #ddd;
            padding: 5px;
            border-radius: 4px;
            max-width: 100%;
            height: auto;
        }
        .alert {
            padding: 10px;
            margin-top: 20px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
        .text-danger {
            color: #e74c3c; /* Adjusting error text color */
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Payment Method</h2>

   <form:form modelAttribute="paymentMethod" action="${pageContext.request.contextPath}/updatePayment/${paymentMethod.id}" method="post" enctype="multipart/form-data">
    <form:hidden path="id" />
    
    <div class="form-group">
        <label for="payment_method_name">Payment Method Name:</label>
        <form:input path="payment_method_name" class="form-control" id="payment_method_name" placeholder="Enter payment method name" required=""/>
        <form:errors path="payment_method_name" cssClass="text-danger"/>
    </div>

    <div class="form-group">
        <label for="qr_code">Current QR Code:</label>
        <c:if test="${not empty paymentMethod.qr_code}">
            <img src="data:image/png;base64,${paymentMethod.getBase64()}" alt="QR Code"/>
        </c:if>
        <label for="file">Upload New QR Code (optional):</label>
        <form:input type="file" path="file" class="form-control" id="file"/>
        <form:errors path="file" cssClass="text-danger"/>
    </div>

    <div class="form-group">
        <label for="logo">Current Logo:</label>
        <c:if test="${not empty paymentMethod.logo}">
            <img src="data:image/png;base64,${paymentMethod.logoGetBase64()}" alt="Logo"/>
        </c:if>
        <label for="logoFile">Upload New Logo (optional):</label>
        <form:input type="file" path="logoFile" class="form-control" id="logoFile"/>
        <form:errors path="logoFile" cssClass="text-danger"/>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-primary">Update Payment Method</button>
        <a href="${pageContext.request.contextPath}/paymentMethodList" class="btn btn-secondary">Cancel</a>
    </div>
</form:form>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
</div>

</body>
</html>
