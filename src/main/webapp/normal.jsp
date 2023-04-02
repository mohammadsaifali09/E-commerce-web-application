<%
    User normalUser=(User)session.getAttribute("current-user");
    if (normalUser==null)
    {
        session.setAttribute("message", "You are not logged in !! Login first");
        response.sendRedirect("login.jsp");
        return;
    }
    else
    {
        if (normalUser.getUserType().equals("admin"))
        {
        session.setAttribute("message", "You are not normal user ! Do not access this page");
        response.sendRedirect("login.jsp");
        return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Panel</title>
        
        <%@include file="components/common_css_js.jsp" %>
        
    </head>
    <body>
        
        <%@include file="components/navbar.jsp" %>
        
        <h1>This is normal user panel page</h1>
    </body>
</html>
