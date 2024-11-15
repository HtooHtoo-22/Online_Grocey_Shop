<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Product List</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    
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
       
        h1 {
            margin-bottom: 20px;
            color: #ffffff;
            justify-content: center;
        }
        h2 {
            margin-top: 30px;
            margin-bottom: 15px;
            color: #ffffff;
        }
        
        table {
            background-color: #343a40;
            color: white;
        }
        th {
            background-color: #263043;
            color: white; 
        }
        td {
            background-color: #343a40; 
            color: #f5f5f5;
        }
        td img {
            max-width: 100px;
            height: auto;
            border-radius: 5px; 
        }
        .btn {
            margin-top: 5px;
        }
      
        tbody tr:hover {
            
        }
        /* Media queries for small screens */
        @media (max-width: 768px) {
            .container {
                margin-left: 0; 
                padding: 10px;
            }
            
        }
       .container {
	
   
    flex-grow: 1; 
    padding: 20px;
    color: rgba(255, 255, 255, 0.95);
    transition: margin-left 0.3s ease; /* Smooth transition */
}
.pd{
       width: 400%;
        margin-top: 60px;
        margin-left: 300px;
       
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
    <span class="badge badge-pill " style="font-size: 20px; padding: 1px 8px; position: absolute; top: -20px; right: -14px; color:red;font-weight: bold">
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
     
    <div class="pd">
        <h1>Admin Product List</h1>
        
        
       
        <a href="${pageContext.request.contextPath}/categoryList" class="btn btn-secondary mb-3">Category List</a>
        
        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/adminSearch" method="get" class="search-bar">
    <div class="input-group">
        <input type="text" name="query" class="form-control" placeholder="Search by product"  aria-label="Search" >
        <select name="categoryId" class="form-control">
            <option value="">Select Category</option>
            <c:forEach var="category" items="${categories}">
                <option value="${category.id}">${category.name}</option>
            </c:forEach>
        </select>
        <div class="input-group-append">
            <button class="btn btn-primary" type="submit">Search</button>
        </div>
    </div>
</form>

        <table class="table table-bordered mt-3">
        <thead>
            <tr>
             
                <th>ID</th>
                 <th>Category</th>
                <th>Name</th>
                <th>Description</th>
                <th>Image</th>
                <th>Popularity</th>
                <th>Quantity</th>
                <th>Unit</th>
                <th>Actions</th>
               
            </tr>
        </thead>
        <tbody>
            <c:forEach var="product" items="${products}" varStatus="status"> <!-- Assuming products is the list of all products -->
                <tr onclick="window.location='${pageContext.request.contextPath}/product/viewProducts/${product.category.id}'">
                    <td>${status.index + 1}</td>
                    <td>${product.category.name}</td>
                    <td>${product.productName}</td>
                    <td>${product.description}</td>
                    <td>
                        <c:if test="${not empty product.getBase64()}">
                            <img src="data:image/jpeg;base64,${fn:escapeXml(product.getBase64())}" alt="${product.productName}" />
                        </c:if>
                    </td>
                    <td>${product.popularity}</td>
                    <td>${product.quantity}</td>
                    <td>${product.productUnit}</td>
                    <td>
                    <a href="${pageContext.request.contextPath}/viewProducts/${product.category.id}" class="btn btn-secondary btn-sm"><i class="bi bi-box"></i> </a>
                       
                        <a href="${pageContext.request.contextPath}/viewDetails/${product.id}" class="btn btn-secondary btn-sm" title="View Details"><i class="bi bi-eye"></i></a>
                        <a href="<c:url value='/editProduct/${product.id}' />" class="btn btn-warning btn-sm"><i class="bi bi-pencil"></i></a>
                        <a href="<c:url value='/deletingProduct/${product.id}' />" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?');"><i class="bi bi-trash"></i></a>
                    </td>
                    
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- Pagination Controls -->
    <div class="pagination">
        <c:if test="${currentPage > 0}">
            <a href="?page=${currentPage - 1}" class="btn btn-secondary">Previous</a>
        </c:if>
        <c:forEach begin="0" end="${totalPages - 1}" var="i">
            <a href="?page=${i}" class="btn btn-secondary">${i + 1}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages - 1}">
            <a href="?page=${currentPage + 1}" class="btn btn-secondary">Next</a>
        </c:if>
    </div>
</div>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/admin.js"></script>
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