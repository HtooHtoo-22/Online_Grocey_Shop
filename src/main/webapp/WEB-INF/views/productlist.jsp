<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="project.Model.CategoryBean"%>
<%@page import="project.Model.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="project.Repository.ProductRepo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style>
.product-image-container {
    overflow: hidden;
    padding: 10px;
    background-color: #ffffff; /* White background for a clean look */
    border-radius: 12px; /* Smooth corners for the entire product card */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* Very light shadow for depth */
    transition: box-shadow 0.3s ease; /* Smooth transition for hover shadow */
    height: 200px; /* Moderate height for the container */
    width: 250px; /* Moderate width for the container */
    display: flex; /* Enable flexbox for centering */
    align-items: center; /* Vertically center the image */
    justify-content: center; /* Horizontally center the image */
}

.product-img {
    max-width: 100%; /* Allow the image to scale down */
    max-height: 100%; /* Prevent the image from exceeding container height */
    border-radius: 10px; /* Soft rounded corners */
    transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth hover effects */
    object-fit: cover; /* Ensure the image fits nicely within the container */
    border: 1px solid rgba(0, 0, 0, 0.1); /* Subtle black border */
}

/* Hover effect with a slight zoom and shadow */
.product-img:hover {
    transform: scale(1.05); /* Slight zoom on hover for elegance */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Subtle shadow effect on hover */
}

/* Add a slightly stronger shadow when hovering over the whole product container */
.product-image-container:hover {
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15); /* Slightly stronger shadow on hover */
}

/* Center text and align buttons better */
.product-item {
    padding: 20px;
    text-align: center; /* Center-align all product text */
}
.button-container {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    margin-left: -10px; /* Adjust as needed */
}
.quantity-input {
    width: 40px; /* Adjust the width as needed */
    height: 30px; /* Set height for a more compact appearance */
    text-align: center; /* Center the number */
    font-size: 14px; /* Font size for the text */
    padding: 2px; /* Padding for a better touch target */
    border: 2px solid #ffc107; /* Light gray border */
    border-radius: 5px; /* Rounded corners */
    margin: 0; /* Remove default margin */
    box-shadow: none; /* Remove box shadow for a flat look */
    transition: border-color 0.3s; /* Smooth transition for border color */
}

/* Change border color on focus */
.quantity-input:focus {
    border-color: black	; /* Change border color when focused */
    outline: none; /* Remove outline */
}
.pagination {
    display: flex;
    justify-content: center; /* Center the pagination */
    align-items: center;     /* Align items vertically */
    margin: 20px 0;         /* Space above and below pagination */
}

.pagination a {
    text-decoration: none;   /* Remove underline from links */
    color: #007bff;         /* Link color */
    padding: 10px 15px;     /* Padding for links */
    border: 1px solid #007bff; /* Border for links */
    border-radius: 5px;     /* Rounded corners */
    margin: 0 5px;          /* Space between links */
    transition: background-color 0.3s, color 0.3s; /* Smooth transitions */
}

.pagination a:hover {
    background-color: yellow; /* Change background color to yellow on hover */
    color: #333;              /* Text color on hover */
}


.pagination span {
    margin: 0 15px;           /* Space around the page info text */
    font-weight: bold;         /* Bold font for the page info */
    color: #333;               /* Text color */
}

.pagination a:disabled {
    color: #ccc;              /* Disabled link color */
    border-color: #ccc;       /* Border color for disabled */
    cursor: not-allowed;      /* Change cursor for disabled */
}

</style>
<meta charset="ISO-8859-1">
<title>Product List</title>
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
<div class="toast" id="toast">Product added to cart!</div>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
      <defs>
       <symbol xmlns="http://www.w3.org/2000/svg" id="heart" viewBox="0 0 24 24"><path fill="currentColor" d="M20.16 4.61A6.27 6.27 0 0 0 12 4a6.27 6.27 0 0 0-8.16 9.48l7.45 7.45a1 1 0 0 0 1.42 0l7.45-7.45a6.27 6.27 0 0 0 0-8.87Zm-1.41 7.46L12 18.81l-6.75-6.74a4.28 4.28 0 0 1 3-7.3a4.25 4.25 0 0 1 3 1.25a1 1 0 0 0 1.42 0a4.27 4.27 0 0 1 6 6.05Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="plus" viewBox="0 0 24 24"><path fill="currentColor" d="M19 11h-6V5a1 1 0 0 0-2 0v6H5a1 1 0 0 0 0 2h6v6a1 1 0 0 0 2 0v-6h6a1 1 0 0 0 0-2Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="minus" viewBox="0 0 24 24"><path fill="currentColor" d="M19 11H5a1 1 0 0 0 0 2h14a1 1 0 0 0 0-2Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="cart" viewBox="0 0 24 24"><path fill="currentColor" d="M8.5 19a1.5 1.5 0 1 0 1.5 1.5A1.5 1.5 0 0 0 8.5 19ZM19 16H7a1 1 0 0 1 0-2h8.491a3.013 3.013 0 0 0 2.885-2.176l1.585-5.55A1 1 0 0 0 19 5H6.74a3.007 3.007 0 0 0-2.82-2H3a1 1 0 0 0 0 2h.921a1.005 1.005 0 0 1 .962.725l.155.545v.005l1.641 5.742A3 3 0 0 0 7 18h12a1 1 0 0 0 0-2Zm-1.326-9l-1.22 4.274a1.005 1.005 0 0 1-.963.726H8.754l-.255-.892L7.326 7ZM16.5 19a1.5 1.5 0 1 0 1.5 1.5a1.5 1.5 0 0 0-1.5-1.5Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="check" viewBox="0 0 24 24"><path fill="currentColor" d="M18.71 7.21a1 1 0 0 0-1.42 0l-7.45 7.46l-3.13-3.14A1 1 0 1 0 5.29 13l3.84 3.84a1 1 0 0 0 1.42 0l8.16-8.16a1 1 0 0 0 0-1.47Z"/></symbol>
        
      <symbol xmlns="http://www.w3.org/2000/svg" id="user" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="9" r="3"/><circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M17.97 20c-.16-2.892-1.045-5-5.97-5s-5.81 2.108-5.97 5"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="wishlist" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M21 16.09v-4.992c0-4.29 0-6.433-1.318-7.766C18.364 2 16.242 2 12 2C7.757 2 5.636 2 4.318 3.332C3 4.665 3 6.81 3 11.098v4.993c0 3.096 0 4.645.734 5.321c.35.323.792.526 1.263.58c.987.113 2.14-.907 4.445-2.946c1.02-.901 1.529-1.352 2.118-1.47c.29-.06.59-.06.88 0c.59.118 1.099.569 2.118 1.47c2.305 2.039 3.458 3.059 4.445 2.945c.47-.053.913-.256 1.263-.579c.734-.676.734-2.224.734-5.321Z"/><path stroke-linecap="round" d="M15 6H9"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="shopping-bag" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3.864 16.455c-.858-3.432-1.287-5.147-.386-6.301C4.378 9 6.148 9 9.685 9h4.63c3.538 0 5.306 0 6.207 1.154c.901 1.153.472 2.87-.386 6.301c-.546 2.183-.818 3.274-1.632 3.91c-.814.635-1.939.635-4.189.635h-4.63c-2.25 0-3.375 0-4.189-.635c-.814-.636-1.087-1.727-1.632-3.91Z"/><path d="m19.5 9.5l-.71-2.605c-.274-1.005-.411-1.507-.692-1.886A2.5 2.5 0 0 0 17 4.172C16.56 4 16.04 4 15 4M4.5 9.5l.71-2.605c.274-1.005.411-1.507.692-1.886A2.5 2.5 0 0 1 7 4.172C7.44 4 7.96 4 9 4"/><path d="M9 4a1 1 0 0 1 1-1h4a1 1 0 1 1 0 2h-4a1 1 0 0 1-1-1Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M8 13v4m8-4v4m-4-4v4"/></g></symbol>
		 <symbol xmlns="http://www.w3.org/2000/svg" id="star-full" viewBox="0 0 24 24"><path fill="currentColor" d="m3.1 11.3l3.6 3.3l-1 4.6c-.1.6.1 1.2.6 1.5c.2.2.5.3.8.3c.2 0 .4 0 .6-.1c0 0 .1 0 .1-.1l4.1-2.3l4.1 2.3s.1 0 .1.1c.5.2 1.1.2 1.5-.1c.5-.3.7-.9.6-1.5l-1-4.6c.4-.3 1-.9 1.6-1.5l1.9-1.7l.1-.1c.4-.4.5-1 .3-1.5s-.6-.9-1.2-1h-.1l-4.7-.5l-1.9-4.3s0-.1-.1-.1c-.1-.7-.6-1-1.1-1c-.5 0-1 .3-1.3.8c0 0 0 .1-.1.1L8.7 8.2L4 8.7h-.1c-.5.1-1 .5-1.2 1c-.1.6 0 1.2.4 1.6"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="star-half" viewBox="0 0 24 24"><path fill="currentColor" d="m3.1 11.3l3.6 3.3l-1 4.6c-.1.6.1 1.2.6 1.5c.2.2.5.3.8.3c.2 0 .4 0 .6-.1c0 0 .1 0 .1-.1l4.1-2.3l4.1 2.3s.1 0 .1.1c.5.2 1.1.2 1.5-.1c.5-.3.7-.9.6-1.5l-1-4.6c.4-.3 1-.9 1.6-1.5l1.9-1.7l.1-.1c.4-.4.5-1 .3-1.5s-.6-.9-1.2-1h-.1l-4.7-.5l-1.9-4.3s0-.1-.1-.1c-.1-.7-.6-1-1.1-1c-.5 0-1 .3-1.3.8c0 0 0 .1-.1.1L8.7 8.2L4 8.7h-.1c-.5.1-1 .5-1.2 1c-.1.6 0 1.2.4 1.6m8.9 5V5.8l1.7 3.8c.1.3.5.5.8.6l4.2.5l-3.1 2.8c-.3.2-.4.6-.3 1c0 .2.5 2.2.8 4.1l-3.6-2.1c-.2-.2-.3-.2-.5-.2"/></symbol>
		
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
    
    <div class="container-lg">
   <div class="containser">
            <div class="row g-4"> <!-- Use g-4 for consistent spacing -->
    <h1 style="color:green;">Product List</h1>
    <c:forEach items="${categories}" var="Cat">
        <div id="${Cat.name}" class="category-section">
            <div class="category-container d-flex align-items-center">
    <img src="data:image/jpeg;base64,${Cat.getBase64()}" class="category-img mb-2" alt="${Cat.name}"/>
    <h4 class="mb-0" style="font-size: 1.5rem; color: green; margin-left: 15px;">${Cat.name}</h4>

</div>
                    
                    <div class="product-container">
                    <div class="row">
      <div class="col-md-12">

        <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
                        <c:forEach items="${productsByCategory[Cat.id]}" var="Product">
                        <div class="col">
                            <div class="product">
                            <div class="product-item">
                            <figure class="product-image-container">
                                 <a href="javascript:void(0)" class="nav-link swiper-slide text-center" title="${Product.productName}" onclick="showModal('${Product.id}', '${Product.productName}', '${Product.description}', 'data:image/jpeg;base64,${Product.getBase64()}', ${Product.price}, ${Product.per_quantity}, '${Product.unit}', '${Product.categoryName}', '${Product.quantity}','${Product.productId}','${Product.productUnit}')">
                                    <img src="data:image/jpeg;base64,${Product.getBase64()}" class="tab-image product-img" alt="${Product.productName}"/>
                                </a>
                                </figure>
                                 <div class="d-flex flex-column text-center">
                    <h3 class="fs-6 fw-normal">${Product.productName}</h3>
                    <div>
                     
                      <!-- Replace with dynamic review count if available -->
                    </div>
                    <div class="d-flex justify-content-center align-items-center gap-2">
                    <div class="text-dark fw-semibold">${Product.per_quantity} ${Product.unit} /</div>
                      <span class="text-dark fw-semibold">${Product.price} KS</span>
                    </div>
                     <div class="button-area p-3 pt-0">
                      <div class="row g-1 mt-2">
                       
              
                    <div class="col-12 d-flex justify-content-start align-items-center"> <!-- Use full width and flex to align -->
  
   <div class="button-container" style="display: flex; align-items: center; justify-content: flex-start;">

    <!-- Quantity Input -->
    <input type="number" 
    id="quantity-${Product.id}" 
    class="quantity-input" 
    value="1" 
    min="1" 
    style="width: 40px; text-align: center; margin: 0; font-size: 14px; padding: 2px;">

    <!-- Add to Cart Button -->
    <button 
        type="button" 
        class="btn rounded-1 btn-cart" 
        
        style="width: 150px; background-color: #ffc107; color: black; padding: 10px; margin: 0 3px;"
        
       onclick="addToCartWithQuantity('${Product.id}', '${Product.productName}', ${Product.price}, '${Product.getBase64()}', '${Product.quantity}', '${Product.per_quantity}', '${Product.unit}', '${Product.productUnit}')">
        <svg width="16" height="16"><use xlink:href="#cart"></use></svg> Add to Cart
    </button>

    <!-- Favorite Button -->
    <button 
        type="button" 
        class="btn btn-outline-dark rounded-1 favorite-button" 
        style="width: 35px; padding: 4px; margin-left: 0;"
        data-product-id="${Product.productId}" 
        onclick="toggleFavorite(this)"> 
        <svg width="16" height="16" class="heart-icon">
            <use xlink:href="#heart-outline"></use>
        </svg>
    </button>

</div>

    <svg style="display: none;">
        <symbol id="heart-outline" viewBox="0 0 24 24">
            <path fill="currentColor" d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
        </symbol>
        <symbol id="heart-filled" viewBox="0 0 24 24">
            <path fill="currentColor" d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
        </symbol>
    </svg>
</div>



                      </div>
                      </div>
                    </div>
                                
                            </div>
                            </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            </div>
            </div>
        
    </c:forEach>
    <div class="pagination">
    <c:if test="${hasPrevious}">
        <a href="?pageNumber=${pageNumber - 1}#${Cat.name}" style="text-decoration: none;">Previous</a>
    </c:if>
    <span>Page ${pageNumber} of ${totalPages}</span>
    <c:if test="${hasNext}">
        <a href="?pageNumber=${pageNumber + 1}#${Cat.name}" style="text-decoration: none;">Next</a>
    </c:if>
</div>

</div>
</div>
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        
        <div class="modal-container">
            <!-- Left side (Image Section) -->
            <div class="modal-left">
                <img id="modalProductImage" src="" alt="Product Image" class="modal-product-image">
            </div>
            
            <!-- Right side (Product Info Section) -->
            <div class="modal-right">
                <h2 id="modalProductName"></h2>
                <p><strong>Category:</strong> <span id="modalProductCategoryName"></span></p>
                <p><strong>Price:</strong> <span id="modalProductPrice"></span> KS</p>
                <p><strong>Quantity:</strong> <span id="modalProductQuantity"></span> <span id="modalProductUnit"></span></p>
                <p><strong>Description:</strong> <span id="modalProductDescription"></span></p>

                <div class="button-container">
                    <input type="number" id="modalQuantity" value="0" min="1" style="width: 60px; text-align: center; margin-right: 10px;">
                    <button id="modalAddToCartButton" type="button" class="btn rounded-1 p-2 fs-7 btn-cart" style="width: 130px; background-color: #ffc107; color: black;">
                        <svg width="16" height="16"><use xlink:href="#cart"></use></svg> Add to Cart
                    </button>
                     
                    <button id="modalFavoriteButton" type="button" class="btn btn-outline-dark rounded-1 p-2 fs-6 favorite-button ms-2" data-product-id="" onclick="toggleFavorite(this)">
                        <svg width="16" height="16" class="heart-icon">
                            <use xlink:href="#heart-outline"></use>
                        </svg>
                    </button>
                </div>
            </div>
        </div>	
    </div>
</div>
</div>

    
    
    
    
    
    
    
    
    
    
    



<script src="${pageContext.request.contextPath}/resources/static/js/jquery-1.11.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/plugins.js"></script>
    

   
   <script src="${pageContext.request.contextPath}/resources/static/js/customize.js?v=<%= System.currentTimeMillis() %>"></script>


<script>


function showModal(productId, productName, productDescription, productImage, productPrice, productPerQuantity, productUnit, productCategoryName, productQuantity, realProductId, realProductUnit) {
    document.getElementById('modalProductName').textContent = productName;
    document.getElementById('modalProductDescription').textContent = productDescription;
    document.getElementById('modalProductCategoryName').textContent = productCategoryName;
    document.getElementById('modalProductImage').src = productImage;
    document.getElementById('modalProductPrice').textContent = productPrice;
    document.getElementById('modalProductQuantity').textContent = productPerQuantity;
    document.getElementById('modalProductUnit').textContent = productUnit;

    // Set the data-product-id for the favorite button
    let favoriteButton = document.getElementById('modalFavoriteButton');
    favoriteButton.setAttribute('data-product-id', realProductId);
    
    // Set onclick for adding the product to the cart
    const addToCartButton = document.getElementById('modalAddToCartButton');
    addToCartButton.onclick = function() {
        // Retrieve the current quantity value from the input field in the modal
        const quantityInput = document.getElementById('modalQuantity');
    const selectedQuantity = parseInt(quantityInput.value, 10) || 1; // Default to 1 if invalid

        // Pass the correct quantity to addToCartWithQuantity
        addToCartWithQuantity(productId, productName, productPrice, productImage, productQuantity, productPerQuantity, productUnit, realProductUnit);
    };

    // Display the modal
    document.getElementById('myModal').style.display = "block";
}

    </script>
</body>
</html>