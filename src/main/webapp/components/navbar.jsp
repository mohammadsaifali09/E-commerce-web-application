<%@page import="com.saif.e_commerce.entities.User"%>
<%
    User user = (User) session.getAttribute("current-user");
%>

<nav class="navbar navbar-expand-lg custom-bg ">
    <div class="container">
        <a class="navbar-brand" style="color: black;" href="index.jsp">E-commerce</a>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" style="color: black;" aria-current="page" href="index.jsp">Home</a>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto">
                
                <li class="nav-item active">
                    <a class="nav-link" style="color: black;" href="#!" data-toggle="modal" data-target="#cart"> <i class="fa fa-cart-plus"  style="font-size: 18px;"></i> <span class="cart-items"  style="font-size: 15px;">(0)</span> </a>
                </li>

                <%
                    if (user == null) {
                %>

                <li class="nav-item active">
                    <a class="nav-link" style="color: black;" href="login.jsp">Login</a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" style="color: black;" href="register.jsp">Register</a>
                </li>

                <%
                } else {
                %>

                <li class="nav-item active">
                    <a class="nav-link" style="color: black;" href="<%=user.getUserType().equals("admin")?"admin.jsp":"normal.jsp"%>"><%=user.getUserName()%></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" style="color: black;" href="LogoutServlet">Logout</a>
                </li>

                <%
                    }
                %>

            </ul>

        </div>
    </div>
</nav>