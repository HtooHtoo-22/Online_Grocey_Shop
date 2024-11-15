<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Category List</title>
    <!-- Bootstrap CSS -->
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
     
       
       
  
.grid-container {
    display: flex; /* Flexbox for layout */
}

/* Fixed Sidebar Styles */

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

h2 {
    margin-bottom: 15px;
    color: white;
}

.btn {
    margin-right: 10px; 
}

table {
    background-color: #1d2634;
    border-radius: 0.5rem; 
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); 
}

th, td {
    vertical-align: middle;
    color: white;
}

.btn-group .btn {
    margin-bottom: 5px; 
}

/* Media queries for small screens */
@media (max-width: 768px) {
    #sidebar {
        width: 100%; /* Make sidebar full width on small screens */
        height: auto; /* Let it adjust to content */
        position: relative; /* Allow it to scroll with the content */
    }
    
    .container {
        margin-left: 0; /* Reset margin on small screens */
        padding: 10px;
    }
}
.cat{
 width: 390%;
        margin-top: 60px;
        margin-left: 300px;
}
       

        /* Media queries for small screens */
     
    </style>
</head>
<body>

<div class="grid-container">
    <!-- Header -->
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
 
    <!-- End Header -->

    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="cat">
    <div class="mb-3">
        <h4>Category Actions</h4>
        <a href="${pageContext.request.contextPath}/showAddCategory" class="btn btn-primary"><i class="bi bi-plus"></i>Add Category</a>
        <a href="${pageContext.request.contextPath}/deletedCategories" class="btn btn-primary">Restore Category</a>
    </div>

    <h2 class="mb-4">Categories</h2>

    <c:if test="${not empty categories}">
        <table id="categoryTable" class="table table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Photo</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="category" items="${categories}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${category.name}</td>
                        <td>
                            <c:if test="${not empty category.photoByte}">
                                <img src="data:image/jpeg;base64,${fn:escapeXml(category.base64)}" alt="Category Photo" width="100"/>
                            </c:if>
                            <c:if test="${empty category.photoByte}">
                                No Photo Available
                            </c:if>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <a href="${pageContext.request.contextPath}/edit/${category.id}" class="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil"></i> 
                                </a>
                                <a href="${pageContext.request.contextPath}/delete/${category.id}" 
                                   class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this category?');">
                                    <i class="bi bi-trash"></i> 
                                </a>
                                <a href="${pageContext.request.contextPath}/viewProducts/${category.id}" class="btn btn-secondary btn-sm">View Products</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty categories}">
        <div class="alert alert-warning">No categories found.</div>
    </c:if>
</div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/admin.js"></script>
<script>
$(document).ready(function() {
    $('#categoryTable').DataTable({
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
