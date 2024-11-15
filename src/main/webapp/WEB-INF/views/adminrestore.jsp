<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Restore Deleted Admins</title>
    <style>
        body {
            background-color: #1d2634; /* Dark gray-blue background */
            color: #ffffff; /* White text */
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #ffffff; /* White heading */
            text-align: center;
            margin-top: 50px;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #2a3c4d; /* Darker table background */
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #444; /* Slightly lighter border for table */
        }
        th {
            background-color: #3c4f61; /* Slightly lighter background for headers */
            color: #ffffff; /* White text for table headers */
        }
        td {
            background-color: #2a3c4d; /* Same as table background for rows */
            color: #d1d9e6; /* Light gray text for data */
        }
        a {
            color: #28a745; /* Green link color */
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h1>Restore Deleted Admins</h1>
    <table>        
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Role</th>
            <th>Email</th>
            <th>Gender</th>
            <th>Action</th>
        </tr>
        <c:forEach var="admin" items="${deletedAdmins}">
            <tr>
                <td>${admin.id}</td>
                <td>${admin.name}</td>
                <td>${admin.role}</td>
                <td>${admin.email}</td>
                <td>${admin.gender}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/restoreadmin/${admin.id}" onclick="return confirm('Are you sure you want to restore this admin?')">Restore</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/admins">Back to Admin List Page</a>
    </div>
</body>
</html>
