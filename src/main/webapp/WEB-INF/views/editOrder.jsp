<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Order Address</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/static/css/style.css' />">
</head>
<body>

<h2>Edit Order Address</h2>

<!-- Check for any error message -->
<c:if test="${not empty error}">
    <div class="error">${error}</div>
</c:if>

<!-- Form to edit address -->
<form action="${pageContext.request.contextPath}/updateOrder/${order.orderId}" method="post">
    <label for="userAddress">Address:</label>
    <input type="text" id="userAddress" name="userAddress" value="${order.userAddress}" required />

    <input type="hidden" name="id" value="${order.orderId}" />

    <button type="submit">Update Address</button>
    <a href="${pageContext.request.contextPath}/orders/all">Cancel</a>
</form>

</body>
</html>
