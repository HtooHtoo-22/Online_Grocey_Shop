/**
 * 
 */
function showModal(productId, productName, productDescription, productImage, productPrice, productPerQuantity, productUnit, productCategoryName, productQuantity, realProductId) {
    document.getElementById('modalProductName').textContent = productName;
    document.getElementById('modalProductDescription').textContent = productDescription;
    document.getElementById('modalProductCategoryName').textContent = productCategoryName;
    document.getElementById('modalProductImage').src = productImage;
    console.log(productImage);
    document.getElementById('modalProductPrice').textContent = productPrice;
    document.getElementById('modalProductQuantity').textContent = productPerQuantity;
    document.getElementById('modalProductUnit').textContent = productUnit;

    // Set the data-product-id for the favorite button
    let favoriteButton = document.getElementById('modalFavoriteButton');
    favoriteButton.setAttribute('data-product-id', realProductId);
    
    // Set onclick for adding the product to the cart
    document.getElementById('modalAddToCartButton').onclick = function() {
        addToCart(productId, productName, productPrice, productImage, productQuantity, productPerQuantity);
    };

    // Display the modal
    document.getElementById('myModal').style.display = "block";
}

function closeModal() {
    document.getElementById('myModal').style.display = "none";
}

let cart = localStorage.getItem('cart') ? JSON.parse(localStorage.getItem('cart')) : [];

function addToCartWithQuantity(productId, productName, productPrice, productImage, productQuantity, productPerQuantity, productUnit, realProductUnit) {
    // Select the input field and parse the desired quantity
    let hehe = document.getElementById('modalQuantity');
    let keke = parseInt(hehe.value, 10);
    let desiredQuantity;

    // Properly define the `quantityInput`
    let quantityInput = document.getElementById(`quantity-${productId}`);

    if (keke > 0) {
        desiredQuantity = keke;
    } else {
        if (quantityInput) {
            desiredQuantity = parseInt(quantityInput.value, 10);
        } else {
            console.error("Quantity input not found");
            return;
        }
    }

    // Validate the input to ensure it's a number and greater than zero
    if (isNaN(desiredQuantity) || desiredQuantity < 1) {
        showToast("Please enter a valid quantity.");
        return;
    }

    // Convert product and per-quantity values to numeric types
    productQuantity = parseFloat(productQuantity);
    const perQ = parseFloat(productPerQuantity);

    // Convert units if needed before calculating maxQuantity
    if (productUnit === "gram" && realProductUnit === "kilogram") {
        productQuantity *= 1000; // Convert kg to g
    } else if (productUnit === "kilogram" && realProductUnit === "gram") {
        productQuantity /= 1000; // Convert g to kg
    }

    // Calculate the maximum quantity allowed based on stock
    const maxQuantity = Math.floor(productQuantity / perQ);

    // Limit desiredQuantity to maxQuantity if it exceeds available stock
    if (desiredQuantity > maxQuantity) {
        desiredQuantity = maxQuantity;
        quantityInput.value = maxQuantity; // Update input field with max quantity
        showToast(`Maximum available stock reached. Added ${maxQuantity} to cart.`);
    }

    // Calculate the total cart quantity in the specified unit
    const totalCartQuantity = desiredQuantity * perQ;

    // Pass the correct quantity to addToCart
    addToCart(productId, productName, productPrice, productImage, productQuantity, productPerQuantity, productUnit, realProductUnit, totalCartQuantity);
}


 function addToCart(productId, productName, productPrice, productImage, productQuantity, productPerQuantity, productUnit, realProductUnit, totalCartQuantity) {
    const imageData = productImage.replace('data:image/jpeg;base64,', '');
    productPrice = parseFloat(productPrice);

    // Convert kg to grams if needed
    
    // Check if the product already exists in the cart
    let productInCart = cart.find(item => item.id === productId);

    if (productInCart) {
        const cartQ = parseFloat(productInCart.cartQuantity);

        // Check if adding new quantity exceeds stock
        if (cartQ + totalCartQuantity <= productQuantity) {
            productInCart.quantity += totalCartQuantity / parseFloat(productPerQuantity);
            productInCart.cartQuantity += totalCartQuantity;
            showToast(`${productName} added to cart`);
        } else {
            showToast(`Quantity exceeds available stock!`);
        }
    } else {
        // If the product does not exist, add it with the correct quantity
        const newProduct = {
            id: productId,
            name: productName,
            price: productPrice,
            image: imageData,
            quantity: totalCartQuantity / parseFloat(productPerQuantity),
            cartQuantity: totalCartQuantity,
            maxQuantity: Math.floor(productQuantity / parseFloat(productPerQuantity)),
            perQuantity: parseFloat(productPerQuantity),
            perUnit: productUnit
        };
        cart.push(newProduct);
        showToast(`${productName} added to cart`);
    }

    // Update local storage with the updated cart
    localStorage.setItem('cart', JSON.stringify(cart));
    count(); // Update cart count display
}



function toggleFavorite(button) {
    const productId = button.getAttribute('data-product-id');
    const heartIcon = button.querySelector('svg use');

    $.ajax({
        url: '/Project/updateFavorites/' + productId,
        type: 'POST',
        success: function(response) {
            // Update button state, change icon
            if (response === "Added to favorites") {
                heartIcon.setAttribute('xlink:href', '#heart-filled');  // Change to filled heart
                showToast("Added to favorites!");  // Show toast notification
            } else if (response === "Removed from favorites") {
                heartIcon.setAttribute('xlink:href', '#heart-outline');  // Change to outlined heart
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