<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
table {
    width: 100%; /* Full width for the table */
    border-collapse: collapse; /* Remove space between table cells */
    margin-bottom: 20px; /* Space below the table */
}

th, td {
    padding: 10px; /* Space around text */
    text-align: left; /* Align text to the left */
    border-bottom: 1px solid #ddd; /* Light grey line between rows */
}

th {
    background-color: #ffcc00; /* Bright yellow background for the header */
    color: black; /* Black text color for better visibility */
}

tr:hover {
    background-color: #ffe57f; /* Lighter yellow background on row hover */
}

button {
    background-color: #ffcc00; /* Bright yellow background */
    color: black; /* Black text */
    border: none; /* No border */
    border-radius: 5px; /* Rounded corners */
    padding: 5px 10px; /* Space inside the button */
    cursor: pointer; /* Pointer cursor on hover */
}

button:hover {
    background-color: #e6b800; /* Darker yellow on hover */
}

/* Styles for the Clear Cart button */
button.clear-cart {
    background-color: red; /* Red background for clear cart button */
    color: white; /* White text for better contrast */
}

button.clear-cart:hover {
    background-color: darkred; /* Darker red on hover */
}

input[type="number"] {
    width: 60px; /* Fixed width for quantity input */
    text-align: center; /* Center text */
    border: 1px solid #ccc; /* Light grey border */
    border-radius: 5px; /* Rounded corners */
}

/* Full-width styles */
body {
    margin: 0; /* Remove default margin */
    padding: 20px; /* Padding around the body */
    background-color: #f9f9f9; /* Light grey background for contrast */
}
#checkout-section {
    text-align: center; /* Center the button */
    margin-top: 20px; /* Space above the button */
}

#checkout-button {
    display: inline-block; /* Make the link behave like a button */
    background-color: #ffcc00; /* Bright yellow background */
    color: black; /* Black text */
    padding: 15px 30px; /* Larger padding for a bigger button */
    font-size: 20px; /* Bigger text size */
    border-radius: 5px; /* Rounded corners */
    text-decoration: none; /* Remove underline */
    transition: background-color 0.3s ease; /* Smooth transition */
}

#checkout-button:hover {
    background-color: #e6b800; /* Darker yellow on hover */
}

    button {
        margin: 10px;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    #confirmYes {
        background-color: #28a745; /* Green */
        color: white;
    }
    #confirmNo {
        background-color: #dc3545; /* Red */
        color: white;
    }
   
    .cmodal {
        display: none; /* Hidden by default */
        position: fixed;
        top: 0;
        left: 0;
        width: 20%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
        z-index: 1000;
    }
    .cmodal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 100px;
        border-radius: 8px;
        text-align: center;
    }
    button {
        margin: 10px;
        padding: 10px 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    #confirmYes {
        background-color: #28a745; /* Green */
         padding: -100px;
          margin: 10px;
        color: white;
        
    }
    #confirmNo {
        background-color: #dc3545; /* Red */
         padding: 10px 20px;
          margin: 10px;
        color: white;
    }
   
</style>
<meta charset="ISO-8859-1">
<title>My Cart</title>
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
   <h1>Your Cart</h1>
<table>
   
    <tbody id="cart-container">
        <!-- Cart items will be rendered here using JavaScript -->
    </tbody>
</table>

    <button class="clear-cart" onclick="clearCartWithConfirmation()">Clear Cart</button>

<div id="checkout-section" style="display: none;">
    <a href="checkout" id="checkout-button">Check Out</a>
</div>
<div id="customConfirmModal" class="modal">
    <div class="modal-content">
        <p>Are you sure you want to clear the cart?</p>
        <button id="confirmYes">Yes</button>
        <button id="confirmNo">No</button>
    </div>
</div>


    
    <script src="${pageContext.request.contextPath}/resources/static/js/jquery-1.11.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/script.js"></script>
   
    <script src="${pageContext.request.contextPath}/resources/static/js/customize.js"></script>
<script>
document.addEventListener('DOMContentLoaded', renderCart);
count();

function renderCart() {
    let testcart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

    if (testcart.length === 0) {
        document.getElementById('cart-container').innerHTML = '<p>Your cart is empty.</p>';
        document.getElementById('checkout-section').style.display = 'none'; // Hide checkout section
        return;
    }

    let cartHtml = '<table style="width: 100%; border-collapse: collapse;">'; // Start table
    cartHtml += '<thead><tr><th>Image</th><th>Pack</th><th>Product Name</th><th>Price</th><th>Quantity</th><th>Total</th><th>Actions</th></tr></thead>';
    cartHtml += '<tbody>';

    let totalAmount = 0;

    testcart.forEach(item => {
        let itemTotalPrice = item.quantity * item.price;
        totalAmount += itemTotalPrice;

        cartHtml += '<tr>';
        cartHtml += '<td><img src="data:image/jpeg;base64,' + item.image + '" alt="' + item.name + '" style="width:100px;height:100px;"/></td>';
        cartHtml +=  '<td>' + item.perQuantity +' '+ item.perUnit+ '</td>';
        cartHtml += '<td>' + item.name + '</td>';
        cartHtml += '<td>' + item.price.toLocaleString() + ' KS</td>'; // Format price
        
        // Display the quantity along with perQuantity and perUnit
        cartHtml += '<td>' +
            '<button onclick="adjustQuantity(\'' + item.id + '\', -1)">-</button>' +
            '<input type="number" id="quantity-' + item.id + '" value="' + item.quantity + '" min="1" style="width: 50px; text-align: center;" readonly />' +
            '<button onclick="adjustQuantity(\'' + item.id + '\', 1)">+</button>' +
           
            '</td>';

        cartHtml += '<td>' + itemTotalPrice.toLocaleString() + ' KS</td>'; // Format total price
        cartHtml += '<td><button onclick="deleteItem(\'' + item.id + '\')">Delete</button></td>';
        cartHtml += '</tr>';
    });

    cartHtml += '</tbody>'; // End table body
    cartHtml += '</table>'; // End table

    cartHtml += '<div><h3>Total Amount: ' + totalAmount.toLocaleString() + ' KS</h3></div>'; // Format total amount

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
        function clearCart() {
            localStorage.removeItem('cart');
            window.location.reload(); // Reload the page to reflect the changes
        }
        function clearCartWithConfirmation() {
            const modal = document.getElementById('customConfirmModal');
            modal.style.display = 'block';

            document.getElementById('confirmYes').onclick = function() {
                clearCart(); // Call your existing clearCart function
                modal.style.display = 'none';
            };

            document.getElementById('confirmNo').onclick = function() {
                modal.style.display = 'none';
            };
        }

        // To close the modal when clicking outside it (optional)
        window.onclick = function(event) {
            const modal = document.getElementById('customConfirmModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };function clearCartWithConfirmation() {
            const modal = document.getElementById('customConfirmModal');
            modal.style.display = 'block';

            document.getElementById('confirmYes').onclick = function() {
                clearCart(); // Call your existing clearCart function
                modal.style.display = 'none';
            };

            document.getElementById('confirmNo').onclick = function() {
                modal.style.display = 'none';
            };
        }

        // To close the modal when clicking outside it (optional)
        window.onclick = function(event) {
            const modal = document.getElementById('customConfirmModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };

    </script>
</body>
</html>