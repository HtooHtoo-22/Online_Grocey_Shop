<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Category List</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.	delivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/vendor.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/hehe.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
	
</head>
<body>
 <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
<defs>
 		<symbol xmlns="http://www.w3.org/2000/svg" id="user" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="9" r="3"/><circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M17.97 20c-.16-2.892-1.045-5-5.97-5s-5.81 2.108-5.97 5"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="wishlist" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M21 16.09v-4.992c0-4.29 0-6.433-1.318-7.766C18.364 2 16.242 2 12 2C7.757 2 5.636 2 4.318 3.332C3 4.665 3 6.81 3 11.098v4.993c0 3.096 0 4.645.734 5.321c.35.323.792.526 1.263.58c.987.113 2.14-.907 4.445-2.946c1.02-.901 1.529-1.352 2.118-1.47c.29-.06.59-.06.88 0c.59.118 1.099.569 2.118 1.47c2.305 2.039 3.458 3.059 4.445 2.945c.47-.053.913-.256 1.263-.579c.734-.676.734-2.224.734-5.321Z"/><path stroke-linecap="round" d="M15 6H9"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="shopping-bag" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3.864 16.455c-.858-3.432-1.287-5.147-.386-6.301C4.378 9 6.148 9 9.685 9h4.63c3.538 0 5.306 0 6.207 1.154c.901 1.153.472 2.87-.386 6.301c-.546 2.183-.818 3.274-1.632 3.91c-.814.635-1.939.635-4.189.635h-4.63c-2.25 0-3.375 0-4.189-.635c-.814-.636-1.087-1.727-1.632-3.91Z"/><path d="m19.5 9.5l-.71-2.605c-.274-1.005-.411-1.507-.692-1.886A2.5 2.5 0 0 0 17 4.172C16.56 4 16.04 4 15 4M4.5 9.5l.71-2.605c.274-1.005.411-1.507.692-1.886A2.5 2.5 0 0 1 7 4.172C7.44 4 7.96 4 9 4"/><path d="M9 4a1 1 0 0 1 1-1h4a1 1 0 1 1 0 2h-4a1 1 0 0 1-1-1Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M8 13v4m8-4v4m-4-4v4"/></g></symbol>

</defs>
</svg>
 <header>
      <div class="container-fluid" >
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
    <section class="py-5 overflow-hidden">
    <div class="container-lg">
        <div class="row">
            <div class="col-md-12">
                <div class="section-header d-flex flex-wrap justify-content-between mb-5">
                    <h2 class="section-title">Category List</h2>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row g-4"> <!-- Use g-4 for consistent spacing -->
              <c:forEach var="entry" items="${categoryPages}">
    <c:set var="category" value="${entry.key}" />
    <c:set var="pageNumber" value="${entry.value}" />
    
    <div class="col-6 col-md-4 col-lg-2 text-center">
        <a href="productlist?pageNumber=${pageNumber}#${category.name}" class="nav-link d-flex flex-column align-items-center">
            <img src="data:image/jpeg;base64,${category.getBase64()}" class="category-img mb-2" alt="${category.name}">
            <h5 class="mb-0">${category.name}</h5>
        </a>
    </div>
</c:forEach>
            </div>
        </div>
    </div>
</section>
<script src="script.js?v=2.0"></script>
 <script src="${pageContext.request.contextPath}/resources/static/js/jquery-1.11.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/customize.js"></script>
</body>
</html>