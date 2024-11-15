<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff9db;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 40%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #ffcc00;
        }
        label {
            font-size: 16px;
            color: #555;
        }
        form input[type="text"], 
        form input[type="password"], 
        form input[type="email"], 
        form input[type="file"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        form input[type="submit"] {
            background-color: #ffcc00;
            color: #fff;
            border: none;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            margin: 8px 0;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }
        form input[type="submit"]:hover {
            background-color: #e6b800;
        }
        .text-danger {
            color: #ff3333;
            font-size: 14px;
        }
        form input[type="radio"] {
            margin-right: 5px;
        }
        .error {
            font-size: 14px;
            color: #ff3333;
        }
    </style>
    <script>
    function validateForm() {
        var email = document.forms["userForm"]["email"].value;
        var password = document.forms["userForm"]["password"].value;
        var confirmPassword = document.forms["userForm"]["confirmPassword"].value;
        var phone = document.forms["userForm"]["phone"].value;

        var emailError = document.getElementById("emailError");
        var passwordError = document.getElementById("passwordError");
        var confirmPasswordError = document.getElementById("confirmPasswordError");
        var phoneError = document.getElementById("phoneError");

        // Clear previous error messages
        emailError.innerHTML = "";
        passwordError.innerHTML = "";
        confirmPasswordError.innerHTML = "";
        phoneError.innerHTML = "";

        // Email validation
        if (email == "") {
            emailError.innerHTML = "Email is required.";
            return false;
        }
        if (!email.endsWith("@gmail.com")) {
            emailError.innerHTML = "Please use a Gmail address (ending with @gmail.com).";
            return false;
        }

        // Password validation
        if (password.length < 8) {
            passwordError.innerHTML = "Password must be at least 8 characters long.";
            return false;
        }
        if (password !== confirmPassword) {
            confirmPasswordError.innerHTML = "Passwords do not match.";
            return false;
        }

        // Phone number validation
        if (phone.length !== 11) {
            phoneError.innerHTML = "Phone number must be exactly 11 digits.";
            return false;
        }
        if (!phone.startsWith("09")) {
            phoneError.innerHTML = "Phone number must start with '09'.";
            return false;
        }

        return true;
    }

    </script>
</head>
<body>

    <div class="container">
        <h2>Register</h2>
        <form:form modelAttribute="user" name="userForm" action="register" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

            <label for="name">Name:</label>
            <form:input path="name" required="true"/><br>

            <label>Gender:</label>
            <form:radiobutton path="gender" value="male" required="true"/>Male
            <form:radiobutton path="gender" value="female" required="true"/>Female<br>

            <span class="error">${EmailDuplicateError}</span><br>

            <label for="email">Email:</label>
            <form:input path="email" required="true"/>
            <span id="emailError" class="text-danger"></span><br>

            <label for="password">Password:</label>
            <form:input path="password" type="password" required="true"/>
            <span id="passwordError" class="text-danger"></span><br>

            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" name="confirmPassword" /> 
            <span id="confirmPasswordError" class="text-danger"></span><br>
			<label for="phone">Phone No:</label>
			<form:input path="phone" required="true"/>
			<span id="phoneError" class="text-danger"></span><br>

            <input type="submit" value="Register"/>

        </form:form>
    </div>

</body>
</html>
