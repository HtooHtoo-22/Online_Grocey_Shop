<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Payment Method</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1d2634; /* Dark theme background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #ffffff; /* White text */
        }
        form {
            background-color: #2a3c4d; /* Darker form background */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            width: 400px;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
            color: #ffffff; /* White label text */
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 4px;
            border: 1px solid #444; /* Dark border */
            background-color: #3a4b5b; /* Slightly lighter background for inputs */
            color: #ffffff; /* White text in inputs */
        }
        input[type="text"]:focus, input[type="file"]:focus {
            border-color: #28a745; /* Green border when focused */
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745; /* Green button */
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .btn-secondary {
            background-color: #6c757d; /* Gray button */
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            text-decoration: none;
            margin-top: 5px;
            display: inline-block;
        }
        .btn-secondary:hover {
            background-color: #5a6268; /* Darker gray on hover */
        }
        .error {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form action="${pageContext.request.contextPath}/createPaymentMethod" method="post" enctype="multipart/form-data">
        <label for="payment_method_name">Payment Method Name:</label>
        <input type="text" id="payment_method_name" name="payment_method_name" required>
        
        <label for="file">QR Code:</label>
        <input type="file" id="file" name="file" accept="image/*" required>
        
        <label for="logoFile">Logo:</label>
        <input type="file" id="logoFile" name="logoFile" accept="image/*" required>
        
        <button type="submit">Create</button>
        <a href="${pageContext.request.contextPath}/paymentMethodList" class="btn-secondary">Cancel</a>
        
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
    </form><br>
</body>
</html>
