<%@page import="project.Model.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="project.Repository.ProductRepo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${categories}" var="Cat">
    <span>${Cat.name}</span>
    <img src="data:image/jpeg;base64,${Cat.getBase64()}" width="200" height="200"/>

    <c:forEach items="${productsByCategory[Cat.id]}" var="Product">
        ${Product.productName}
        <img src="data:image/jpeg;base64,${Product.getBase64()}" width="100" height="100"/> 
    </c:forEach>
</c:forEach>

</body>
</html>