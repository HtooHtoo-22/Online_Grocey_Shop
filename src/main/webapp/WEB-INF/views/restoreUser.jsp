<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restore Deleted Users</title>
    <style>
        /* Overall black theme styling */
        body {
            background-color: #121212;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #FFFFFF;
            margin-bottom: 20px;
        }

        /* Table styling */
        table {
            width: 80%;
            border-collapse: collapse;
            margin-bottom: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.5);
        }

        th, td {
            padding: 10px;
            border: 1px solid #333333;
            text-align: center;
        }

        th {
            background-color: #333333;
            color: #FFFFFF;
        }

        tr:nth-child(even) {
            background-color: #1E1E1E;
        }

        tr:nth-child(odd) {
            background-color: #2B2B2B;
        }

        /* Link and button styling */
        a, .back-button {
            color: #1E90FF;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover, .back-button:hover {
            color: #63a4ff;
        }

        .restore-button {
            color: #FFFFFF;
            background-color: #1E90FF;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
        }

        .restore-button:hover {
            background-color: #006bb3;
        }
    </style>
</head>
<body>
    <h1>Restore Deleted Users</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Gender</th>
            <th>Action</th>
        </tr>
        <c:forEach var="user" items="${deletedUsers}">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.phNo}</td>
                <td>${user.gender}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/restoreuser/${user.id}" class="restore-button" onclick="return confirm('Are you sure you want to restore this user?')">Restore</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <a href="${pageContext.request.contextPath}/users" class="back-button">Back to User List Page</a>
</body>
</html>
