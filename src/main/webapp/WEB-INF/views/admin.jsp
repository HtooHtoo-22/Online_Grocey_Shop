<%@page import="project.Model.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<%
    List<ProductBean> topProducts = (List<ProductBean>) request.getAttribute("topProducts");
    ObjectMapper objectMapper = new ObjectMapper();
    String topProductsJson = objectMapper.writeValueAsString(topProducts);
%>


<html lang="en">
<head>
<style>


</style>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/admin.css?v=1.0">

</head>
<body>
<div class="grid-container">
    <!-- Header -->
    <header class="header">
        <div class="menu-icon" onclick="openSidebar()">
            <span class="material-icons-outlined">menu</span>
        </div>
        <div class="header-left">
            <span class="material-icons-outlined"></span>
        </div>
        <div class="header-right">
        	<div style="position: relative; display: inline-block;">
     
    <span class="material-icons-outlined " style="font-size: 24px; color: white;">notifications</span>
    
  <c:if test="${not empty pendingCount && pendingCount > 0}">
    <span class="badge badge-pill badge-danger" style="font-size: 20px; padding: 1px 8px; position: absolute; top: -20px; right: -14px; color:red;font-weight: bold">
        ${pendingCount}
    </span>
    </c:if>
    
</div>
            <span class="header-admin-name">${adminName}</span>
            <div class="profile-photo">
                 <img src="${pageContext.request.contextPath}/resources/static/images/admin1.jfif" alt="Profile Photo">
            </div>
            <a href="adminLogOut" class="logout-button" onclick="return confirm('Are you sure you want to log out?');">Log Out</a>

        </div>
    </header>
    <!-- End Header -->

    <!-- Sidebar -->
    <aside id="sidebar">
        <div class="sidebar-title">
            <div class="sidebar-brand">
                <div class="profile-photo">
                    <img src="${pageContext.request.contextPath}/resources/static/images/admin1.jfif" alt="Profile Photo">
                </div>
                <span class="store-text">STORE</span>
            </div>
            <span class="material-icons-outlined" onclick="closeSidebar()">close</span>
        </div>
        <ul class="sidebar-list">
            <li class="sidebar-list-item"><a href="<c:url value='/admin' />"><span class="material-icons-outlined">dashboard</span>Dashboard</a></li>
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/adminProductList"><span class="material-icons-outlined">inventory_2</span>Products</a></li>
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/categoryList"><span class="material-icons-outlined">category</span>Categories</a></li>
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/users"><span class="material-icons-outlined">groups</span>Customers</a></li>
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/allorder"><span class="material-icons-outlined">fact_check</span>Orders</a></li>
            <c:if test="${admin=='sa'}">
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/admins"><span class="material-icons-outlined">manage_accounts</span>Admin</a></li>
            </c:if>

         	<li class="sidebar-list-item">
    <a href="${pageContext.request.contextPath}/paymentMethodList">
        <span class="material-icons-outlined">credit_card</span> Payment Methods
    </a>
</li>
         	
        </ul>
    </aside>
    <!-- End Sidebar -->

    <!-- Main -->
    <main class="main-container">
        <div class="main-title">
            <h2>DASHBOARD</h2>
        </div>
        <div class="main-cards">
            <div class="card"><div class="card-inner"><h3>PRODUCTS</h3><span class="material-icons-outlined">inventory_2</span></div><h1>${productCount}</h1></div>
            <div class="card"><div class="card-inner"><h3>CATEGORIES</h3><span class="material-icons-outlined">category</span></div><h1>${categoryCount}</h1></div>
            <div class="card"><div class="card-inner"><h3>CUSTOMERS</h3><span class="material-icons-outlined">groups</span></div><h1>${customerCount}</h1></div>
            <div class="card"><div class="card-inner"><h3>ORDERS</h3><span class="material-icons-outlined">shopping_cart</span></div><h1>${orderCount}</h1></div>
        </div>
        <div class="charts">
            <div class="charts-card">
                <h2 class="chart-title">Top 5 Products</h2>
                <div id="bar-chart"></div>
            </div>
            <div class="charts-card">
                <h2 class="chart-title">Sales Orders</h2>
                <div id="area-chart"></div>
            </div>
        </div>
    </main>
    <!-- End Main -->
</div>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.35.3/apexcharts.min.js"></script>




<script>
function renderBarChart(topProducts) {
    // Extract names and popularity
    const productNames = topProducts.map(product => product.productName);
    const productPopularity = topProducts.map(product => product.popularity);

    console.log("Rendering bar chart with data:", topProducts); // Debugging line

    // Bar chart options
    var barChartOptions = {
        series: [{
            data: productPopularity,
            name: "Popularity",
        }],
        chart: {
            type: "bar",
            background: "transparent",
            height: 350,
            toolbar: {
                show: false,
            },
        },
        colors: [
            "#2962ff",
            "#d50000",
            "#2e7d32",
            "#ff6d00",
            "#583cb3",
        ],
        plotOptions: {
            bar: {
                distributed: true,
                borderRadius: 4,
                horizontal: false,
                columnWidth: "40%",
            }
        },
        dataLabels: {
            enabled: false,
        },
        fill: {
            opacity: 1,
        },
        grid: {
            borderColor: "#55596e",
            yaxis: {
                lines: {
                    show: true,
                },
            },
            xaxis: {
                lines: {
                    show: true,
                },
            },
        },
        legend: {
            labels: {
                colors: "#f5f7ff",
            },
            show: true,
            position: "top",
        },
        stroke: {
            colors: ["transparent"],
            show: true,
            width: 2
        },
        tooltip: {
            shared: true,
            intersect: false,
            theme: "dark",
        },
        xaxis: {
            categories: productNames,
            title: {
                style: {
                    color: "#f5f7ff",
                },
            },
            axisBorder: {
                show: true,
                color: "#55596e",
            },
            axisTicks: {
                show: true,
                color: "#55596e",
            },
            labels: {
                style: {
                    colors: "#f5f7ff",
                },
            },
        },
        yaxis: {
            title: {
                text: "Count",
                style: {
                    color: "#f5f7ff",
                },
            },
            axisBorder: {
                color: "#55596e",
                show: true,
            },
            axisTicks: {
                color: "#55596e",
                show: true,
            },
            labels: {
                style: {
                    colors: "#f5f7ff",
                },
            },
        },
    };
    // Render the chart
    var barChart = new ApexCharts(document.querySelector("#bar-chart"), barChartOptions);
    barChart.render();
}
    const topProducts = <%= topProductsJson %>;
    console.log(topProducts);

    // Define renderBarChart function
   

    document.addEventListener("DOMContentLoaded", function() {
        renderBarChart(topProducts);
    });
    fetch('/Project/sales-data-weekdays')
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        var areaChartOptions = {
            series: [{
                name: "Sales Orders",
                data: data.data, // Sales amounts
            }],
            chart: {
                type: "area",
                background: "transparent",
                height: 350,
                stacked: false,
                toolbar: {
                    show: false,
                },
            },
            colors: ["#d50000"],
            labels: data.labels, // Weekday labels
            dataLabels: {
                enabled: false,
            },
            fill: {
                gradient: {
                    opacityFrom: 0.4,
                    opacityTo: 0.1,
                    shadeIntensity: 1,
                    stops: [0, 100],
                    type: "vertical",
                },
                type: "gradient",
            },
            grid: {
                borderColor: "#55596e",
                yaxis: {
                    lines: {
                        show: true,
                    },
                },
                xaxis: {
                    lines: {
                        show: true,
                    },
                },
            },
            legend: {
                labels: {
                    colors: "#f5f7ff",
                },
                show: true,
                position: "top",
            },
            markers: {
                size: 6,
                strokeColors: "#1b2635",
                strokeWidth: 3,
            },
            stroke: {
                curve: "smooth",
            },
            xaxis: {
                axisBorder: {
                    color: "#55596e",
                    show: true,
                },
                axisTicks: {
                    color: "#55596e",
                    show: true,
                },
                labels: {
                    offsetY: 5,
                    style: {
                        colors: "#f5f7ff",
                    },
                },
            },
            yaxis: {
                title: {
                    text: "Sales Amount",
                    style: {
                        color: "#f5f7ff",
                    },
                },
                labels: {
                    style: {
                        colors: ["#f5f7ff"],
                    },
                },
            },
            tooltip: {
                shared: true,
                intersect: false,
                theme: "dark",
            }
        };

        var areaChart = new ApexCharts(document.querySelector("#area-chart"), areaChartOptions);
        areaChart.render();
    })
    .catch(error => {
        console.error("Error fetching sales data:", error);
    });
</script>
</body>
</html>
