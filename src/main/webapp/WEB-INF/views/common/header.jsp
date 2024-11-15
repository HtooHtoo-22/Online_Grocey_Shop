<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <style>
       body{
    margin: 0;
    padding: 0;
    background-color: #1d2634;
    color: #9e9ea4;
    font-family: 'Montserrat', sans-serif;
}

.material-icons-outlined{
    vertical-align: middle;
    line-height: 1px;
    font-size: 35px;
}

.grid-container{
    display: grid;
    grid-template-columns: 260px 1fr 1fr 1fr;
    grid-template-rows: 0.2fr 3fr;
    grid-template-areas: 
        "sidebar header header header"
        "sidebar main main main";
        height: 100vh;
}



.profile-photo {
    width: 40px; /* Set desired width */
    height: 40px; /* Set desired height */
    border-radius: 50%; /* Keep it circular */
    overflow: hidden; /* Ensure image does not overflow */
}

.profile-photo img {
    width: 100%; /* Image takes full width of the container */
    height: auto; /* Maintain aspect ratio */
    display: block; /* Ensures no extra space below the image */
}


.menu-icon {
    display: none;
}

/*--------------SIDEBAR---------------*/

#sidebar{
    grid-area: sidebar;
    height: 100%;
    background-color: #263043;
    overflow-y: auto;
    transition: all 0.5s;
    -webkit-transition: all 0.5s;
    
}
.sidebar-title{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30px 30px 30px 30px;
    margin-bottom: 30px;
}
.sidebar-title > span{
    display: none;

}

.sidebar-brand {
    display: flex;
    align-items: center;
    gap: 0.8rem;
    font-size: 20px;
    font-weight: 700;
}
.sidebar-list{
    padding: 0;
    margin-top: 15px;
    list-style-type: none;
}
.sidebar-list-item{
    padding: 20px 20px 20px 20px;
    font-size: 18px;
}
.sidebar-list-item:hover {
    background-color: #1e2a38; /* Adjust to your preferred color */
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2); /* Optional */
    color: #ffffff; /* Adjust for better contrast */
}

.sidebar-responsive{
    display: inline !important;
    position: absolute;
    z-index: 12 !important;
}

.sidebar-list-item a {
    display: flex;  /* Make it a flex container */
    align-items: center;  /* Center items vertically */
    padding: 20px;  /* Ensure padding */
    color: inherit;  /* Inherit text color from parent */
    text-decoration: none;  /* Remove underline */
    width: 100%;  /* Make sure it takes the full width */
}

.sidebar-list-item a:hover {
    background-color: unset; /* Avoid hover on <a> if it's already on list item */
    box-shadow: none;
}


.main-container{
    grid-area: main;
   overflow-y: auto;
   padding: 20px 20px;
   color: rgba(255, 255, 255, 0.95);
}

@media screen  and (max-width: 992px){
    .grid-container{
        grid-template-columns: 1fr;
        grid-template-rows: 0.2fr 3fr;
        grid-template-areas: 
                "header"
                "main";
    }
    #sidebar {
        display: none;
    }
    .menu-icon {
        display: inline;
    }
    .sidebar-title > span {
        display: inline;
    }
}
/*---------SMALL <= 768PX------------*/
@media screen  and (max-width: 768px){
    .main-cards{
        grid-template-columns: 1fr;
        gap: 10px;
        margin-bottom: 0;
    }

    .charts{
        grid-template-columns: 1fr;
        margin-top: 30px;
    }
}

/*--------- EXTRA SMALL <= 576PX------------*/
@media screen  and (max-width: 576px){

    .header-left {
        display: none;
    }
}
.header {
    grid-area: header;
    height: 70px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 30px;
    box-shadow: 0 6px 7px -3px rgba(0, 0, 0, 0.35);
}

.header-admin-name {
    color: #f5f7ff; /* Adjust color as needed */
    font-size: 20px; /* Adjust font size as needed */
    margin-right: 10px; /* Space between name and profile icon */
}

.header-right {
    display: flex; /* Ensure it's flex to align items properly */
    align-items: center; /* Center items vertically */
    gap: 1rem; /* Space between items */
    text-align: right;
}

.profile-photo {
    width: 40px; /* Set desired width */
    height: 40px; /* Set desired height */
    border-radius: 50%; /* Keep it circular */
    overflow: hidden; /* Ensure image does not overflow */
}

.profile-photo img {
    width: 100%; /* Image takes full width of the container */
    height: auto; /* Maintain aspect ratio */
    display: block; /* Ensures no extra space below the image */
}
.logout-button {
    background-color: red; /* Black background */
    color: white; /* White text color for contrast */
    padding: 10px 15px; /* Add padding for a button-like appearance */
    text-decoration: none; /* Remove underline */
    border-radius: 5px; /* Rounded corners */
}

.logout-button:hover {
    background-color: red; /* Dark gray background on hover */
}
.grid-container{
    display: grid;
    grid-template-columns: 260px 1fr 1fr 1fr;
    grid-template-rows: 0.2fr 3fr;
    grid-template-areas: 
        "sidebar header header header"
        "sidebar main main main";
        height: 100vh;
}

    </style>
</head>
<body>


<aside id="sidebar">
    <div class="sidebar-title">
        <div class="sidebar-brand">
            <div class="profile-photo">
                <img src="${pageContext.request.contextPath}/resources/static/images/admin1.jfif" alt="Profile Photo">
            </div>
            <span class="store-text">STORE</span>
        </div>
        <span class="material-icons-outlined" onclick="closeSidebar()">close</span>
    </div>
    <ul class="sidebar-list">
        <li class="sidebar-list-item"><a href="<c:url value='/admin' />"><span class="material-icons-outlined">dashboard</span>Dashboard</a></li>
        <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/adminProductList"><span class="material-icons-outlined">inventory_2</span>Products</a></li>
        <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/categoryList"><span class="material-icons-outlined">category</span>Categories</a></li>
        <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/users"><span class="material-icons-outlined">groups</span>Customers</a></li>
        <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/allorder"><span class="material-icons-outlined">fact_check</span>Orders</a></li>
        <c:if test="${admin == 'sa'}">
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/admins"><span class="material-icons-outlined">manage_accounts</span>Admin</a></li>
        </c:if>
        <li class="sidebar-list-item">
            <a href="${pageContext.request.contextPath}/paymentMethodList">
                <span class="material-icons-outlined">credit_card</span> Payment Methods
            </a>
        </li>
    </ul>
</aside>

</body>
</html>

