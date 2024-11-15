<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
     <style>
        /* Overall body styling for black theme */
        body {
            background-color: #121212;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        h1 {
            color: #FFFFFF;
            font-size: 2em;
            margin-top: 20px;
        }

        /* Form container styling */
        form {
            background-color: #1E1E1E;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.5);
            width: 300px;
        }

        label {
            color: #B3B3B3;
            font-weight: bold;
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
        }

        /* Input fields styling */
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #333;
            border-radius: 4px;
            background-color: #2B2B2B;
            color: #FFFFFF;
        }

        input[type="text"]:focus,
        input[type="email"]:focus {
            outline: none;
            border-color: #1E90FF;
        }

        /* Button styling */
        button[type="submit"] {
            background-color: #1E90FF;
            color: #FFFFFF;
            border: none;
            border-radius: 4px;
            padding: 10px 15px;
            cursor: pointer;
            font-size: 1em;
            width: 100%;
        }

        button[type="submit"]:hover {
            background-color: #006bb3;
        }
        /* Styling for the "Back to User List" link */
.back-button {
    display: inline-block;
    background-color: #333333;
    color: #FFFFFF;
    text-decoration: none;
    padding: 10px 15px;
    border-radius: 4px;
    font-size: 1em;
    font-weight: bold;
    margin-top: 15px;
    transition: background-color 0.3s ease;
}

.back-button:hover {
    background-color: #555555;
}
        
    </style>
</head>
<body>
    <h1>Edit User</h1>
    <form:form modelAttribute="user" action="${pageContext.request.contextPath}/updateUser" method="post">
        <input type="hidden" name="id" value="${user.id}">
    
        <label>Name:</label>
        <input type="text" name="name" value="${user.name}" required="required"><br>
        
        <label>Email:</label>
        <input type="email" name="email" value="${user.email}" required="required"><br>
        
        <label>Phone Number:</label>
    	<input type="text" name="phNo" value="${user.phNo}" required="required"><br>
    	
    	<label>Gender:</label>
    	
    	<label>
    <input type="radio" name="gender" value="male" ${user.gender == 'male' ? 'checked' : ''}/> Male
</label>
<br/>
<label>
    <input type="radio" name="gender" value="female" ${user.gender == 'female' ? 'checked' : ''}/> Female
</label>
<br/>

        <button type="submit">Update</button>
    </form:form>
    <a href="${pageContext.request.contextPath}/users" class="back-button">Back To User List</a>

</body>
</html>
