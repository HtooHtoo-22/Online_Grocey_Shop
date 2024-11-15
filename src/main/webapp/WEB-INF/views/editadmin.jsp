<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Admins</title>
    <style>
        body {
            background-color: #1e1e2f;
            color: #e0e0e0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background-color: #2a2a40;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
            max-width: 500px;
            width: 100%;
        }
        h1 {
            text-align: center;
            color: #ffffff;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 15px;
            color: #b0b0d0;
        }
        input[type="text"], input[type="email"], select {
            background-color: #3b3b52;
            color: #ffffff;
            border: 1px solid #555;
            padding: 10px;
            border-radius: 6px;
            margin-top: 5px;
            width: calc(100% - 22px);
            outline: none;
            transition: border 0.3s;
        }
        input[type="text"]:focus, input[type="email"]:focus, select:focus {
            border: 1px solid #7a7aee;
        }
        input[type="radio"] {
            margin-right: 8px;
        }
        button {
            background-color: #4c4cff;
            color: #ffffff;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s, transform 0.2s;
        }
        button:hover {
            background-color: #6b6bff;
            transform: translateY(-3px);
        }
        button:active {
            transform: translateY(1px);
        }
        .radio-group {
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Admins</h1>
        <form:form modelAttribute="admin" action="${pageContext.request.contextPath}/updateAdmin" method="post">
            <input type="hidden" name="id" value="${admin.id}" >
        
            <label>Name:</label>
            <input type="text" name="name" value="${admin.name}" required="required">
            
            <label>Email:</label>
            <input type="email" name="email" value="${admin.email}" required="required">
            
            <label>Gender:</label>
            <div class="radio-group">
                <input type="radio" id="male" name="gender" value="Male" ${admin.gender == 'Male' ? 'checked' : ''}>
                Male

                <input type="radio" id="female" name="gender" value="Female" ${admin.gender == 'Female' ? 'checked' : ''}>
                Female
            </div>

            <label>Role:</label>
            <select name="role">
                <option value="System Admin" ${admin.role == 'System Admin' ? 'selected' : ''}>System Admin</option>
                <option value="Admin" ${admin.role == 'Admin' ? 'selected' : ''}>Admin</option>
            </select>

            <button type="submit">Update</button>
        </form:form>
    </div>
</body>
</html>
