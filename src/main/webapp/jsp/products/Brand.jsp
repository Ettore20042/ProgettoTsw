<%--
  Created by IntelliJ IDEA.
  User: Utente
  Date: 06/05/2025
  Time: 12:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.setAttribute("pageTitle", " Brand");
%>

<body>
<jsp:include page="/jsp/common/Header.jsp"/>

<main class="brands-container">

    <section class="brands">
        <h2 class="brands-main-title--h2">I nostri brand</h2>
        <div class="brands-grid">
            <c:forEach var="brand" items="${brands}">
                    <div class="brand-card">
                        <div class="brand-card-maincategory">
                            <img src="${pageContext.request.contextPath}/${brand.logoPath}" alt="${brand.brandName}" />
                            <h3>${brand.brandName}</h3>
                            <a href="${pageContext.request.contextPath}/ProductListServlet?brandId=${brand.brandId}" class = "brand-card-maincategory-view-btn">Vedi prodotti</a>



                        </div>
                    </div>
            </c:forEach>
        </div>
    </section>

</main>

</body>
<jsp:include page="/jsp/common/Footer.jsp"/>
</html>
