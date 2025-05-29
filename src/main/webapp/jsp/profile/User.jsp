<%@ page import="model.Bean.User" %><%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 03/05/2025
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoBravo - User Profile");
%>
<jsp:include page="/jsp/common/Header.jsp" />
<body>
    <% if (request.getSession().getAttribute("user") != null) {
    User user = (User) session.getAttribute("user");%>
    <h1><%= user.getFirstName()%></h1><% }%>

</body>
<jsp:include page="/jsp/common/Footer.jsp" />
</html>
