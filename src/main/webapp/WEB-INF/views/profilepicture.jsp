<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="project.Service.BlankProfilePhoto" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Profile Picture</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff9db; /* Soft yellow background */
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 30%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #ffcc00; /* Yellow color for headings */
        }
        img {
            border-radius: 50%; /* Circular image */
            margin-bottom: 20px;
        }
        .btn {
            background-color: #ffcc00;
            color: #fff;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }
        .btn:hover {
            background-color: #e6b800; /* Darker yellow on hover */
        }
        input[type="file"] {
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
        }
        .hidden {
            display: none;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Profile Picture</h2>

    <c:if test="${userProfile.gender == 'male' && changePhoto == null}">
        <c:set var="malePhoto" value="${BlankProfilePhoto.getMalePhoto()}" />
        <img src="data:image/jpeg;base64,${malePhoto}" alt="Male Profile Photo" width="200" height="200"/>
    </c:if>

    <c:if test="${userProfile.gender == 'female' && changePhoto == null}">
        <c:set var="femalePhoto" value="${BlankProfilePhoto.getFemalePhoto()}" />
        <img src="data:image/jpeg;base64,${femalePhoto}" alt="Female Profile Photo" width="200" height="200"/>
    </c:if>

    <c:if test="${changePhoto != null}">
        <img src="data:image/jpeg;base64,${changePhoto}" alt="Uploaded Profile Photo" width="200" height="200"/>
    </c:if>

    <!-- Form to change profile photo -->
    <form action="changeProfile" method="post" enctype="multipart/form-data">
        <input type="file" name="file" required>
        <input type="submit" class="btn" value="Change Profile">
    </form>

    <!-- Form to create account with hidden photo -->
    <form action="createAccount" method="post">
        <input type="submit" class="btn" value="Create Account">
        <input type="hidden" name="photo" value="${changePhoto}" />
    </form>

    <!-- Optionally add a signup link -->
    
</div>

</body>
</html>
