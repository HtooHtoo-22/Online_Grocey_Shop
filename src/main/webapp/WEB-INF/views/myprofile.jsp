<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Profile Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff9db; /* Light yellow background */
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        img {
            display: block;
            margin: 0 auto 20px;
            border-radius: 50%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="file"], input[type="submit"] {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #ffcc00; /* Yellow submit button */
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #e6b800; /* Darker yellow hover */
        }
        h2 {
            font-size: 18px;
            margin-bottom: 5px;
            color: #ffcc00; /* Yellow headings */
        }
        .readonly {
            background-color: #f0f0f0;
            cursor: not-allowed;
        }
        .logout-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: red; /* Matching yellow background */
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .logout-button:hover {
            background-color: #e6b800; /* Darker yellow hover */
        }
        /* Modal Background */
        .modal {
            display: none;                   /* Hidden by default */
            position: fixed;                /* Stay in place */
            z-index: 1000;                 /* Sit on top */
            left: 0;
            top: 0;
            width: 100%;                    /* Full width */
            height: 100%;                   /* Full height */
            overflow: auto;                 /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.7); /* Dark background with opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #ffffff;      /* White background */
            margin: 15% auto;               /* Center modal */
            padding: 30px;                  /* Padding inside modal */
            border-radius: 10px;            /* Rounded corners */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Shadow for depth */
            width: 400px;                   /* Width of the modal */
            text-align: center;             /* Center text */
        }

        /* Modal Title */
        .modal-content h2 {
            margin: 0 0 15px;               /* Margin for title */
            font-size: 24px;                /* Title font size */
            color: #333;                    /* Dark grey color */
        }

        /* Modal Message */
        .modal-content p {
            font-size: 16px;                /* Message font size */
            color: #555;                    /* Medium grey color */
        }

        /* Modal Buttons */
        .modal-button {
            padding: 10px 20px;            /* Padding for buttons */
            margin: 10px;                  /* Margin around buttons */
            font-size: 16px;               /* Font size */
            color: white;                  /* Text color */
            background-color: #007BFF;     /* Primary blue background */
            border: none;                  /* No border */
            border-radius: 5px;            /* Rounded corners */
            cursor: pointer;                /* Pointer cursor */
            transition: background-color 0.3s ease, transform 0.2s; /* Smooth transition */
        }

        .modal-button:hover {
            background-color: #0056b3;      /* Darker blue on hover */
            transform: scale(1.05);          /* Slightly enlarge on hover */
        }

        .modal-button:active {
            transform: scale(0.95);          /* Slightly shrink on click */
        }

        .success-message {
            color: green;                /* Text color */
            font-weight: bold;          /* Bold text */
            margin-bottom: 20px;        /* Space below the message */
            display: none;              /* Initially hidden */
            background-color: #e8f5e9;  /* Light green background */
            padding: 10px;              /* Padding around the message */
            border: 1px solid #c8e6c9;  /* Border to enhance visibility */
            border-radius: 5px;         /* Rounded corners */
            opacity: 0;                 /* Initially fully transparent */
            transition: opacity 0.5s ease, transform 0.5s ease; /* Smooth transition for opacity and position */
            transform: translateY(-10px); /* Slightly moved up */
        }

        /* To make the message visible with animation */
        .success-message.visible {
            display: block;             /* Show the message */
            opacity: 1;                /* Fully opaque */
            transform: translateY(0);  /* Move to original position */
        }
    </style>
</head>
<body>
<div id="logoutModal" class="modal">
    <div class="modal-content">
        <h2>Confirm Logout</h2>
        <p>Are you sure you want to log out?</p>
        <button id="confirmLogout" class="modal-button">Yes</button>
        <button id="cancelLogout" class="modal-button">No</button>
    </div>
</div>

<div class="container">
    

    <img src="data:image/jpeg;base64,${userInfo.get64()}" width="200" height="200"/>
	<c:if test="${not empty message}">
        <div id="successMessage" class="success-message visible">
            ${message}
        </div>
    </c:if>
    <form action="changeProfile1" method="post" enctype="multipart/form-data">
        <input type="file" name="file" required>
        <input type="submit" value="Change Profile">
    </form>

    <form action="home" method="post">
        <h2>Name</h2>
        <input type="text" value="${userInfo.name}" name="name">

        <h2>Email</h2>
        <input type="text" value="${userInfo.email}" class="readonly" readonly="readonly">

        <h2>Phone Number</h2>
        <input type="text" value="${userInfo.phone}" class="readonly" readonly="readonly">

        <input type="submit" value="Save Changes">
    </form>

    <form action="changePassword" method="post">
        <input type="submit" value="Change Password">
    </form>
    <a href="logout" onclick="logoutWithConfirmation(event)" class="logout-button">Log Out</a>
</div>

<script>
    function logoutWithConfirmation(event) {
        event.preventDefault(); // Prevents the default action of the link
        const modal = document.getElementById("logoutModal");
        modal.style.display = "block"; // Show the modal

        document.getElementById("confirmLogout").onclick = function() {
            window.location.href = "logout"; // Redirects to logout if confirmed
        };

        document.getElementById("cancelLogout").onclick = function() {
            modal.style.display = "none"; // Hide the modal if canceled
        };
    }

    // Close modal when clicking outside of it
    window.onclick = function(event) {
        const modal = document.getElementById("logoutModal");
        if (event.target == modal) {
            modal.style.display = "none"; // Hide modal if clicked outside
        }
    };

    // Display the success message if it exists and hide it after 3 seconds
    window.onload = function() {
        const successMessage = document.getElementById("successMessage");
        if (successMessage && successMessage.innerText.trim() !== "") {
            successMessage.classList.add("visible"); // Show the message

            // Set a timeout to hide the message after 3 seconds (3000 milliseconds)
            setTimeout(() => {
                successMessage.style.opacity = 0; // Fade out the message
                setTimeout(() => {
                    successMessage.style.display = "none"; // Hide the message completely after fading out
                }, 500); // Match the timing with CSS transition
            }, 3000);
        }
    };
</script>
</body>
</html>
