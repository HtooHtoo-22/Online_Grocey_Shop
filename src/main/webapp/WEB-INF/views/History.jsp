<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order History</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.	delivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/vendor.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/hehe.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
</head>
<body>
<div class="toast" id="toast">Product added to cart!</div>
    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
      <defs>
        
        
        <symbol xmlns="http://www.w3.org/2000/svg" id="heart" viewBox="0 0 24 24"><path fill="currentColor" d="M20.16 4.61A6.27 6.27 0 0 0 12 4a6.27 6.27 0 0 0-8.16 9.48l7.45 7.45a1 1 0 0 0 1.42 0l7.45-7.45a6.27 6.27 0 0 0 0-8.87Zm-1.41 7.46L12 18.81l-6.75-6.74a4.28 4.28 0 0 1 3-7.3a4.25 4.25 0 0 1 3 1.25a1 1 0 0 0 1.42 0a4.27 4.27 0 0 1 6 6.05Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="plus" viewBox="0 0 24 24"><path fill="currentColor" d="M19 11h-6V5a1 1 0 0 0-2 0v6H5a1 1 0 0 0 0 2h6v6a1 1 0 0 0 2 0v-6h6a1 1 0 0 0 0-2Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="minus" viewBox="0 0 24 24"><path fill="currentColor" d="M19 11H5a1 1 0 0 0 0 2h14a1 1 0 0 0 0-2Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="cart" viewBox="0 0 24 24"><path fill="currentColor" d="M8.5 19a1.5 1.5 0 1 0 1.5 1.5A1.5 1.5 0 0 0 8.5 19ZM19 16H7a1 1 0 0 1 0-2h8.491a3.013 3.013 0 0 0 2.885-2.176l1.585-5.55A1 1 0 0 0 19 5H6.74a3.007 3.007 0 0 0-2.82-2H3a1 1 0 0 0 0 2h.921a1.005 1.005 0 0 1 .962.725l.155.545v.005l1.641 5.742A3 3 0 0 0 7 18h12a1 1 0 0 0 0-2Zm-1.326-9l-1.22 4.274a1.005 1.005 0 0 1-.963.726H8.754l-.255-.892L7.326 7ZM16.5 19a1.5 1.5 0 1 0 1.5 1.5a1.5 1.5 0 0 0-1.5-1.5Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="check" viewBox="0 0 24 24"><path fill="currentColor" d="M18.71 7.21a1 1 0 0 0-1.42 0l-7.45 7.46l-3.13-3.14A1 1 0 1 0 5.29 13l3.84 3.84a1 1 0 0 0 1.42 0l8.16-8.16a1 1 0 0 0 0-1.47Z"/></symbol>
        
        <symbol xmlns="http://www.w3.org/2000/svg" id="package" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m24 13.264l7.288 4.21L24 21.681l-7.288-4.209Z"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M16.712 17.473v8.418L24 30.101l7.288-4.21v-8.418M24 30.1v-8.418"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M40.905 21.405a16.905 16.905 0 1 0-23.389 15.611L24 43.5l6.484-6.484a16.906 16.906 0 0 0 10.42-15.611"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="secure" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M14.134 36V20.11h19.732M19.279 36h14.587V25.45"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m19.246 26.606l4.135 4.135l5.373-5.372m-8.934-9.282a4.087 4.087 0 1 1 8.174 0m0 0v4.023m-8.172-4.108v4.108"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M30.288 44.566a21.516 21.516 0 1 1 9.69-6.18"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="quality" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m30.59 13.45l4.77 2.94L24 34.68l-10.33-7l3.11-4.6l5.52 3.71l8.26-13.38Z"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M24 4.5s-11.26 2-15.25 2v20a11.16 11.16 0 0 0 .8 4.1a15 15 0 0 0 2 3.61a22 22 0 0 0 2.81 3.07a34.47 34.47 0 0 0 3 2.48a34 34 0 0 0 2.89 1.86c1 .59 1.71 1 2.13 1.19l1 .49a1.44 1.44 0 0 0 1.24 0l1-.49c.42-.2 1.13-.6 2.13-1.19a34 34 0 0 0 2.89-1.86a34.47 34.47 0 0 0 3-2.48a22 22 0 0 0 2.81-3.07a15 15 0 0 0 2-3.61a11.16 11.16 0 0 0 .8-4.1v-20c-3.99.03-15.25-2-15.25-2"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="savings" viewBox="0 0 48 48"><circle cx="24" cy="24" r="21.5" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M12.5 23.684a3.298 3.298 0 0 1 5.63-2.332l3.212 3.212h0l8.53-8.53a3.298 3.298 0 0 1 5.628 2.333h0c0 .875-.348 1.714-.966 2.333L22.983 32.25a2.321 2.321 0 0 1-3.283 0l-6.234-6.233a3.298 3.298 0 0 1-.966-2.333"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="offers" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m41.556 39.297l-22.022 3.11a1.097 1.097 0 0 1-1.245-.97l-2.352-22.311a1.097 1.097 0 0 1 1.08-1.213l24.238-.229a1.097 1.097 0 0 1 1.108 1.09l.137 19.429c.004.55-.4 1.017-.944 1.094M26.1 25.258v2.579m8.494-2.731v2.175"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M34.343 32.346c-1.437.828-1.926 1.198-2.774 1.988c-1.19-.457-2.284-1.228-3.797-1.456m-15.953 8.721l-3.49-1.6a1.12 1.12 0 0 1-.643-.863L5.511 23.593c-.056-.4.108-.8.43-1.046l3.15-2.406a1.257 1.257 0 0 1 2.014.874l1.966 19.69a.887.887 0 0 1-1.252.894m11.989-28.112c.214-.456.964-1.716 2.76-3.618c3.108-3.323 4.26-4.288 4.26-4.288s1.42.75 3.27 3.109c1.876 2.358 1.93 3.832 1.93 3.832s.67-.08-4.797 1.688c-3.055.991-4.368 1.152-4.931 1.152"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M26.97 17.828v-.054c0-.884-.241-1.715-.67-2.412c-.563-.91-1.447-1.608-2.492-1.876a3.58 3.58 0 0 0-1.072-.16c-.429 0-.858.053-1.233.214c-1.152.348-2.063 1.18-2.573 2.278a4.747 4.747 0 0 0-.428 1.956v.134"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M18.93 15.818c-.562-.107-1.5-.349-3.135-.884c-2.304-.75-3.43-1.528-3.43-1.528s-.456-1.393 1.045-3.296s2.653-2.52 2.653-2.52s.911.778 3.43 3.485c1.26 1.313 1.796 2.09 2.01 2.465h.027"/></symbol>
        
        <symbol xmlns="http://www.w3.org/2000/svg" id="delivery" viewBox="0 0 32 32"><path fill="currentColor" d="m29.92 16.61l-3-7A1 1 0 0 0 26 9h-3V7a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v17a1 1 0 0 0 1 1h2.14a4 4 0 0 0 7.72 0h6.28a4 4 0 0 0 7.72 0H29a1 1 0 0 0 1-1v-7a1 1 0 0 0-.08-.39M23 11h2.34l2.14 5H23ZM9 26a2 2 0 1 1 2-2a2 2 0 0 1-2 2m10.14-3h-6.28a4 4 0 0 0-7.72 0H4V8h17v12.56A4 4 0 0 0 19.14 23M23 26a2 2 0 1 1 2-2a2 2 0 0 1-2 2m5-3h-1.14A4 4 0 0 0 23 20v-2h5Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="organic" viewBox="0 0 24 24"><path fill="currentColor" d="M0 2.84c1.402 2.71 1.445 5.241 2.977 10.4c1.855 5.341 8.703 5.701 9.21 5.711c.46.726 1.513 1.704 3.926 2.21l.268-1.272c-2.082-.436-2.844-1.239-3.106-1.68l-.005.006c.087-.484 1.523-5.377-1.323-9.352C7.182 3.583 0 2.84 0 2.84m24 .84c-3.898.611-4.293-.92-11.473 3.093a11.879 11.879 0 0 1 2.625 10.05c3.723-1.486 5.166-3.976 5.606-6.466c0 0 1.27-4.716 3.242-6.677M12.527 6.773l-.002-.002v.004zM2.643 5.22s5.422 1.426 8.543 11.543c-2.945-.889-4.203-3.796-4.63-5.168h.006a15.863 15.863 0 0 0-3.92-6.375z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="fresh" viewBox="0 0 24 24"><g fill="none"><path d="M24 0v24H0V0zM12.594 23.258l-.012.002l-.071.035l-.02.004l-.014-.004l-.071-.036c-.01-.003-.019 0-.024.006l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427c-.002-.01-.009-.017-.016-.018m.264-.113l-.014.002l-.184.093l-.01.01l-.003.011l.018.43l.005.012l.008.008l.201.092c.012.004.023 0 .029-.008l.004-.014l-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014l-.034.614c0 .012.007.02.017.024l.015-.002l.201-.093l.01-.008l.003-.011l.018-.43l-.003-.012l-.01-.01z"/><path fill="currentColor" d="M20 9a1 1 0 0 1 1 1v1a8 8 0 0 1-8 8H9.414l.793.793a1 1 0 0 1-1.414 1.414l-2.496-2.496a.997.997 0 0 1-.287-.567L6 17.991a.996.996 0 0 1 .237-.638l.056-.06l2.5-2.5a1 1 0 0 1 1.414 1.414L9.414 17H13a6 6 0 0 0 6-6v-1a1 1 0 0 1 1-1m-4.793-6.207l2.5 2.5a1 1 0 0 1 0 1.414l-2.5 2.5a1 1 0 1 1-1.414-1.414L14.586 7H11a6 6 0 0 0-6 6v1a1 1 0 1 1-2 0v-1a8 8 0 0 1 8-8h3.586l-.793-.793a1 1 0 0 1 1.414-1.414"/></g></symbol>

        <symbol xmlns="http://www.w3.org/2000/svg" id="star-full" viewBox="0 0 24 24"><path fill="currentColor" d="m3.1 11.3l3.6 3.3l-1 4.6c-.1.6.1 1.2.6 1.5c.2.2.5.3.8.3c.2 0 .4 0 .6-.1c0 0 .1 0 .1-.1l4.1-2.3l4.1 2.3s.1 0 .1.1c.5.2 1.1.2 1.5-.1c.5-.3.7-.9.6-1.5l-1-4.6c.4-.3 1-.9 1.6-1.5l1.9-1.7l.1-.1c.4-.4.5-1 .3-1.5s-.6-.9-1.2-1h-.1l-4.7-.5l-1.9-4.3s0-.1-.1-.1c-.1-.7-.6-1-1.1-1c-.5 0-1 .3-1.3.8c0 0 0 .1-.1.1L8.7 8.2L4 8.7h-.1c-.5.1-1 .5-1.2 1c-.1.6 0 1.2.4 1.6"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="star-half" viewBox="0 0 24 24"><path fill="currentColor" d="m3.1 11.3l3.6 3.3l-1 4.6c-.1.6.1 1.2.6 1.5c.2.2.5.3.8.3c.2 0 .4 0 .6-.1c0 0 .1 0 .1-.1l4.1-2.3l4.1 2.3s.1 0 .1.1c.5.2 1.1.2 1.5-.1c.5-.3.7-.9.6-1.5l-1-4.6c.4-.3 1-.9 1.6-1.5l1.9-1.7l.1-.1c.4-.4.5-1 .3-1.5s-.6-.9-1.2-1h-.1l-4.7-.5l-1.9-4.3s0-.1-.1-.1c-.1-.7-.6-1-1.1-1c-.5 0-1 .3-1.3.8c0 0 0 .1-.1.1L8.7 8.2L4 8.7h-.1c-.5.1-1 .5-1.2 1c-.1.6 0 1.2.4 1.6m8.9 5V5.8l1.7 3.8c.1.3.5.5.8.6l4.2.5l-3.1 2.8c-.3.2-.4.6-.3 1c0 .2.5 2.2.8 4.1l-3.6-2.1c-.2-.2-.3-.2-.5-.2"/></symbol>

        <symbol xmlns="http://www.w3.org/2000/svg" id="user" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="9" r="3"/><circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M17.97 20c-.16-2.892-1.045-5-5.97-5s-5.81 2.108-5.97 5"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="wishlist" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M21 16.09v-4.992c0-4.29 0-6.433-1.318-7.766C18.364 2 16.242 2 12 2C7.757 2 5.636 2 4.318 3.332C3 4.665 3 6.81 3 11.098v4.993c0 3.096 0 4.645.734 5.321c.35.323.792.526 1.263.58c.987.113 2.14-.907 4.445-2.946c1.02-.901 1.529-1.352 2.118-1.47c.29-.06.59-.06.88 0c.59.118 1.099.569 2.118 1.47c2.305 2.039 3.458 3.059 4.445 2.945c.47-.053.913-.256 1.263-.579c.734-.676.734-2.224.734-5.321Z"/><path stroke-linecap="round" d="M15 6H9"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="shopping-bag" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3.864 16.455c-.858-3.432-1.287-5.147-.386-6.301C4.378 9 6.148 9 9.685 9h4.63c3.538 0 5.306 0 6.207 1.154c.901 1.153.472 2.87-.386 6.301c-.546 2.183-.818 3.274-1.632 3.91c-.814.635-1.939.635-4.189.635h-4.63c-2.25 0-3.375 0-4.189-.635c-.814-.636-1.087-1.727-1.632-3.91Z"/><path d="m19.5 9.5l-.71-2.605c-.274-1.005-.411-1.507-.692-1.886A2.5 2.5 0 0 0 17 4.172C16.56 4 16.04 4 15 4M4.5 9.5l.71-2.605c.274-1.005.411-1.507.692-1.886A2.5 2.5 0 0 1 7 4.172C7.44 4 7.96 4 9 4"/><path d="M9 4a1 1 0 0 1 1-1h4a1 1 0 1 1 0 2h-4a1 1 0 0 1-1-1Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M8 13v4m8-4v4m-4-4v4"/></g></symbol>

      </defs>
    </svg>
    
    <header>
      <div class="container-fluid">
    <div class="row py-3 border-bottom align-items-center">
      
        <div class="col-sm-4 col-lg-2 text-center text-sm-start">
            <div class="d-flex align-items-center justify-content-center justify-content-md-start">
                <img src="${pageContext.request.contextPath}/resources/static/images/logo8.jpg" alt="logo"  width="120px" height="90px">
            </div>
        </div>
        
        <div class="col-sm-6 col-lg-3"> <!-- Search bar column -->
            <div class="search-bar bg-light p-2 rounded-4">
                <form action="search" method="GET" class="d-flex">
                    <input type="text" name="search" class="form-control me-2" placeholder="Search products...." aria-label="Search">
                    <button type="submit" class="btn btn-outline-secondary">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                            <path fill="currentColor" d="M21.71 20.29L18 16.61A9 9 0 1 0 16.61 18l3.68 3.68a1 1 0 0 0 1.42 0a1 1 0 0 0 0-1.39ZM11 18a7 7 0 1 1 7-7a7 7 0 0 1-7 7Z"/>
                        </svg>
                    </button>
                </form>
            </div>
        </div>

        <div class="col-sm-12 col-lg-6"> <!-- Adjusted column size for nav items -->
            <ul class="navbar-nav list-unstyled d-flex flex-row gap-4 justify-content-center flex-wrap align-items-center mb-0 fw-bold text-uppercase text-dark">
                <li class="nav-item active">
                    <a href="myhome" class="nav-link">Home</a>
                </li>
                <li class="nav-item active">
                    <a href="category" class="nav-link">Category</a>
                </li>
                <li class="nav-item active">
                    <a href="productlist" class="nav-link">Product List</a>
                </li>
                <li class="nav-item active">
                    <a href="history" class="nav-link">History</a>
                </li>
                <li class="nav-item active">
                    <a href="favourite" class="nav-link">
                        <svg width="35" height="35"><use xlink:href="#wishlist"></use></svg>
                    </a>
                </li>
                <li class="nav-item active" style="margin-right: 0;"> <!-- No right margin for the last item -->
                    <a href="cart" class="nav-link">
                        <svg width="35" height="35"><use xlink:href="#shopping-bag"></use></svg>
                         <span class="badge bg-primary" id="totalCart">0</span>
                    </a>
                </li>
            </ul>
        </div>
        
        <div class="col-sm-2 col-lg-1 d-flex justify-content-end align-items-center" style="margin-left: -10px ;"> <!-- Flex container for the profile -->
            <a href="myprofile" class="nav-link">
                <img src="data:image/jpeg;base64,${userInfo.get64()}" class="profile-logo rounded-circle" alt="Profile Logo" style="width: 53px; height: 53px;border: 1.3px solid black;"/>
            </a>
        </div>
    </div>
</div>

    </header>
    <div class="container my-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white text-center">
            <h3>Order History</h3>
        </div>
        <div class="card-body p-4">
            <!-- Order History Table -->
            <table id="orderHistoryTable" class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Order Id</th>
                        <th scope="col">Order Date</th>
                        <th scope="col">Address</th>
                        <th scope="col">Order Notes</th>
                        <th scope="col">Details</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${history}">
                        <tr>
                            <td>${order.orderNumber}</td>
                            <td>${order.orderdate}</td>
                            <td>${order.orderAddress}</td>
                            <td>${order.orderNotes}</td>
                            <td>
                                <!-- Link to the new page for order details -->
                                <a href="orderDetails/${order.orderNumber}" class="btn btn-primary">View Detail</a>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="badge badge-danger" style="background-color: red;">Canceled</span>

                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="badge badge-warning text-dark">Pending</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="badge badge-success">Complete</span>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="card-footer text-muted text-center">
            <p>Thank you for shopping with us!</p>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/customize.js?v=<%= System.currentTimeMillis() %>"></script>
<!-- Initialize DataTable -->
<script>
    $(document).ready(function() {
        $('#orderHistoryTable').DataTable({
            "paging": true,
            "searching": true,
            "ordering": true,
            "lengthChange": true,
            "pageLength": 5,
            "order": [[ 1, "desc" ]],
            "lengthMenu": [5, 10, 20]
        });
    });
</script>
    
</body>
</html>