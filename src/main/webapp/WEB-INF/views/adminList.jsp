<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #1d2634;
            display: flex;
            overflow-x: hidden; 
        }
       
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #343a40;
            color: white;
        }
        th {
            padding: 15px;
            border: 2px solid #495057;
            text-align: left;
            background-color: #495057;
            color: #ffffff; 
        }
        
        th {
            background-color: #495057; 
        }
        tr:hover {
            background-color: #495057; 
        }
        .btn {
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn:hover {
            transform: scale(1.05); 
        }
        .adad{
        width: 150%;
        margin: 10px;
        margin-left: 90px;
       
        }
         .cA {
        display: inline-block;
        padding: 12px 25px;
        font-size: 18px;
        text-align: center;
        text-decoration: none;
        border-radius: 6px;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        width: 20%;
        margin-top: 20px;
        transition: background-color 0.3s, transform 0.3s ease-in-out;
    }

    .cA:hover {
        background-color: #0056b3;
        transform: translateY(-2px); /* Slight lift effect */
    }

    .cA:active {
        background-color: #004085;
        transform: translateY(2px); /* Link appears pressed down */
    }

    .cA:focus {
        outline: none;
        box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.5); /* Adds blue outline on focus */
    }
    </style>
</head>
<body>
<div class="grid-container">
 <header class="header">
        <div class="menu-icon" onclick="openSidebar()">
            <span class="material-icons-outlined">menu</span>
        </div>
        <div class="header-left">
            <span class="material-icons-outlined"></span>
        </div>
        <div class="header-right">
        	<div style="position: relative; display: inline-block;">
     
    <span class="material-icons-outlined " style="font-size: 24px; color: white;">notifications</span>
    
  <c:if test="${not empty pendingCount && pendingCount > 0}">
    <span class="badge badge-pill badge-danger" style="font-size: 20px; padding: 1px 8px; position: absolute; top: -20px; right: -14px; color:red;font-weight: bold">
        ${pendingCount}
    </span>
    </c:if>
    
</div>	
            <span class="header-admin-name">${adminName}</span>
            <div class="profile-photo">
                 <img src="${pageContext.request.contextPath}/resources/static/images/admin1.jfif" alt="Profile Photo">
            </div>
             <a href="adminLogOut" class="logout-button" onclick="return confirm('Are you sure you want to log out?');">Log Out</a>

        </div>
    </header>
 
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="adad">
    <h1 class="mt-4">Admin Management</h1>
    <a href="${pageContext.request.contextPath}/deletedadmin" class="btn btn-secondary mb-3">Restore Deleted Admins</a>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Role</th>
                <th>Email</th>
                <th>Gender</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="admin" items="${admins}" varStatus="aa">
                <tr>
                    <td style="color: white;">${aa.index + 1}</td>
                    <td style="color: white;">${admin.name}</td>
                    <td style="color: white;">${admin.role}</td>
                    <td style="color: white;">${admin.email}</td>
                    <td style="color: white;">${admin.gender}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/editadmin/${admin.id}" class="btn btn-warning btn-sm">
    <i class="bi bi-pencil"></i> 
</a>
<a href="${pageContext.request.contextPath}/deleteadmin/${admin.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this admin?')">
    <i class="bi bi-trash"></i> 
</a>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="createadminregister" class="cA">Create Admin</a>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/js/scripts.js' />"></script>
<script>
var sidebarOpen = false;
var sidebar = document.getElementById("sidebar");

function openSidebar() {
    if (!sidebarOpen) {
        sidebar.classList.add("sidebar-responsive");
        sidebarOpen = true;
    }
}

function closeSidebar() {
    if (sidebarOpen) {
        sidebar.classList.remove("sidebar-responsive");
        sidebarOpen = false;
    }
}
</script>
</body>
</html>
