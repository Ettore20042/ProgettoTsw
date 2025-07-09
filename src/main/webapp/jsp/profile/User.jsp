<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    </head>
    <body>
        <jsp:include page="/WEB-INF/jsp/components/common/header.jsp" />

        <% if (request.getSession().getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");%>
        <h1><%= user.getFirstName()%></h1><% }%>

        <main class="details-user-container">
            <div class="overview-user-section">
                <h1>Dati personali</h1>

                <% if (request.getSession().getAttribute("user") != null) {
                    User user = (User) session.getAttribute("user");%>

                    <h2>ID utente</h2>
                    <p><%= user.getUserId()%></p>
                    <h2>Nome</h2>
                    <p><%= user.getFirstName()%></p>
                    <h2>Cognome</h2>
                    <p><%= user.getLastName()%></p>
                    <h2>Numero di telefono</h2>
                    <p><%= user.getPhoneNumber()%></p>
                    <h2>Email</h2>
                    <p><%= user.getEmail()%></p>
                <% } %>
            </div>
        
                <div class="overview-user-orders">
                    <a href="${pageContext.request.contextPath}/OrderServlet?userId=${user.userId}" method="post" id="user-orders-link">
                        <h2>I tuoi ordini</h2>
                    </a>


                    <c:choose>
                        <c:when test="${not empty orderMessage}">
                            <p>${orderMessage}</p>
                        </c:when>

                        <c:when test="${not empty recentOrderList}">
                            <div class="order-grid">
                                <c:forEach var="order" items="${recentOrderList}">

                                        <c:if test="${not empty order.orderItems}">
                                            <div class="order-card">
                                            <p>${order.status}</p>
                                            <p>${order.orderDate}</p>
                                            <img src="${pageContext.request.contextPath}/ImageServlet?productId=${order.orderItems[0].productId}" alt="Immagine prodotto">
                                            </div>
                                                </c:if>

                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="error-message">${errorMessage}</p>
                        </c:otherwise>
                    </c:choose>

                    <% if (request.getSession().getAttribute("user") != null) {
                        User user = (User) session.getAttribute("user");%>
                    <form action="${pageContext.request.contextPath}/OrderServlet?userId=<%= user.getUserId()%>" method="post" id="view-all-orders-form">
                        <button type="submit" class="overview-user-orders-buttons" >Vedi tutti</button>
                    </form>
                    <% } %>
                </div>
        </main>

        <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp" />
    </body>
</html>
