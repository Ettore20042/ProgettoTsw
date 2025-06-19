<%@ page import="model.Bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - User Profile");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title><c:out value="${pageTitle}" default="BricoShop"/></title>
        <jsp:include page="/jsp/common/HeadContent.jsp" />

    </head>
    <body>
        <jsp:include page="/jsp/common/Header.jsp" />
            <% if (request.getSession().getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");%>
            <h1><%= user.getFirstName()%></h1><% }%>

        <jsp:include page="/jsp/common/Footer.jsp" />
    </body>
</html>
