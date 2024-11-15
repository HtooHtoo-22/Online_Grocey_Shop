<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Confirm Password</title>
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
        form input[type="text"],
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
    </style>
</head>
<body>

<div class="container">
    <h2>Confirm Password</h2>
    <form action="checkpassword" method="post">
        <div class="error">${wrongpassword}</div> <!-- Display error message if any -->
        <label for="email">Email</label>
        <input type="text" value="${userInfo.email}" readonly="readonly" name="email" id="email"><br>

        <label for="oldPassword123">Password</label>
        <input type="password" name="oldPassword123" placeholder="Enter your old password" autocomplete="new-password" id="oldPassword123"><br>

        <input type="submit" value="Next">
    </form>
</div>

</body>
</html>
