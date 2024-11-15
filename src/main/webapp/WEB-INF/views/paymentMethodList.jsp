<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Methods List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/admin.css?v=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh;
             overflow-x: hidden;
          
           
        }
        .container {
            display: flex; 
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            width: 100%;
            
           
        }
        
           table {
    width: 100%;
    margin: 20px 0;
    border: 1px solid #ddd;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #1d2634;
    border-radius: 0.5rem;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 12px;
    text-align: left;
    vertical-align: middle;
    color: white;
     border-right: 1px solid #ddd;
}

th {
    background-color: #1d2634;
    font-weight: bold;
}

tr:nth-child(odd) {
    background-color: #2c3e50; 
}

tr:nth-child(even) {
    background-color: #34495e; 
}

tr {
    border-bottom: 1px solid #fff; 
}
td:last-child, th:last-child {
    border-right: none; 
}



        img {
            max-width: 100px;
        }

       
         

        

        /* General button style */
.btn {
    padding: 8px 16px; /* Smaller padding */
    font-size: 0.875rem; /* Adjust font size */
    text-decoration: none;
    color: white;
    border-radius: 4px;
    display: inline-block;
    height: auto; /* Let the height adjust based on content */
    min-width: 100px; /* Set a minimum width for consistency */
    text-align: center; /* Ensure text is centered */
}

/* Primary Button */
.btn-primary {
    background-color: #007bff;
}

/* Warning Button */
.btn-warning {
    background-color: #ffc107;
}

/* Danger Button */
.btn-danger {
    background-color: #dc3545;
}

/* Small Button (btn-sm) */
.btn-sm {
    font-size: 0.75rem; /* Smaller font for small buttons */
    padding: 5px 10px; /* Smaller padding for small buttons */
}

/* Adjust button margins if needed */
.mb-3 {
    margin-bottom: 15px; /* Reduce bottom margin */
}
.custom-btn {
  font-size: 14px;  /* Smaller text */
  padding: 5px 10px;  /* Adjust padding for smaller size */
  border-radius: 20px;  /* Round corners */
}

.custom-btn:hover {
  background-color: #0056b3;  /* Darker blue on hover */
}
.butt{

padding: 8px 20px; 
font-size: 14px;
height: 40px; 
}
.butt a:hover {
    background-color: #0056b3; /* Darker blue on hover */
  }
.hdr{
margin-bottom: 10px;
}
.pt{
        width: 220%;
        margin: 10px;
       
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

        <!-- Include Sidebar -->
        
        <!-- Header -->
   <!-- Header -->
   
    <!-- End Header -->
    <!-- Table of Payment Methods -->
     
  
 <div class="pt">
   <div class="butt">
  <a href="${pageContext.request.contextPath}/showCreatePaymentMethod" style="text-decoration: none; color: white; padding: 8px 20px; font-size: 14px; height: 40px; display: inline-block; border-radius: 5px; background-color: #007bff; transition: background-color 0.3s ease;">
    <i class="fas fa-plus-circle" style="margin-right: 8px;"></i> Add Payment Method
  </a>
  <a href="${pageContext.request.contextPath}/deletedPaymentMethods" style="text-decoration: none; color: white; padding: 8px 20px; font-size: 14px; height: 40px; display: inline-block; border-radius: 5px; background-color: #007bff; transition: background-color 0.3s ease;">
    <i class="fas fa-undo" style="margin-right: 8px;"></i> Restore Payment Method
  </a>
</div> 


    <table>
        <thead>
        <tr>
        
        </tr>
            <tr>
                <th>#</th>
                <th>Payment Method Name</th>
                <th>QR Code</th>
                <th>Logo</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="paymentMethod" items="${payment_method_names}" varStatus="payment">
                <tr>
                    <td>${payment.index +1}</td>
                    <td>${paymentMethod.payment_method_name}</td>
                    <td>
                        <c:if test="${not empty paymentMethod.qr_code}">
                            <img src="data:image/png;base64,${paymentMethod.getBase64()}" alt="QR Code" />
                        </c:if>
                    </td>
                     <td>
                        <c:if test="${not empty paymentMethod.logo}">
                            <img src="data:image/png;base64,${paymentMethod.logoGetBase64()}" alt="Logo" />
                        </c:if>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/editPayment/${paymentMethod.id}" 
                        class="btn btn-warning btn-sm"  onclick="return confirm('Do you want to edit this payment method?');">  <i class="fas fa-edit"></i></a>
                        <a href="${pageContext.request.contextPath}/deletePayment/${paymentMethod.id}" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Are you sure you want to delete this payment method?');">
                           <i class="fas fa-trash-alt"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
   
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    </div>
	
	
    <!-- Add Payment Method Button -->
    
  

    <!-- Success Message -->
    
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
