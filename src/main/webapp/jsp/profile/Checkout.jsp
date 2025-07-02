<%--
  Created by IntelliJ IDEA.
  User: ettor
  Date: 21/06/2025
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<h1>Checkout ${total},${quantity},${productId}</h1>


<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
