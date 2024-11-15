<%-- header-sidebar.jsp --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <!-- Header -->
    <header class="header">
        <div class="menu-icon" onclick="openSidebar()">
            <span class="material-icons-outlined">menu</span>
        </div>
        <div class="header-left">
            <span class="material-icons-outlined"></span>
        </div>
        <div class="header-right">
            <span class="header-admin-name">${adminName}</span>
            <div class="profile-photo">
                 <img src="${pageContext.request.contextPath}/resources/static/images/admin1.jfif" alt="Profile Photo">
            </div>
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
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/product/adminProductList"><span class="material-icons-outlined">inventory_2</span>Products</a></li>
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/categoryList"><span class="material-icons-outlined">category</span>Categories</a></li>
            <li class="sidebar-list-item"><a href="<c:url value='/user/users' />"><span class="material-icons-outlined">groups</span>Customers</a></li>
            <li class="sidebar-list-item"><a href="${pageContext.request.contextPath}/allorder"><span class="material-icons-outlined">fact_check</span>Orders</a></li>
            <c:if test="${admin=='sa'}">
                <li class="sidebar-list-item"><a href="<c:url value='/admin/admins' />"><span class="material-icons-outlined">manage_accounts</span>Admin</a></li>
            </c:if>
            <li class="sidebar-list-item">
                <a href="<c:url value='/payment/methods' />">
                    <span class="material-icons-outlined">credit_card</span> Payment Methods
                </a>
            </li>
        </ul>
    </aside>
