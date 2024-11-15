<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Category</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #1d2634; /* Black background */
            color: #ffffff; /* White text */
        }

        .form-container {
            background-color:  #1d2634;; /* Dark gray background for container */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
            width: 300px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #ffffff; /* White text */
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #ffffff; /* White text */
        }

        input[type="text"], input[type="file"], input[type="submit"] {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border-radius: 3px;
            border: 1px solid #444444; /* Dark border */
            background-color: #333333; /* Dark input background */
            color: #ffffff; /* White text in input */
        }

        input[type="submit"] {
            background-color: #4CAF50; /* Green button */
            color: #ffffff;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green on hover */
        }

        .error-message {
            color: #ff4444; /* Red text for errors */
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add New Category</h2>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form:form method="post" action="${pageContext.request.contextPath}/addCategory" 
                   modelAttribute="category" enctype="multipart/form-data">
            <div>
                <label for="name">Category Name:</label>
                <form:input path="name" id="name" required="required"/>
            </div>
            <div>
                <label for="photo">Upload file:</label>
                <form:input path="file" id="photo" type="file"/>
            </div>
            <div>
                <input type="submit" value="Add Category" />
            </div>
        </form:form>
    </div>
</body>
</html>
