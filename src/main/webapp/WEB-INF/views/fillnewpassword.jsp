<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff9db;  /* Light background color */
            color: #333;                /* Dark text color */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 30%;                 /* Set width of the container */
            margin: 50px auto;         /* Center the container */
            padding: 20px;             /* Add padding */
            background-color: #fff;    /* White background for the form */
            border-radius: 10px;       /* Rounded corners */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            text-align: center;         /* Center text */
        }
        h2 {
            color: #ffcc00;            /* Gold color for the header */
        }
        form input[type="password"] {
            width: 100%;               /* Full width */
            padding: 12px;             /* Padding */
            margin: 10px 0;           /* Margin between fields */
            border-radius: 5px;        /* Rounded corners */
            border: 1px solid #ddd;    /* Light grey border */
        }
        form input[type="submit"] {
            background-color: #ffcc00; /* Button color */
            color: #fff;               /* White text */
            border: none;              /* No border */
            padding: 12px 20px;       /* Padding */
            font-size: 16px;          /* Font size */
            cursor: pointer;           /* Pointer cursor */
            border-radius: 5px;       /* Rounded corners */
            width: 100%;               /* Full width */
        }
        form input[type="submit"]:hover {
            background-color: #e6b800; /* Darker button color on hover */
        }
        .error {
            color: red;                /* Error text color */
            margin-bottom: 10px;      /* Margin for error messages */
        }
        .alert {
            display: none;             /* Hidden by default */
            padding: 10px;            /* Padding */
            margin: 10px 0;           /* Margin */
            border-radius: 5px;       /* Rounded corners */
            background-color: rgba(255, 0, 0, 0.1); /* Light red background */
            color: red;                /* Text color */
            border: 1px solid red;     /* Red border */
        }
    </style>
    <script>
        function showAlert(message) {
            const alertBox = document.getElementById("alertBox");
            alertBox.innerText = message;  // Set the alert message
            alertBox.style.display = "block"; // Show the alert box
        }

        function validateForm() {
            const password = document.forms["passwordForm"]["password"].value;
            const confirmPassword = document.forms["passwordForm"]["confirmPassword"].value;

            document.getElementById("alertBox").style.display = "none"; // Hide alert initially

            if (password.length < 8) {
                showAlert("Password must be at least 8 characters long.");
                return false;
            }

            if (password !== confirmPassword) {
                showAlert("Passwords do not match.");
                return false;
            }

            return true; // All validations passed
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Change Password</h2>
        <div id="alertBox" class="alert"></div> <!-- Custom alert box -->
        <form name="passwordForm" action="changenewpassword" method="post" onsubmit="return validateForm()">
            New Password: <input type="password" name="password" required><br>
            Confirm Password: <input type="password" name="confirmPassword" required><br>
            <input type="submit" value="Change Password">
        </form>
    </div>
</body>
</html>
