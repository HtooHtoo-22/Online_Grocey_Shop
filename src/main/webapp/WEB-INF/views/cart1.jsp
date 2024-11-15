<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <style>
     body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff7e5; /* Light background */
        }
          .navbar { background-color: #f7eb91; overflow: hidden; padding: 10px 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar a { float: left; display: block; padding: 14px; color: #333; text-decoration: none; margin: 0 5px; border-radius: 4px; transition: background-color 0.3s; }
        .navbar a:hover { background-color: #e6d27a; }
        .content {
            padding: 20px;
        }
         
        .search-container { float: right; display: flex; align-items: center; }
        .search-container input, .search-container button { padding: 5px; margin-right: 5px; border-radius: 4px; }
        .search-container button { background-color: #f7eb91; border: none; cursor: pointer; }
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
    @keyframes fadein { from { bottom: 0; opacity: 0; } to { bottom: 30px; opacity: 1; } }
        @keyframes fadeout { from { bottom: 30px; opacity: 1; } to { bottom: 0; opacity: 0; } }
    </style>
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
        <form action="search.jsp" method="GET">
            <input type="text" name="query" placeholder="Search...">
            <button type="submit">Search</button>
        </form>
    </div>
</div>
    <h1>Your Cart</h1>
    <div id="cart-container">
        <!-- Cart items will be rendered here using JavaScript -->
    </div>
    <div id="checkout-section" style="display: none;">
        <a href="checkout">Check Out</a>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', renderCart);
        count();
        
        function renderCart() {
        	
            let testcart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];
            console.log(testcart); // Check the contents of the cart
            console.log(testcart.image);	

            if (testcart.length === 0) {
                document.getElementById('cart-container').innerHTML = '<p>Your cart is empty.</p>';
                return;
            }

            let cartHtml = '';
            let totalAmount = 0;

            testcart.forEach(item => {
                // Calculate the total price for the current item (quantity * price)
                let itemTotalPrice = item.quantity * item.price;

                // Add the item price to the total amount
                totalAmount += itemTotalPrice;

                // Generate the HTML for each item in the cart
                cartHtml += 
                    '<div>' +
                        '<img src="data:image/jpeg;base64,' + item.image + '" alt="' + item.name + '" style="width:100px;height:100px;"/>' +
                        
                        '<h3>' + item.name + '</h3>' +
                        '<p>Price: ' + item.price + ' KS</p>' +
                        '<div>' +
                            '<button onclick="adjustQuantity(\'' + item.id + '\', -1)">-</button>' + // Decrease quantity
                            '<input type="number" id="quantity-' + item.id + '" value="' + item.quantity + '" min="1" style="width: 50px; text-align: center;" readonly />' +

                            '<button onclick="adjustQuantity(\'' + item.id + '\', 1)">+</button>' + // Increase quantity
                            '<button onclick="deleteItem(\'' + item.id + '\')">Delete</button>' + // Delete button
                        '</div>' +
                        '<p>Total Price: ' + itemTotalPrice + ' KS</p>' +
                    '</div>';
            });

            // After the loop, add the total amount to the HTML
            cartHtml += '<div><h3>Total Amount: ' + totalAmount + ' KS</h3></div>';
            

            document.getElementById('cart-container').innerHTML = cartHtml;
            if (testcart.length > 0) {
                document.getElementById('checkout-section').style.display = 'block';
            } else {
                document.getElementById('checkout-section').style.display = 'none';
            }
            count();
        }

        function adjustQuantity(itemId, adjustment) {
            // Retrieve the cart from localStorage
            let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

            // Find the item in the cart
            let item = cart.find(i => i.id === itemId);

            if (item) {
                // Adjust the quantity
                let newQuantity = item.quantity + adjustment;

                // Ensure the new quantity does not exceed maxQuantity
                if (newQuantity > item.maxQuantity) {
                	 showToast(`Quantity exceeds available stock!`);
                    return;
                     // Prevent further actions if the max quantity is exceeded
                }

                // If the quantity is less than 1, remove the item from the cart
                if (newQuantity < 1) {
                    deleteItem(itemId); // Call deleteItem function to remove it
                } else {
                    // Update the item quantity in the cart
                    item.quantity = newQuantity;

                    // Save the updated cart back to localStorage
                    localStorage.setItem('cart', JSON.stringify(cart));

                    // Refresh the cart display
                    renderCart(); // Call your renderCart function to update the UI
                }
            }

            // Update the cart item count
            count();
        }
        function showToast(message) {
            var toast = document.getElementById("toast");
            toast.textContent = message;
            toast.className = "toast show";
            setTimeout(function() { toast.className = toast.className.replace("show", ""); }, 3000);
        }

        function deleteItem(itemId) {
            // Retrieve the cart from localStorage
            let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

            // Filter out the item to be deleted
            cart = cart.filter(item => item.id !== itemId);

            // Save the updated cart back to localStorage
            localStorage.setItem('cart', JSON.stringify(cart));

            // Refresh the cart display
            renderCart();
            count();
        }
        function count() {
            // Retrieve the cart from localStorage
            let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

            let totalcart = 0;
            // Loop through each item in the cart and sum up the quantities
            cart.forEach(item => {
                totalcart += item.quantity;
            });

            // Update the cart badge
            document.getElementById("totalCart").innerHTML = totalcart;
        }

    </script>
    
    <button onclick="clearCart()">Clear Cart</button>

    <script>
        function clearCart() {
            localStorage.removeItem('cart');
            window.location.reload(); // Reload the page to reflect the changes
        }
        
    </script>
    
</body>
</html>