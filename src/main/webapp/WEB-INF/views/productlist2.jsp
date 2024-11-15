
<%@page import="project.Model.CategoryBean"%>
<%@page import="project.Model.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="project.Repository.ProductRepo"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Product Categories</title>
    <style>
        body { font-family: Arial; margin: 0; padding: 0; background-color: #fff7e5; }
        .navbar { background-color: #f7eb91; overflow: hidden; padding: 10px 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar a { float: left; display: block; padding: 14px; color: #333; text-decoration: none; margin: 0 5px; border-radius: 4px; transition: background-color 0.3s; }
        .navbar a:hover { background-color: #e6d27a; }
        .search-container { float: right; display: flex; align-items: center; }
        .search-container input, .search-container button { padding: 5px; margin-right: 5px; border-radius: 4px; }
        .search-container button { background-color: #f7eb91; border: none; cursor: pointer; }
        .cart-logo img, .profile-logo { width: 30px; height: auto; border-radius: 50%; object-fit: cover; }
        .content { padding: 20px; }
        .category-container { margin: 20px; border-bottom: 2px solid #e6d27a; padding-bottom: 20px; display: flex; align-items: flex-start; }
        .category-img { width: 200px; height: 200px; border-radius: 50%; object-fit: cover; margin-right: 20px; }
        .product-container { text-align: left; margin-top: 10px; }
        .product { margin: 10px 0; display: flex; align-items: center; }
        .product-img { width: 100px; height: 100px; object-fit: cover; margin-right: 10px; cursor: pointer; }
        .modal { display: none; position: fixed; z-index: 1001; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); }
        .modal-content { background-color: #fff; margin: 10% auto; padding: 20px; border-radius: 8px; width: 400px; text-align: center; }
        .modal-content img { max-width: 80%; max-height: 200px; border-radius: 8px; }
        .close { float: right; font-size: 28px; cursor: pointer; }
         .profile-logo {
            width: 40px; /* Adjust the size of the profile logo */
            height: 40px; /* Adjust the size of the profile logo */
            border-radius: 50%; /* Make it circular */
            object-fit: cover; /* Ensure the image covers the container */
        }
        .toast { 
        visibility: hidden; 
        min-width: 250px; 
        margin-left: -125px; 
        background: #f7eb91; /* Yellow background */
        color: #333; /* Dark text color for contrast */
        text-align: center; 
        border-radius: 5px; 
        padding: 16px; 
        position: fixed; 
        z-index: 1; 
        right: 30px; /* Positioning on the right */
        bottom: 30px; 
        font-size: 17px; 
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
    }
    .toast.show { 
        visibility: visible; 
        animation: fadein 0.5s, fadeout 0.5s 2.5s; 
    }
    .add-to-cart-button, .favorite-button {
    padding: 10px 15px; /* Padding for the buttons */
    margin-top: 5px; /* Space between buttons and product info */
    border: none; /* Remove default border */
    border-radius: 5px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s, transform 0.2s; /* Smooth transition for background color */
}

.add-to-cart-button {
    background-color: #ffcc00; /* Yellow background for add to cart */
    color: #333; /* Dark text */
}

.favorite-button {
    background-color: #ff6666; /* Light red background for favorites */
    color: #fff; /* White text */
}

.add-to-cart-button:hover {
    background-color: #e6b800; /* Darker yellow on hover */
    transform: scale(1.05); /* Slight scale effect on hover */
}

.favorite-button:hover {
    background-color: #ff4d4d; /* Darker red on hover */
    transform: scale(1.05); /* Slight scale effect on hover */
}
    
        @keyframes fadein { from { bottom: 0; opacity: 0; } to { bottom: 30px; opacity: 1; } }
        @keyframes fadeout { from { bottom: 30px; opacity: 1; } to { bottom: 0; opacity: 0; } }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
    integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
 
</head>
<body>

<div class="toast" id="toast">Product added to cart!</div>
<div class="navbar">
    <a href="myprofile"><img src="data:image/jpeg;base64,${userInfo.get64()}" class="profile-logo"/></a>
    <a href="myhome">Home</a>
    <a href="productlist">Product List</a>
    <a href="history.jsp">History</a>
    <a href="favourite">Favorites</a>
    <a href="about.jsp">About</a>
    <a href="cart">
    <div name="cart">
    <i class="fa-solid fa-cart-shopping fs-3 me-2"></i>
    
    <span class="badge bg-primary" id="totalCart">0</span>
    </div>
    </a>
    <div class="search-container">
        <form action="search" method="GET">
            <input type="text" name="search" placeholder="Search...">
            <button type="submit">Search</button>
        </form>
    </div>
</div>

<div class="content">
    <h1>Product Categories</h1>
    <c:forEach items="${categories}" var="Cat">
        <div id="${Cat.name}" class="category-section">
            <div class="category-container">
                <img src="data:image/jpeg;base64,${Cat.getBase64()}" class="category-img" alt="${Cat.name}"/>
                <div>
                    <div>${Cat.name}</div>
                    <div class="product-container">
                        <c:forEach items="${productsByCategory[Cat.id]}" var="Product">
                            <div class="product">
                                <a href="#" onclick="showModal('${Product.id}', '${Product.productName}', '${Product.description}', '${Product.getBase64()}', ${Product.price}, ${Product.per_quantity}, '${Product.unit}' ,'${Product.quantity}','${Product.categoryName}')">
                                    <img src="data:image/jpeg;base64,${Product.getBase64()}" class="product-img" alt="${Product.productName}"/>
                                </a>
                                <div>
                                    <div>${Product.productName}</div>
                                    <div>${Product.price} KS</div>
                                    <div>${Product.per_quantity} ${Product.unit}</div>
                                    <button type="button" class="add-to-cart-button" onclick="addToCart('${Product.id}', '${Product.productName}', ${Product.price}, '${Product.getBase64()}','${Product.quantity}','${Product.per_quantity}')">Add to Cart</button>
                                    <button type="button" class="favorite-button" data-product-id="${Product.productId}" onclick="toggleFavorite(this)">Favorite</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>




<!-- Modal for product details -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2 id="modalProductName"></h2>
        <img id="modalProductImage" src="" alt="" class="modal-product-image">
        <p id="modalProductDescription"></p>
        <p><strong>Category Name:</strong> <span id="modalProductCategoryName"></span></p>
        <p><strong>Price:</strong> <span id="modalProductPrice"></span> KS</p>
        <p><strong>Quantity:</strong> <span id="modalProductQuantity"></span> <span id="modalProductUnit"></span></p>
        <button id="modalAddToCartButton" type="button" class="add-to-cart-button">Add to Cart</button>
        <button id="modalFavoriteButton" type="button" class="favorite-button" data-product-id="" onclick="toggleFavorite(this)">Favorite</button>
    </div>
</div>

<script>
function showModal(productId, productName, productDescription, productImage, productPrice, productPerQuantity, productUnit,productQuantity,productCategoryName) {
    document.getElementById('modalProductName').textContent = productName;
    document.getElementById('modalProductDescription').textContent = productDescription;

    // Set the image source for the modal
    let imageElement = document.getElementById('modalProductImage');
    imageElement.src ='data:image/jpeg;base64,'+ productImage;

    document.getElementById('modalProductPrice').textContent = productPrice;
    document.getElementById('modalProductQuantity').textContent = productPerQuantity;
    document.getElementById('modalProductUnit').textContent = productUnit;
    document.getElementById('modalProductCategoryName').textContent = productCategoryName;

    // Set the data-product-id for the favorite button
    let favoriteButton = document.getElementById('modalFavoriteButton');
    favoriteButton.setAttribute('data-product-id', productId);

    // Set onclick for adding the product to the cart
    document.getElementById('modalAddToCartButton').onclick = function() {
        addToCart(productId, productName, productPrice, productImage,productQuantity,productPerQuantity);  // Pass the image to addToCart
    };

    // Display the modal
    document.getElementById('myModal').style.display = "block";
}

function closeModal() {
    document.getElementById('myModal').style.display = "none";
}
let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

function addToCart(productId, productName, productPrice, productImage, productQuantity, productPerQuantity) {
    console.log(productQuantity + " And " + productPerQuantity);
    const imageData = productImage.replace('data:image/jpeg;base64,', '');
    productPrice = parseFloat(productPrice);
    
    // Find the product in the cart
    let productInCart = cart.find(item => item.id === productId);

    if (productInCart) {
        console.log(productInCart.cartQuantity + " OR " + productInCart.quantity);
        
        // Ensure quantities are treated as numbers
        let perQ = parseFloat(productPerQuantity);
        let productQ = parseFloat(productQuantity);
        let cartQ = parseFloat(productInCart.cartQuantity);
        
        // Check if adding the new quantity exceeds the available stock
        if (cartQ + perQ <= productQ) {
            // If the product already exists, increase its quantity
            productInCart.quantity += 1; // Increment the package count
            
            productInCart.cartQuantity += perQ; // Update total quantity in grams
            console.log(`Added ${perQ} grams. Total cart quantity: ${productInCart.cartQuantity} grams`);
            showToast(productName + " Added to cart");
        }
        
        else {
        	 showToast(`Quantity exceeds available stock!`);
            console.log("Quantity exceeds available stock");
            console.log(`Current: ${cartQ} grams, Available: ${productQ} grams`);
        }
    } else {
    	let perQ = parseFloat(productPerQuantity);
        let productQ = parseFloat(productQuantity);

        let maxQuantity = Math.floor(productQ / perQ);
        // If the product does not exist, create a new product object and add it to the cart
        let newProduct = { 
            id: productId, 
            name: productName, 
            price: productPrice, 
            image: imageData, // Include base64 image string
            quantity: 1, // Start with 1 package
            cartQuantity: parseFloat(productPerQuantity), // Initial weight in grams
            maxQuantity: maxQuantity
        };
        cart.push(newProduct);
        console.log("New product added to cart");
        showToast(productName + " Added to cart");
    }

    // Save the updated cart back to localStorage
    localStorage.setItem('cart', JSON.stringify(cart));

    // Show a success message (assuming showToast is a function that handles this)
    
    count(); // Update cart count
}


function toggleFavorite(button) {
	const productId = button.getAttribute('data-product-id');

    $.ajax({
        url: '/Project/updateFavorites/' + productId,
        type: 'POST',
        success: function(response) {
            // Update button state, e.g., change text or style
            if (response === "Added to favorites") {
                button.textContent = "Unfavorite";  // Change button to "Unfavorite"
                showToast("Added to favorites!");  // Show toast notification
            } else if (response === "Removed from favorites") {
                button.textContent = "Favorite";  // Change button to "Favorite"
                showToast("Removed from favorites!");  // Show toast notification
            }
        },
        error: function() {
            showToast("Failed to update favorite status.");  // Show toast for error
        }
    });
}

function showToast(message) {
    var toast = document.getElementById("toast");
    toast.textContent = message;
    toast.className = "toast show";
    setTimeout(function() { toast.className = toast.className.replace("show", ""); }, 3000);
}
function count() {
    let totalcart = 0;
    cart.forEach(carts => {
      totalcart += carts.quantity;
    });
    document.getElementById("totalCart").innerHTML = totalcart;
 // Save the updated cart back to localStorage
    localStorage.setItem('cart', JSON.stringify(cart));
}
  count();
</script>


</body>
</html>
