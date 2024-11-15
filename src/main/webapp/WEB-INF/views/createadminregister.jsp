<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1d2634;
            color: #fff;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #3a4f63;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            color: #fff;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #fff;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="radio"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            color: #333;
        }

        input[type="radio"] {
            width: auto;
            display: inline-block;
            margin: 10px 5px 10px 0;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .alert {
            padding: 10px;
            background-color: #f8d7da;
            color: #721c24;
            margin-bottom: 20px;
            border-radius: 4px;
            display: none;
        }

        .alert.show {
            display: block;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Create Admin</h2>

    <!-- Display error message if exists -->
    <div id="errorMessage" class="alert"></div>

    <form name="createAdminForm" action="${pageContext.request.contextPath}/save" method="post" onsubmit="return validateForm()">
        <label for="name">Name:</label>
        <input type="text" name="name" required>
        
        <label for="email">Email:</label>
        <input type="email" name="email" required>
        
        <label for="password">Password:</label>
        <input type="password" name="password" required>
        
        <label for="gender">Gender:</label><br>
        <input type="radio" id="male" name="gender" value="Male" required>
        Male
        <br>
        <input type="radio" id="female" name="gender" value="Female" required>
        Female
        
        <button type="submit">Create Admin</button>
    </form>
</div>

<script>
    function validateForm() {
        var email = document.createAdminForm.email.value;
        var password = document.createAdminForm.password.value;
        var errorMessage = document.getElementById("errorMessage");
        errorMessage.innerHTML = ''; // Clear previous error messages

        // Email Validation (basic format check)
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if (!emailPattern.test(email)) {
            errorMessage.innerHTML = 'Please enter a valid email address.';
            errorMessage.classList.add("show");
            return false;
        }

        // Password Validation (at least 8 characters, includes letters and numbers)
        var passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$/;
        if (!passwordPattern.test(password)) {
            errorMessage.innerHTML = 'Password must be at least 8 characters long and contain both letters and numbers.';
            errorMessage.classList.add("show");
            return false;
        }

        // If everything is valid
        return true;
    }
</script>

</body>
</html>
