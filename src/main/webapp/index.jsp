<%--
  Created by IntelliJ IDEA.
  User: ettor
  Date: 05/07/2025
  Time: 13:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  response.sendRedirect(request.getContextPath() +"/ProductListServlet?homePage=true&limit=10");
%>
</body>
</html>
