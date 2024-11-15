<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout Page</title>
<style>
.custom-file-upload {
    position: relative;
    display: inline-block; /* Aligns with other elements */
    margin: 10px 0; /* Space above and below */
}

.custom-file-upload input[type="file"] {
    display: none; /* Hide the default file input */
}

.custom-file-upload label {
    display: inline-block;
    background-color: gray; /* Bootstrap primary color */
    color: white; /* White text */
    padding: 5px 10px; /* Smaller padding for a smaller button */
    border-radius: 5px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor */
    transition: background-color 0.3s; /* Smooth transition */
    font-size: 14px; /* Smaller font size */
}

.custom-file-upload label:hover {
    background-color: black; /* Darker shade on hover */
}

.custom-file-upload label:active {
    background-color: #004494; /* Even darker on click */
}


.custom-alert {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1000; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    background-color: rgba(0, 0, 0, 0.5); /* Black w/ opacity */
    justify-content: center; /* Center horizontally */
    align-items: center; /* Center vertically */
}

.alert-content {
    background-color: #fff; /* White background */
    padding: 20px; /* Padding for content */
    border-radius: 8px; /* Rounded corners */
    text-align: center; /* Center text */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Shadow effect */
}

#alertCloseButton {
    background-color: #007bff; /* Bootstrap primary color */
    color: white; /* White text */
    border: none; /* No border */
    padding: 10px 20px; /* Padding */
    border-radius: 5px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor */
}

#alertCloseButton:hover {
    background-color: #0056b3; /* Darker shade on hover */
}

/* Updated CSS for the modal box */

/* Updated CSS for the modal box */

.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1000; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgba(0, 0, 0, 0.5); /* Black w/ opacity */
}

.modal-content {
    background-color: #fefefe;
    margin: 1% auto; /* Centered and closer to the top */
    padding: 20px; /* Padding for content */
    border: 1px solid #888;
    width: 90%; /* Increase width to make it larger */
    max-width: 800px; /* Increase maximum width */
    height: 100%; /* Allow height to adjust automatically */
    max-height: 90%; /* Increase maximum height */
    border-radius: 10px; /* Rounded corners */
    text-align: center; /* Center text */
    overflow-y: auto; /* Allow vertical scrolling if content is too tall */
}

.modal-payment-image {
    width: 80%; /* Image width */
    max-width: 300px; /* Maximum width for the image */
    height: auto; /* Keep height proportional */
    object-fit: contain; /* Scale image to fit, maintain aspect ratio */
    margin: 0 auto; /* Center image horizontally */
}


.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.modal-payment-image {
    width: 100%; /* Adjust as necessary */
    height: auto; /* Maintain aspect ratio */
}

body {
	font-family: Arial, sans-serif;
}

.container {
	display: flex;
	justify-content: space-between;
	padding: 20px;
}

.form-container {
	width: 60%;
}

.summary-container {
	width: 35%;
	background-color: #f8f8f8;
	padding: 20px;
	border-radius: 10px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

.summary-total {
	font-weight: bold;
	font-size: 1.2em;
}

.btn-complete {
	width: 100%;
	padding: 10px;
	background-color: #000;
	color: #fff;
	border: none;
	cursor: pointer;
	font-size: 1em;
}
 .btn-cash {
            width: 100%;
            padding: 15px; /* Increased padding */
            background-color: #007bff; /* Blue background */
            color: #fff; /* White text */
            border: none; /* No border */
            border-radius: 8px; /* Rounded corners */
            font-size: 1.2em; /* Larger font */
            font-weight: bold; /* Bold text */
            cursor: pointer; /* Pointer cursor */
            transition: background-color 0.3s, transform 0.2s; /* Smooth transition */
        }

        .btn-cash:hover {
            background-color: #0056b3; /* Darker blue on hover */
            transform: translateY(-2px); /* Slight lift on hover */
        }
     .toast {
    visibility: visible;
    min-width: 400px; /* Width for larger size */
    max-width: 600px; /* Optional maximum width */
    background-color: orange; /* Deep blue background color */
    color: white; /* Text color */
    text-align: center; /* Center text */
    border-radius: 8px; /* Slightly round the corners */
    padding: 30px; /* Increased padding for larger size */
    position: fixed;
    z-index: 1000;
    left: 50%; /* Center horizontally */
    top: 50%; /* Center vertically */
    transform: translate(-50%, -50%); /* Adjust to center */
    font-size: 20px; /* Increased font size for better readability */
    transition: visibility 0s, opacity 0.5s linear;
    opacity: 1;
}

.toast.hidden {
    visibility: hidden;
    opacity: 0;
}

.closebtn {
    margin-left: 15px;
    color: white; /* Close button text color */
    font-weight: bold;
    float: right;
    font-size: 24px; /* Increased close button size */
    line-height: 20px;
    cursor: pointer;
}

        
</style>
</head>
<body>
	<div class="container">

		<!-- Left side form -->
		<div class="form-container">
			<h1>Order Now!</h1>
			<h2>Contact</h2>
			<div class="form-group">
			<label>Email or mobile phone number</label>
				<input type="email" name="email"
					placeholder="Email or mobile phone number" value="${userInfo.email }" readonly="readonly" >
			</div>

			<h2>Delivery</h2>
			<div class="form-group">
			<label>Name</label>
				<input type="text" name="firstName" placeholder="Name" value="${userInfo.name }" readonly="readonly" >
			</div>
	
			<div class="form-group">
			<label>Address</label>
				<input type="text" name="address" placeholder="Address" required="required">
			</div>
			<div class="form-group">
			<label>Phone</label>
			<p>If you want to change Phone number You can change In profile.
				<input type="text" name="phone" placeholder="Phone" value="${userInfo.phone}" readonly="readonly" >
			</div>

			<h2>Payment</h2>
			<c:forEach items="${paymentList}" var="pay">
    <input type="radio" id="payment-${pay.id}" name="payment" value="${pay.id}" 
           data-other-value="${pay.getBase64()}" checked>
   <label for="payment-${pay.id}">
    <img src="data:image/jpeg;base64,${pay.logoGetBase64()}" alt="${pay.payment_method_name} logo" style="width: 20px; height: 20px; vertical-align: middle; margin-right: 5px;">
    ${pay.payment_method_name}
</label>
     
</c:forEach>
			<div class="form-group">
				<h2>Order Note</h2>
				<textarea name="orderNote" rows="4" cols="50" placeholder="Write your order notes..."></textarea>
			</div>
			
		</div>

		<!-- Right side summary -->
		<div class="summary-container" id="summary-div">
			<h2>Order Items</h2>
			<!-- Placeholder for dynamically inserted summary -->
		</div>
	</div>
	<div id="myModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span> <!-- Close button -->
        <img id="modalPaymentQRImage" src="" alt="Payment QR Code" class="modal-payment-image">
        
        <h4>You need to scan the QR and give a screenshot back</h4>
        <div class="custom-file-upload">
    <input type="file" name="screenShot" id="screenShot" required="required">
    <label for="screenShot">Choose a screenshot</label>
</div>

        <button class="btn-cash" onclick="completeOrder()">Cash On Delivery</button>
        
    </div>
</div>

<div id="customAlert" class="custom-alert" style="display:none;">
    <div class="alert-content">
        <h4 id="alertTitle">Alert</h4>
        <p id="alertMessage">This is an alert message!</p>
        <button id="alertCloseButton">OK</button>
    </div>
</div>
<div id="toast" class="toast hidden">
    <span class="toast-message">Order submitted successfully!</span>
    <span class="closebtn" onclick="closeToast()">&times;</span>
</div>



	<script>
    // Retrieve cart data from localStorage
    
    let cart = JSON.parse(localStorage.getItem('cart')) || []; // Handle case where cart might be null
   

    // Function to populate the summary with cart data from localStorage
   function loadSummary() {
    const summaryContainer = document.querySelector('.summary-container');
    const paymentQR = document.querySelector('input[name="payment"]:checked').getAttribute('data-other-value'); // Get the QR code

    // Clear any existing summary items
    summaryContainer.innerHTML = '<h2>Order Items</h2>';

    // Check if cart is empty
    if (cart.length === 0) {
        summaryContainer.innerHTML += '<p>Your cart is empty.</p>';
        return; // Exit if the cart is empty
    }

    // Loop through each item in the cart and create summary rows
    cart.forEach(item => {
        // Constructing the base64 image source
        const imageSrc = 'data:image/jpeg;base64,' + item.image;

        // Create elements for each item (image, name, price, quantity) using string concatenation
        const itemRow = 
            '<div class="summary-item">' +
                '<span>Item Name</span>' +
                '<span>' + item.name + '</span>' +  // Using string concatenation
            '</div>' +
            '<div class="summary-item">' +
                '<span>Product</span>' +
                '<img src="' + imageSrc + '" alt="Product Image" style="width: 100px; height: 100px;">' +
            '</div>' +
            '<div class="summary-item">' +
                '<span>Price</span>' +
                '<span>MMK ' + item.price + '</span>' +  // Using string concatenation
            '</div>' +
            '<div class="summary-item">' +
                '<span>Quantity</span>' +
                '<span>' + item.quantity + '</span>' +
            '</div>' +
            '<div class="summary-item">' +
                '<span>Pack</span>' +
                '<span>' + item.perQuantity+' '+item.perUnit + '</span>' +
            '</div>'+
            '<hr style="border: 1px solid #ccc; margin: 10px 0;">';  // Add line between items

        // Append the item row to the summary container
        summaryContainer.innerHTML += itemRow;
    });

    // Calculate the total cost
    totalCost = cart.reduce((acc, item) => acc + (item.price * item.quantity), 0);

    // Add the total row to the summary
    summaryContainer.innerHTML += 
        '<div class="summary-total summary-item">' +
            '<span>Total</span>' +
            '<span>MMK ' + totalCost + '</span>' +
        '</div>' +
        '<button class="btn-complete" onclick="showModal()">Complete order</button>'; // Call showModal without parameters
}

    // Call the function when the page loads
    window.onload = loadSummary;
    
    

    // Function to handle order completion
  function completeOrder() {
    const address = document.querySelector('input[name="address"]').value;
    const orderNote = document.querySelector('textarea[name="orderNote"]').value;

    // Get the value of the selected radio button in the payment list
    const selectedPayment2 = document.querySelector('input[name="payment"]:checked').value;

    const screenshotInput = document.querySelector('input[name="screenShot"]');
    const selectedFile = screenshotInput.files[0];

    // Check if the address field is empty
    if (!address) {
    	showAlert('Address Required', 'Please enter your address to complete the order.');
        return; // Stop the function here if address is empty
    }
    if (!selectedFile) {
    	showAlert('Screenshot Required', 'Please enter your payment screenshot to confirm your order.');
        return; // Stop the function here if no screenshot is provided
    }


    // Create an address object
    const addressData = {
        address: address
    };

    // Assuming your localStorage key is 'cart'
    const cartData = JSON.parse(localStorage.getItem('cart'));

    // Prepare the order data object
    const orderData = {
        cartItems: cartData,
        address: addressData,
        paymentId: selectedPayment2,
        orderNote: orderNote,
        totalAmount: totalCost,
        screenshot: null // Initialize with null
    };

    // Handle the file reading
    const reader = new FileReader();
    reader.onload = function(event) {
        // Assign the base64 content directly to the orderData's screenshot property
        const base64Screenshot = event.target.result.split(',')[1];
        orderData.screenshot = base64Screenshot;

        // Send the cart data to the backend via a POST request after reading the file
        fetch('order/update_order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData) // Convert the combined order data to JSON
        })
        .then(response => {
            if (response.ok) {
            	 const toast = document.getElementById('toast');
            	    toast.classList.remove('hidden');
                // Optionally clear the cart
                localStorage.removeItem('cart');
                 // Redirect to your controller

            } else {
                alert('Error submitting the order');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
 

       
    };

    // Read the file as a Data URL (base64) if a file is selected
    if (selectedFile) {
        reader.readAsDataURL(selectedFile);
    } else {
        // If no file is selected, send order data without screenshot
        fetch('order/update_order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData) // Convert the combined order data to JSON
        })
        .then(response => {
            if (response.ok) {
           
                alert('Order submitted successfully!');
                // Optionally clear the cart
                localStorage.removeItem('cart');
            } else {
                alert('Error submitting the order');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
		
        alert('Order Completed!');
    }
}

    function showModal() {
        const selectedPaymentQR = document.querySelector('input[name="payment"]:checked').getAttribute('data-other-value'); // Get the QR code
        let imageElement = document.getElementById('modalPaymentQRImage');
        imageElement.src = 'data:image/jpeg;base64,' + selectedPaymentQR;

        // Display the modal (ensure it's visible)
        const modal = document.getElementById('myModal');
        modal.style.display = 'block'; // Show the modal
    }

    // Add a function to close the modal
    function closeModal() {
        const modal = document.getElementById('myModal');
        modal.style.display = 'none'; // Hide the modal
    }

    // Close the modal when clicking outside of the modal content
   function showAlert(title, message) {
    document.getElementById('alertTitle').textContent = title;
    document.getElementById('alertMessage').textContent = message;
    document.getElementById('customAlert').style.display = 'flex'; // Show the alert
}

// To close the alert when the button is clicked
document.getElementById('alertCloseButton').onclick = function() {
    document.getElementById('customAlert').style.display = 'none'; // Hide the alert
};
function closeToast() {
    const toast = document.getElementById('toast');
    toast.classList.add('hidden');
}
</script>


</body>
</html>
