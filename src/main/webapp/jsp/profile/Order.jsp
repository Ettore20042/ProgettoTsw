<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("pageTitle", "BricoShop - User Orders");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>Orders</title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/">
</head>

<body>
    <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />

    <main class="listorders-user-container">
        <div class="listorders-user-list">
            <h1>I tuoi ordini</h1>

            <c:forEach var="order" items="${orderList}">
                <div class="listorders-user-order-card">
                    <p>Stato: ${order.status}</p>
                    <p>Data: ${order.orderDate}</p>
                    <p>Prodotti:</p>
                    <div class="listorders-user-order-card-products">

                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
</body>
</html>
