<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #fff9db;
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
        color: #ffcc00;
    }
    form input[type="text"],
    form input[type="password"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border-radius: 5px;
        border: 1px solid #ddd;
    }
    form input[type="submit"] {
        background-color: #ffcc00;
        color: #fff;
        border: none;
        padding: 12px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 5px;
        width: 100%;
    }
    form input[type="submit"]:hover {
        background-color: #e6b800;
    }
    .error {
        color: red;
        margin-bottom: 10px;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <form:form modelAttribute="loginBean" action="login" method="post">
        <div class="error">${EmailNotFound}</div>
        <label for="email">Email</label>
        <form:input path="email" required="true" id="email"/><br>

        <div class="error">${WrongPassword}</div>
        <label for="password">Password</label>
        <form:input path="password" required="true" type="password" id="password"/><br><br>
<a href="registration" style="color: #007bff; text-decoration: none;">Create a User Account</a>
<br><br>

        <input type="submit" value="Login">
    </form:form>
   
</div>

</body>
</html>
