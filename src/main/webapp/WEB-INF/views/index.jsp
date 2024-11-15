<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
  <head>
    <title>Organic - Grocery Store HTML Website Template</title>
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
.success-message {
    color: #388e3c;                /* Dark green text color for better contrast */
    font-weight: bold;            /* Bold text */
    margin-bottom: 20px;          /* Space below the message */
    display: none;                /* Initially hidden */
    background-color: #dcedc8;    /* Soft green background */
    padding: 15px;                /* Increased padding for a better feel */
    border: 1px solid #c8e6c9;    /* Subtle border to enhance visibility */
    border-radius: 8px;           /* Slightly more rounded corners */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
    opacity: 0;                   /* Initially fully transparent */
    transition: opacity 0.5s ease, transform 0.5s ease; /* Smooth transition for opacity and position */
    transform: translateY(-10px); /* Slightly moved up */
    
    /* Centering styles */
    text-align: center;           /* Center text horizontally */
    line-height: 1.5;             /* Adjust line height for vertical spacing */
}

/* To make the message visible with animation */
.success-message.visible {
    display: block;                /* Show the message */
    opacity: 1;                   /* Fully opaque */
    transform: translateY(0);     /* Move to original position */
}


</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
   <meta name="mobile-web-app-capable" content="yes">

    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
	
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
        
        <symbol xmlns="http://www.w3.org/2000/svg" id="package" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m24 13.264l7.288 4.21L24 21.681l-7.288-4.209Z"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M16.712 17.473v8.418L24 30.101l7.288-4.21v-8.418M24 30.1v-8.418"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M40.905 21.405a16.905 16.905 0 1 0-23.389 15.611L24 43.5l6.484-6.484a16.906 16.906 0 0 0 10.42-15.611"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="secure" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M14.134 36V20.11h19.732M19.279 36h14.587V25.45"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m19.246 26.606l4.135 4.135l5.373-5.372m-8.934-9.282a4.087 4.087 0 1 1 8.174 0m0 0v4.023m-8.172-4.108v4.108"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M30.288 44.566a21.516 21.516 0 1 1 9.69-6.18"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="quality" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m30.59 13.45l4.77 2.94L24 34.68l-10.33-7l3.11-4.6l5.52 3.71l8.26-13.38Z"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M24 4.5s-11.26 2-15.25 2v20a11.16 11.16 0 0 0 .8 4.1a15 15 0 0 0 2 3.61a22 22 0 0 0 2.81 3.07a34.47 34.47 0 0 0 3 2.48a34 34 0 0 0 2.89 1.86c1 .59 1.71 1 2.13 1.19l1 .49a1.44 1.44 0 0 0 1.24 0l1-.49c.42-.2 1.13-.6 2.13-1.19a34 34 0 0 0 2.89-1.86a34.47 34.47 0 0 0 3-2.48a22 22 0 0 0 2.81-3.07a15 15 0 0 0 2-3.61a11.16 11.16 0 0 0 .8-4.1v-20c-3.99.03-15.25-2-15.25-2"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="savings" viewBox="0 0 48 48"><circle cx="24" cy="24" r="21.5" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M12.5 23.684a3.298 3.298 0 0 1 5.63-2.332l3.212 3.212h0l8.53-8.53a3.298 3.298 0 0 1 5.628 2.333h0c0 .875-.348 1.714-.966 2.333L22.983 32.25a2.321 2.321 0 0 1-3.283 0l-6.234-6.233a3.298 3.298 0 0 1-.966-2.333"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="offers" viewBox="0 0 48 48"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="m41.556 39.297l-22.022 3.11a1.097 1.097 0 0 1-1.245-.97l-2.352-22.311a1.097 1.097 0 0 1 1.08-1.213l24.238-.229a1.097 1.097 0 0 1 1.108 1.09l.137 19.429c.004.55-.4 1.017-.944 1.094M26.1 25.258v2.579m8.494-2.731v2.175"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M34.343 32.346c-1.437.828-1.926 1.198-2.774 1.988c-1.19-.457-2.284-1.228-3.797-1.456m-15.953 8.721l-3.49-1.6a1.12 1.12 0 0 1-.643-.863L5.511 23.593c-.056-.4.108-.8.43-1.046l3.15-2.406a1.257 1.257 0 0 1 2.014.874l1.966 19.69a.887.887 0 0 1-1.252.894m11.989-28.112c.214-.456.964-1.716 2.76-3.618c3.108-3.323 4.26-4.288 4.26-4.288s1.42.75 3.27 3.109c1.876 2.358 1.93 3.832 1.93 3.832s.67-.08-4.797 1.688c-3.055.991-4.368 1.152-4.931 1.152"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M26.97 17.828v-.054c0-.884-.241-1.715-.67-2.412c-.563-.91-1.447-1.608-2.492-1.876a3.58 3.58 0 0 0-1.072-.16c-.429 0-.858.053-1.233.214c-1.152.348-2.063 1.18-2.573 2.278a4.747 4.747 0 0 0-.428 1.956v.134"/><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M18.93 15.818c-.562-.107-1.5-.349-3.135-.884c-2.304-.75-3.43-1.528-3.43-1.528s-.456-1.393 1.045-3.296s2.653-2.52 2.653-2.52s.911.778 3.43 3.485c1.26 1.313 1.796 2.09 2.01 2.465h.027"/></symbol>
        
        <symbol xmlns="http://www.w3.org/2000/svg" id="delivery" viewBox="0 0 32 32"><path fill="currentColor" d="m29.92 16.61l-3-7A1 1 0 0 0 26 9h-3V7a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v17a1 1 0 0 0 1 1h2.14a4 4 0 0 0 7.72 0h6.28a4 4 0 0 0 7.72 0H29a1 1 0 0 0 1-1v-7a1 1 0 0 0-.08-.39M23 11h2.34l2.14 5H23ZM9 26a2 2 0 1 1 2-2a2 2 0 0 1-2 2m10.14-3h-6.28a4 4 0 0 0-7.72 0H4V8h17v12.56A4 4 0 0 0 19.14 23M23 26a2 2 0 1 1 2-2a2 2 0 0 1-2 2m5-3h-1.14A4 4 0 0 0 23 20v-2h5Z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="organic" viewBox="0 0 24 24"><path fill="currentColor" d="M0 2.84c1.402 2.71 1.445 5.241 2.977 10.4c1.855 5.341 8.703 5.701 9.21 5.711c.46.726 1.513 1.704 3.926 2.21l.268-1.272c-2.082-.436-2.844-1.239-3.106-1.68l-.005.006c.087-.484 1.523-5.377-1.323-9.352C7.182 3.583 0 2.84 0 2.84m24 .84c-3.898.611-4.293-.92-11.473 3.093a11.879 11.879 0 0 1 2.625 10.05c3.723-1.486 5.166-3.976 5.606-6.466c0 0 1.27-4.716 3.242-6.677M12.527 6.773l-.002-.002v.004zM2.643 5.22s5.422 1.426 8.543 11.543c-2.945-.889-4.203-3.796-4.63-5.168h.006a15.863 15.863 0 0 0-3.92-6.375z"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="fresh" viewBox="0 0 24 24"><g fill="none"><path d="M24 0v24H0V0zM12.594 23.258l-.012.002l-.071.035l-.02.004l-.014-.004l-.071-.036c-.01-.003-.019 0-.024.006l-.004.01l-.017.428l.005.02l.01.013l.104.074l.015.004l.012-.004l.104-.074l.012-.016l.004-.017l-.017-.427c-.002-.01-.009-.017-.016-.018m.264-.113l-.014.002l-.184.093l-.01.01l-.003.011l.018.43l.005.012l.008.008l.201.092c.012.004.023 0 .029-.008l.004-.014l-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014l-.034.614c0 .012.007.02.017.024l.015-.002l.201-.093l.01-.008l.003-.011l.018-.43l-.003-.012l-.01-.01z"/><path fill="currentColor" d="M20 9a1 1 0 0 1 1 1v1a8 8 0 0 1-8 8H9.414l.793.793a1 1 0 0 1-1.414 1.414l-2.496-2.496a.997.997 0 0 1-.287-.567L6 17.991a.996.996 0 0 1 .237-.638l.056-.06l2.5-2.5a1 1 0 0 1 1.414 1.414L9.414 17H13a6 6 0 0 0 6-6v-1a1 1 0 0 1 1-1m-4.793-6.207l2.5 2.5a1 1 0 0 1 0 1.414l-2.5 2.5a1 1 0 1 1-1.414-1.414L14.586 7H11a6 6 0 0 0-6 6v1a1 1 0 1 1-2 0v-1a8 8 0 0 1 8-8h3.586l-.793-.793a1 1 0 0 1 1.414-1.414"/></g></symbol>

        <symbol xmlns="http://www.w3.org/2000/svg" id="star-full" viewBox="0 0 24 24"><path fill="currentColor" d="m3.1 11.3l3.6 3.3l-1 4.6c-.1.6.1 1.2.6 1.5c.2.2.5.3.8.3c.2 0 .4 0 .6-.1c0 0 .1 0 .1-.1l4.1-2.3l4.1 2.3s.1 0 .1.1c.5.2 1.1.2 1.5-.1c.5-.3.7-.9.6-1.5l-1-4.6c.4-.3 1-.9 1.6-1.5l1.9-1.7l.1-.1c.4-.4.5-1 .3-1.5s-.6-.9-1.2-1h-.1l-4.7-.5l-1.9-4.3s0-.1-.1-.1c-.1-.7-.6-1-1.1-1c-.5 0-1 .3-1.3.8c0 0 0 .1-.1.1L8.7 8.2L4 8.7h-.1c-.5.1-1 .5-1.2 1c-.1.6 0 1.2.4 1.6"/></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="star-half" viewBox="0 0 24 24"><path fill="currentColor" d="m3.1 11.3l3.6 3.3l-1 4.6c-.1.6.1 1.2.6 1.5c.2.2.5.3.8.3c.2 0 .4 0 .6-.1c0 0 .1 0 .1-.1l4.1-2.3l4.1 2.3s.1 0 .1.1c.5.2 1.1.2 1.5-.1c.5-.3.7-.9.6-1.5l-1-4.6c.4-.3 1-.9 1.6-1.5l1.9-1.7l.1-.1c.4-.4.5-1 .3-1.5s-.6-.9-1.2-1h-.1l-4.7-.5l-1.9-4.3s0-.1-.1-.1c-.1-.7-.6-1-1.1-1c-.5 0-1 .3-1.3.8c0 0 0 .1-.1.1L8.7 8.2L4 8.7h-.1c-.5.1-1 .5-1.2 1c-.1.6 0 1.2.4 1.6m8.9 5V5.8l1.7 3.8c.1.3.5.5.8.6l4.2.5l-3.1 2.8c-.3.2-.4.6-.3 1c0 .2.5 2.2.8 4.1l-3.6-2.1c-.2-.2-.3-.2-.5-.2"/></symbol>

        <symbol xmlns="http://www.w3.org/2000/svg" id="user" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="9" r="3"/><circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M17.97 20c-.16-2.892-1.045-5-5.97-5s-5.81 2.108-5.97 5"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="wishlist" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M21 16.09v-4.992c0-4.29 0-6.433-1.318-7.766C18.364 2 16.242 2 12 2C7.757 2 5.636 2 4.318 3.332C3 4.665 3 6.81 3 11.098v4.993c0 3.096 0 4.645.734 5.321c.35.323.792.526 1.263.58c.987.113 2.14-.907 4.445-2.946c1.02-.901 1.529-1.352 2.118-1.47c.29-.06.59-.06.88 0c.59.118 1.099.569 2.118 1.47c2.305 2.039 3.458 3.059 4.445 2.945c.47-.053.913-.256 1.263-.579c.734-.676.734-2.224.734-5.321Z"/><path stroke-linecap="round" d="M15 6H9"/></g></symbol>
        <symbol xmlns="http://www.w3.org/2000/svg" id="shopping-bag" viewBox="0 0 24 24"><g fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3.864 16.455c-.858-3.432-1.287-5.147-.386-6.301C4.378 9 6.148 9 9.685 9h4.63c3.538 0 5.306 0 6.207 1.154c.901 1.153.472 2.87-.386 6.301c-.546 2.183-.818 3.274-1.632 3.91c-.814.635-1.939.635-4.189.635h-4.63c-2.25 0-3.375 0-4.189-.635c-.814-.636-1.087-1.727-1.632-3.91Z"/><path d="m19.5 9.5l-.71-2.605c-.274-1.005-.411-1.507-.692-1.886A2.5 2.5 0 0 0 17 4.172C16.56 4 16.04 4 15 4M4.5 9.5l.71-2.605c.274-1.005.411-1.507.692-1.886A2.5 2.5 0 0 1 7 4.172C7.44 4 7.96 4 9 4"/><path d="M9 4a1 1 0 0 1 1-1h4a1 1 0 1 1 0 2h-4a1 1 0 0 1-1-1Z"/><path stroke-linecap="round" stroke-linejoin="round" d="M8 13v4m8-4v4m-4-4v4"/></g></symbol>

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
    <c:if test="${not empty message}">
    <div id="successMessage" class="success-message visible">
            ${message}
        </div>
    </c:if>
   
    <section style="background-image: url('${pageContext.request.contextPath}/resources/static/images/banner-1.jpg');background-repeat: no-repeat;background-size: cover;">
      <div class="container-lg">
        <div class="row">
          <div class="col-lg-6 pt-5 mt-5">
           <h2 class="display-1 ls-1">
  <span class="fw-bold" style="color: #2e7d32;">Organic</span> 
  Foods at your 
  <span class="fw-bold" style="color: #e65100;">Doorsteps</span>
</h2>

            <p class="fs-4">
    <span style="color: #2e7d32; font-weight: bold;">Fresh</span> Ingredients Delivered to Your <span style="color: #2e7d32; font-weight: bold;">Kitchen</span>
</p>

            <div class="d-flex gap-3">
              <a href="productlist" class="btn text-uppercase fs-6 rounded-pill px-4 py-3 mt-3" style="background-color: #2e7d32; color: white;">Start Shopping</a>
			  

            </div>
            <div class="row my-5">
              <div class="col">
                <div class="row text-dark">
                  <div class="col-auto"><p class="fs-1 fw-bold lh-sm mb-0">14k+</p></div>
                  <div class="col"><p class="text-uppercase lh-sm mb-0">Product Varieties</p></div>
                </div>
              </div>
              <div class="col">
                <div class="row text-dark">
                  <div class="col-auto"><p class="fs-1 fw-bold lh-sm mb-0">50k+</p></div>
                  <div class="col"><p class="text-uppercase lh-sm mb-0">Happy Customers</p></div>
                </div>
              </div>
              <div class="col">
                <div class="row text-dark">
                  <div class="col-auto"><p class="fs-1 fw-bold lh-sm mb-0">10+</p></div>
                  <div class="col"><p class="text-uppercase lh-sm mb-0">Store Locations</p></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="row row-cols-1 row-cols-sm-3 row-cols-lg-3 g-0 justify-content-center">
          <div class="col">
            <div class="card border-0 bg-primary rounded-0 p-4 text-light">
              <div class="row">
                <div class="col-md-3 text-center">
                  <svg width="60" height="60"><use xlink:href="#fresh"></use></svg>
                </div>
                <div class="col-md-9">
                  <div class="card-body p-0">
                  <h5 class="text-light">Fresh from farm</h5>
<p class="card-text">This is fresh, quality produce directly from the farm to you.</p>

                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card border-0 bg-secondary rounded-0 p-4 text-light">
              <div class="row">
                <div class="col-md-3 text-center">
                  <svg width="60" height="60"><use xlink:href="#organic"></use></svg>
                </div>
                <div class="col-md-9">
                  <div class="card-body p-0">
                   <h5 class="text-light">100% Organic</h5>
<p class="card-text">Naturally grown with no artificial additives for the best quality.</p>

                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card border-0 bg-danger rounded-0 p-4 text-light">
              <div class="row">
                <div class="col-md-3 text-center">
                  <svg width="60" height="60"><use xlink:href="#delivery"></use></svg>
                </div>
                <div class="col-md-9">
                  <div class="card-body p-0">
                    <h5 class="text-light">Free Delivery</h5>
<p class="card-text">Enjoy fast and free delivery on all your orders.</p>

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      
      </div>
    </section>

    <section class="py-5 overflow-hidden">
    <div class="container-lg">
        <div class="row">
            <div class="col-md-12">
                <div class="section-header d-flex flex-wrap justify-content-between mb-5">
                    <h2 class="section-title">Categories</h2>

                    <div class="d-flex align-items-center">
                        <a href="category" class="btn btn-primary me-2">View All</a>
                        <div class="swiper-buttons">
                            <button class="swiper-prev category-carousel-prev btn btn-yellow">❮</button>
                            <button class="swiper-next category-carousel-next btn btn-yellow">❯</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="category-carousel swiper">
    <div class="swiper-wrapper">
        <c:forEach var="entry" items="${categoryPages}">
            <c:set var="category" value="${entry.key}" />
            <c:set var="pageNumber" value="${entry.value}" />
            
            <div class="swiper-slide col-6 col-md-4 col-lg-2 text-center"> <!-- Added swiper-slide class here -->
                <a href="productlist?pageNumber=${pageNumber}#${category.name}" class="nav-link d-flex flex-column align-items-center">
                    <img src="data:image/jpeg;base64,${category.getBase64()}" class="category-img mb-2" alt="${category.name}">
                    <h5 class="mb-0">${category.name}</h5>
                </a>
            </div>
        </c:forEach>
    </div>
    <!-- Optional: Add pagination and navigation buttons -->
  
</div>

            </div>
        </div>
    </div>
</section>

   <section class="pb-5">
  <div class="container-lg">

    <div class="row">
      <div class="col-md-12">

        <div class="section-header d-flex flex-wrap justify-content-between my-4">
          <h2 class="section-title">Best Selling Products</h2>
          
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">

        <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
          
          <c:if test="${not empty popularList}">
            <c:forEach items="${popularList}" var="popularItem">
              <div class="col">
                <div class="product-item">
                  <figure class="product-image-container">
                    <a href="javascript:void(0)" class="nav-link swiper-slide text-center" title="${popularItem.productName}" onclick="showModal('${popularItem.id}', '${popularItem.productName}', '${popularItem.description}', 'data:image/jpeg;base64,${popularItem.getBase64()}', ${popularItem.price}, ${popularItem.per_quantity}, '${popularItem.unit}', '${popularItem.categoryName}', '${popularItem.quantity}','${popularItem.productId}','${popularItem.productUnit}')">
                      <img src="data:/jpeg;base64,${popularItem.getBase64()}" alt="${popularItem.productName}" class="tab-image product-img">
                    </a>
                  </figure>
                  <div class="d-flex flex-column text-center">
                    <h3 class="fs-6 fw-normal">${popularItem.productName}</h3>
                    <div>
                      
                      <!-- Replace with dynamic review count if available -->
                    </div>
                    <div class="d-flex justify-content-center align-items-center gap-2">
                    <div class="text-dark fw-semibold">${popularItem.per_quantity} ${popularItem.unit} /</div>
                      <span class="text-dark fw-semibold">${popularItem.price} KS</span>
                    </div>
                    <div class="button-area p-3 pt-0">
                      <div class="row g-1 mt-2">
                       
                    
                 <div class="col-12 d-flex justify-content-start align-items-center">
    <!-- Quantity Input -->
    <div class="button-container" style="display: flex; align-items: center; justify-content: flex-start;">

    <!-- Quantity Input -->
    <input type="number" 
    id="quantity-${popularItem.id}" 
    class="quantity-input" 
    value="1" 
    min="1" 
    style="width: 40px; text-align: center; margin: 0; font-size: 14px; padding: 2px;">

    <!-- Add to Cart Button -->
    <button 
        type="button" 
        class="btn rounded-1 btn-cart" 
        
        style="width: 150px; background-color: #ffc107; color: black; padding: 10px; margin: 0 3px;"
        
        onclick="addToCartWithQuantity('${popularItem.id}', '${popularItem.productName}', ${popularItem.price}, '${popularItem.getBase64()}', '${popularItem.quantity}', '${popularItem.per_quantity}', '${popularItem.unit}', '${popularItem.productUnit}')">
        <svg width="16" height="16"><use xlink:href="#cart"></use></svg> Add to Cart
    </button>

    <!-- Favorite Button -->
    <button 
        type="button" 
        class="btn btn-outline-dark rounded-1 favorite-button" 
        style="width: 35px; padding: 4px; margin-left: 0;"
        data-product-id="${popularItem.productId}" 
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
            </c:forEach>
          </c:if>
<!-- Custom Modal -->
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
      </div>
    </div>
  </div>
  
</section>

  


    

    

    

    

    

    <section class="pb-4 my-4">
      <div class="container-lg">

        <div class="bg-warning pt-5 rounded-5">
          <div class="container">
            <div class="row justify-content-center align-items-center">
              <div class="col-md-4">
                <h2 class="mt-5">Download Our App</h2>
                <p>Online Orders made easy, fast and reliable</p>
                <div class="d-flex gap-2 flex-wrap mb-5">
                  <a href="#" title="App store"><img src="${pageContext.request.contextPath}/resources/static/images/img-app-store.png" alt="app-store"></a>
                  <a href="#" title="Google Play"><img src="${pageContext.request.contextPath}/resources/static/images/img-google-play.png" alt="google-play"></a>
                </div>
              </div>
              <div class="col-md-5">
                <img src="${pageContext.request.contextPath}/resources/static/images/banner-onlineapp.png" alt="phone" class="img-fluid">
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </section>

    <section class="py-5">
      <div class="container-lg">
        <div class="row row-cols-1 row-cols-sm-3 row-cols-lg-5">
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32"><use xlink:href="#package"></use></svg>
              </div>
              <div class="card-body p-0">
                <h5>Free delivery</h5>
                <p class="card-text"></p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32"><use xlink:href="#secure"></use></svg>
              </div>
              <div class="card-body p-0">
                <h5>100% secure payment</h5>
                <p class="card-text"></p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32"><use xlink:href="#quality"></use></svg>
              </div>
              <div class="card-body p-0">
                <h5>Quality guarantee</h5>
                <p class="card-text"></p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32"><use xlink:href="#savings"></use></svg>
              </div>
              <div class="card-body p-0">
                <h5>guaranteed savings</h5>
                <p class="card-text"></p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32"><use xlink:href="#offers"></use></svg>
              </div>
              <div class="card-body p-0">
                <h5>Daily offers</h5>
                <p class="card-text"></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <footer class="py-5">
      <div class="container-lg">
        <div class="row">

          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <img src="${pageContext.request.contextPath}/resources/static/images/logo8.jpg" width="240" height="180" alt="logo">
              <div class="social-links mt-3">
                <ul class="d-flex list-unstyled gap-2">
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg width="16" height="16"><use xlink:href="#facebook"></use></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg width="16" height="16"><use xlink:href="#twitter"></use></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg width="16" height="16"><use xlink:href="#youtube"></use></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg width="16" height="16"><use xlink:href="#instagram"></use></svg>
                    </a>
                  </li>
                  <li>
                    <a href="#" class="btn btn-outline-light">
                      <svg width="16" height="16"><use xlink:href="#amazon"></use></svg>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Organic</h5>
             <ul class="menu-list list-unstyled">
  <li class="menu-item">About us</li>
  <li class="menu-item">Conditions</li>
  <li class="menu-item">Our Journals</li>
  <li class="menu-item">Careers</li>
  <li class="menu-item">Affiliate Programme</li>
  <li class="menu-item">Ultras Press</li>
</ul>
</div>
</div>
<div class="col-md-2 col-sm-6">
  <div class="footer-menu">
    <h5 class="widget-title">Quick Links</h5>
    <ul class="menu-list list-unstyled">
      <li class="menu-item">Offers</li>
      <li class="menu-item">Discount Coupons</li>
      <li class="menu-item">Stores</li>
      <li class="menu-item">Track Order</li>
      <li class="menu-item">Shop</li>
      <li class="menu-item">Info</li>
    </ul>
  </div>
</div>
<div class="col-md-2 col-sm-6">
  <div class="footer-menu">
    <h5 class="widget-title">Customer Service</h5>
    <ul class="menu-list list-unstyled">
      <li class="menu-item">FAQ</li>
      <li class="menu-item">Contact</li>
      <li class="menu-item">Privacy Policy</li>
      <li class="menu-item">Returns & Refunds</li>
      <li class="menu-item">Cookie Guidelines</li>
      <li class="menu-item">Delivery Information</li>
    </ul>

            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Subscribe Us</h5>
              <p>Subscribe to our newsletter to get updates about our grand offers.</p>
             
            </div>
          </div>
          
        </div>
      </div>
    </footer>
    <div id="footer-bottom">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-6 copyright">
            <p>© 2024 Organic. All rights reserved.</p>
          </div>
         
        </div>
      </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/resources/static/js/jquery-1.11.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/script.js"></script>
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