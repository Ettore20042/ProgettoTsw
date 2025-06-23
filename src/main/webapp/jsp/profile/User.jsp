<%@ page import="model.Bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - User Profile");
%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <title>User</title>
        <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />

    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />
            <% if (request.getSession().getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");%>
            <h1><%= user.getFirstName()%></h1><% }%>

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
    </body>
</html>
