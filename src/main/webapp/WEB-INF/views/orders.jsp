<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Orders</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/admin.css?v=1.0">
     <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
  <style>
   body, html {
    margin: 0;
    padding: 0;
    height: 100%;
    overflow: hidden; /* Prevent body scroll */
    background-color: #1d2634; /* Background color for the body */
    font-family: 'Montserrat', sans-serif; /* Font style */
}



#sidebar {
    width: 250px; /* Width of the sidebar */
    background-color: #343a40; /* Sidebar background color */
    color: white; /* Sidebar text color */
    height: 100vh; /* Full height for sidebar */
    position: fixed; /* Fixed position */
    padding: 20px; /* Padding inside sidebar */
    transition: 0.3s; /* Smooth transition */
}

.sidebar-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
}



.container {
    min-height: 100%; /* Ensure the container is tall enough to fill the viewport */
    overflow-y: auto; /* Enable vertical scrolling for the container */
    width:500%;
}
.layout {
    display: flex;
    flex-direction: column;
    height: 100vh; /* Ensure full viewport height */
    overflow-y: auto; /* Allow scrolling if content exceeds the screen */
}

.table {
    width: 100%; /* Full width of the container */
    border-collapse: collapse; /* Collapse borders for a cleaner look */
    margin-top: 0; /* No top margin */
}

/* Remove padding from table cells */
.table td, .table th {
    padding: 4px; /* Optional padding for cells */
    border: 1px solid #444; /* Optional border for clarity */
    color: white; /* Text color for table cells */
    vertical-align: middle; /* Aligns content vertically */
}

/* Header styling */
th {
    background-color: #343a40; /* Dark background for headers */
}

/* Optional: Hover effect for the table rows */
.table tbody tr:hover {
    background-color: #444; /* Highlight color on hover */
}

/* Optional: Brightening the hover effect for table cells */
.table tbody tr td:hover {
    background-color: #555; /* Bright hover effect for table cells */
    color: #fff; /* Keep text color readable on hover */
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .main-content {
        margin-left: 0; /* Remove left margin on smaller screens */
    }
}

/* General DataTables Styling for Bright Text on Dark Theme */
.dataTables_wrapper {
    color: #ffffff; /* General text color for DataTables */
}

/* Pagination button styles */
.dataTables_wrapper .dataTables_paginate .paginate_button {
    color: #ffffff !important; /* White text */
    background-color: #444444 !important; /* Dark gray button background */
    border: 1px solid #888888; /* Light gray border */
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover {
    color: white !important; /* Black text on hover */
    background-color: #ffffff !important; /* Bright white background on hover */
    border: 1px solid #cccccc; /* Light gray border */
}

/* Brighter Search Bar */
.dataTables_wrapper .dataTables_filter input {
    color: #ffffff; /* White text */
    background-color: #555555; /* Darker background to stand out */
    border: 1px solid #aaaaaa; /* Bright border */
    padding: 6px 10px;
    font-weight: bold;
}

/* Entries Dropdown for Consistency */
.dataTables_wrapper .dataTables_length select {
    color: #ffffff; /* White text */
    background-color: #555555; /* Dark dropdown background */
    border: 1px solid #aaaaaa; /* Light gray border */
}

/* Table Header */
table.dataTable thead {
    background-color: #333333; /* Darker header background */
}

table.dataTable thead th {
    color: #ffffff; /* White text for headers */
    border-bottom: 1px solid #777777; /* Border for headers */
}

/* Table Body */
table.dataTable tbody tr {
    background-color: #1a1a1a; /* Dark background for table rows */
    color: #ffffff; /* White text for rows */
}

table.dataTable tbody tr:hover {
    background-color: #444444; /* Brighter row on hover */
}

/* Info Text at Bottom */
.dataTables_wrapper .dataTables_info {
    color: #cccccc; /* Light gray for info text */
}

/* Table Borders for Definition */
table.dataTable {
    border-collapse: collapse; /* Collapse borders */
    border-spacing: 0; /* Remove spacing */
    border: 1px solid #777777; /* Outer border for the table */
}

table.dataTable tbody td, table.dataTable thead th {
    padding: 8px; /* Padding for table cells */
    border-bottom: 1px solid #777777; /* Border for table cells */
}

img {
    max-width: 100px; /* Limit image width */
    height: auto; /* Maintain aspect ratio */
}

.btn {
    margin-top: 5px; /* Margin for buttons */
    margin-right: 10px; /* Margin for right-side buttons */
}
/* Default styles */
.layout {
    display: flex;
    height: 100vh; /* Full viewport height */
    justify-content: center;
    margin-right: auto;
    margin-left: -240px;
    width: 600%;
}

.main-content {
    flex: 1; /* Takes remaining space */
    overflow-y: auto; /* Enable vertical scrolling */
    padding: 0; /* Remove padding */
    margin-left: 400px; /* Leave space for sidebar */
    background-color: #222; /* Main content background color */
    color: #fff; /* Main content text color */
}

.oror {
    width: 30%;
    margin: 10px;
    margin-left: 270px;
}

/* Media Queries for responsiveness */

/* For small screens, adjust layout */
@media (max-width: 768px) {
    .layout {
        flex-direction: column; /* Stack elements vertically */
        width: 100%;
        margin-left: 0;
        margin-right: 0;
    }

    .main-content {
        margin-left: 0; /* Remove sidebar space */
        margin-top: 20px; /* Add some spacing above */
    }

    .oror {
        width: 80%; /* Make the oror section larger on small screens */
        margin-left: 10px;
    }
}

/* For medium screens (tablets) */
@media (max-width: 1024px) {
    .layout {
        width: 100%;
        margin-left: 0;
        margin-right: 0;
    }

    .main-content {
        margin-left: 0; /* Remove sidebar space */
    }

    .oror {
        width: 40%; /* Adjust size for medium screens */
        margin-left: 10px;
    }
}

/* For large screens */
@media (min-width: 1025px) {
    .layout {
        width: 600%;
        margin-left: -240px;
    }

    .main-content {
        margin-left: 400px; /* Leave space for sidebar */
    }

    .oror {
        width: 30%;
        margin-left: 270px;
    }
}

</style>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/admin.css?v=1.0">
</head>
<body>
<div class="grid-container">>
<header class="header">
        <div class="menu-icon" onclick="openSidebar()">
            <span class="material-icons-outlined">menu</span>
        </div>
        <div class="header-left">
            <span class="material-icons-outlined"></span>
        </div>
        <div class="header-right">
        	
            <span class="header-admin-name">${adminName}</span>
            <div class="profile-photo">
                 <img src="${pageContext.request.contextPath}/resources/static/images/admin1.jfif" alt="Profile Photo">
            </div>
            <a href="adminLogOut" class="logout-button" onclick="return confirm('Are you sure you want to log out?');">Log Out</a>

        </div>
    </header>
 
  <jsp:include page="/WEB-INF/views/common/header.jsp" />


<div class="container">


    <h1>Orders</h1>

    <h2>Pending Orders</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Order Number</th>
                <th>User Name</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone</th>
                
                <th>Payment Type</th>
                <th>Order Date</th>
                <th>Amount</th>
                <th>Order Note</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${groupedOrders['Pending']}">
                <tr>
                    <td>${order.orderNumber}</td>
                    <td>${order.userName}</td>
                    <td>${order.userAddress}</td>
                    <td>${order.userEmail}</td>
                    <td>${order.phNo}</td>
                    
                    <td>${order.paymentMethodName}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.amount}</td>
                    <td>
                        ${order.orderNote}
                    </td>
                   <td>
    <form action="${pageContext.request.contextPath}/approve/${order.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to approve this order?');">
        <button type="submit" class="btn btn-success btn-sm">
            <i class="bi bi-check-circle"></i> 
        </button>
    </form>
    <form action="${pageContext.request.contextPath}/cancel/${order.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to cancel this order?');">
        <button type="submit" class="btn btn-danger btn-sm">
            <i class="bi bi-x-circle"></i>
        </button>
    </form>
  <button type="button" class="btn btn-warning btn-sm"
                            onclick="populateEditOrderModal(${order.orderId}, '${order.userAddress}');"
                            data-toggle="modal" data-target="#editOrderModal"><i class="bi bi-pencil"></i> 
                       
                    </button>
                    
                    



<!-- Assuming this is in a loop to list all orders -->
    <button type="button" class="btn btn-info viewOrderDetailsBtn btn-sm" data-order-id="${order.id}">  <i class="bi bi-eye"></i> </button>







    
</td>


                </tr>
            </c:forEach>
        </tbody>
    </table>

    <h2>Approved Orders</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Order Number</th>
                <th>User Name</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone</th>
                
                <th>Payment Type</th>
                <th>Approved Date</th>
                <th>Amount</th>
                <th>Order Note</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${groupedOrders['Approved']}">
                <tr>
                    <td>${order.orderNumber}</td>
                    <td>${order.userName}</td>
                    <td>${order.userAddress}</td>
                    <td>${order.userEmail}</td>
                    <td>${order.phNo}</td>
                    
                    <td>${order.paymentMethodName}</td>
                   <td>${order.paymentdate}</td>
                    <td>${order.amount}</td>
                    <td>
                        ${order.orderNote}
                    </td>
                    <td>
                    <button type="button" class="btn btn-info viewOrderDetailsBtn btn-sm" data-order-id="${order.id}">  <i class="bi bi-eye"></i> </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <h2>Canceled Orders</h2>
    <table class="table table-striped">
        <thead>
            <tr>
            	
                <th>Order Number</th>
                <th>User Name</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone</th>
               
                <th>Payment Type</th>
                <th>Order Date</th>
                <th>Amount</th>
                <th>Order Note</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${groupedOrders['Canceled']}">
                <tr>
                    <td>${order.orderNumber}</td>
                    <td>${order.userName}</td>
                    <td>${order.userAddress}</td>
                    <td>${order.userEmail}</td>
                    <td>${order.phNo}</td>
                    
                    <td>${order.paymentMethodName}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.amount}</td>
                    <td>
                       ${order.orderNote}
                    </td>
                    <td>
                    	<form action="${pageContext.request.contextPath}/approve/${order.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to approve this order again?');">
        <button type="submit" class="btn btn-success btn-sm">
            <i class="bi bi-check-circle"></i> 
        </button>
    </form>
    <button type="button" class="btn btn-info viewOrderDetailsBtn btn-sm" data-order-id="${order.id}">  <i class="bi bi-eye"></i> </button>
    
    
    
                    	<a href="${pageContext.request.contextPath}/deletingOrder/${order.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this canceled order?');">
    <i class="bi bi-trash"></i>
</a>
    
                    </td>
                    
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    
   <div class="modal fade" id="editOrderModal" tabindex="-1" aria-labelledby="editOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editOrderModalLabel">Edit Order Address</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editOrderForm" action="" method="post">
                    <div class="form-group">
                        <label for="userAddress">Address:</label>
                        <input type="text" id="userAddress" name="userAddress" class="form-control" required />
                        <input type="hidden" name="order.orderId" id="order.orderId" />
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Update Address</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="orderDetailsModal" tabindex="-1" aria-labelledby="orderDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderDetailsModalLabel">Order Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Transaction Image -->
                <div id="orderTransactionImage" class="text-center mb-4">
                    <!-- Transaction Image will be inserted here -->
                </div>
                
                <!-- Order Items Table -->
                <div class="table-container">
                    <table id="orderItemsTable" class="table table-bordered">
                        <thead>
                            <tr>
                             <th>#</th>
                                <th>Product</th>
                                <th>Pack</th>
                                <th>Count</th>
                                <th>Price</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Order Items will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>





    
    
    
</div>

 

</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
                
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<!-- DataTables JS -->

<!-- DataTables CSS -->

<script>

$(document).ready(function() {
    $('#pendingTable').DataTable({
        pageLength: 5, // Set the number of rows per page
        "order": [[ 0, "desc" ]] // Sort by the first column in descending order
    });
});
$(document).ready(function() {
    $('#approvedTable').DataTable({
        pageLength: 5, // Set the number of rows per page
        "order": [[ 0, "desc" ]] // Sort by the first column in descending order
    });
});
$(document).ready(function() {
    $('#canceledTable').DataTable({
        pageLength: 5, // Set the number of rows per page
        "order": [[ 0, "desc" ]] // Sort by the first column in descending order
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
function populateEditOrderModal(orderId, userAddress) {
	console.log("HIHIHIHI");
    document.getElementById('userAddress').value = userAddress;
    document.getElementById('order.orderId').value = orderId;
    document.getElementById('editOrderForm').action = '${pageContext.request.contextPath}/updateOrder/' + orderId; // Update this path based on your application context
}
$(document).ready(function() {
    $(".viewOrderDetailsBtn").click(function() {
        var orderId = $(this).data("order-id");

        $.ajax({
            url: "${pageContext.request.contextPath}/viewOrderDetails/" + orderId,
            method: "GET",
            success: function(response) {
                if (response.error) {
                    alert(response.error);
                    return;
                }

                var order = response.order;
                console.log("Order Details: ", order); 
                var orderItems = order.orderItems; 
                console.log("Order Items: ", orderItems);

                var transactionImageBase64 = order.userTransaction ? order.userTransaction : null;

               
                var userTransactionImage = transactionImageBase64 ?
                    "<img src='data:image/jpeg;base64," + transactionImageBase64 + "' alt='Transaction Image' class='img-fluid'>" :
                    "<p>No transaction image available.</p>";

                $("#orderTransactionImage").html(userTransactionImage);

                
                if (orderItems && orderItems.length > 0) {
                   let totalAmount=0;
                    var orderItemsHtml = "";
                    orderItems.forEach(function(item,index) {
                    	  totalAmount += item.totalPrice;  
                        orderItemsHtml += "<tr>" +
                        "<td>" + (index + 1) + "</td>" +
                        "<td>" + item.productName + "</td>" +
                        "<td>" + item.perQuantity+" "+ item.unit + "</td>" +
                        
                        "<td>" + item.orderQuantity + "</td>" +
                        "<td>" + item.price + "</td>" +
                        "<td>" + item.totalPrice + "</td>" +
                       
                       "</tr>";
                    });
                    orderItemsHtml += "<tr style='background-color: #ffcccb; font-weight: bold; border-top: 2px solid #000; cursor: pointer;' " +
                    "onmouseover='this.style.backgroundColor=\"#f08080\"' onmouseout='this.style.backgroundColor=\"#ffcccb\"'>" +  // Hover effect
                    "<td colspan='4' style='padding: 10px; color: #d32f2f;'>Total Amount:</td>" +
                    "<td style='padding: 10px; color: #d32f2f;'>" + totalAmount.toFixed(2) + "</td>" +
                    "</tr>";

                    $("#orderItemsTable tbody").html(orderItemsHtml);

                   
                    $("#orderItemsTable tbody").css("background-color", "#495057");
                } else {
                    
                    $("#orderItemsTable tbody").html("<tr><td colspan='5' class='text-center'>No order items available.</td></tr>");
                    $("#orderItemsTable tbody").css("background-color", "#495057");
                }

               
                $("#orderDetailsModal").modal("show");
            },
            error: function(xhr, status, error) {
                console.error("Error fetching order details: ", error);
            }
        });
    });
});
</script>

</body>
</html>
