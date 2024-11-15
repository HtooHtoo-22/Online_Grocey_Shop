<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  
  <!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- DataTables JS -->
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
  
  
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/admin.css?v=1.0">
    <style>
       
       #sidebar {
    position: fixed; /* Fix the sidebar */
    left: 0; /* Align to the left */
    top: 0; /* Align to the top */
    bottom: 0; /* Stretch to the bottom */
    width: 260px; /* Set width */
    background-color: #2c3443; /* Background color */
    padding: 20px; /* Padding for the sidebar */
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5); /* Optional shadow for depth */
    z-index: 1000; /* Ensure it stays above other elements */
}
        .btn {
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn:hover {
            transform: scale(1.05); 
        }
        .ulul{
 width: 77%;
        margin-top: 10px;
        margin-left: 300px;
}
   
    </style>
</head>
<body>

<div class="menu-icon" onclick="openSidebar()">
    <span class="bi bi-list" style="font-size: 30px; cursor: pointer;"></span>
</div>

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
<div class="ulul">
    <h1 class="mt-4">Customers Management</h1>
    <a href="${pageContext.request.contextPath}/deletedUsers" class="btn btn-secondary mb-3">Restore Deleted Users</a>
    <table id="userTable" class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Gender</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}" varStatus="hehe">
                <tr>
                    <td style="color: white;">${hehe.index + 1}</td>
                    <td style="color: white;">${user.name}</td>
                    <td style="color: white;">${user.email}</td>
                    <td style="color: white;">${user.phNo}</td>
                    <td style="color: white;">${user.gender}</td>
                    <td>
                        <a href="edituser/${user.id}" class="btn btn-warning btn-sm">
                            <i class="bi bi-pencil"></i> 
                        </a>
                        <a href="${pageContext.request.contextPath}/deleteuser/${user.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this user?')">
                            <i class="bi bi-trash"></i> 
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/js/scripts.js' />"></script>
<script>
$(document).ready(function() {
    $('#userTable').DataTable({
        pageLength: 5// Set the number of rows per page
         // Sort by the first column in descending order
    });
});
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
