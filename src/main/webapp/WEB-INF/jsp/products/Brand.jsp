<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title><c:out value="${pageTitle}" default="BricoShop"/></title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products/brands.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>

<main class="brands-container">

    <section class="brands">
        <h2 class="brands-main-title--h2">I nostri brand</h2>
        <div class="brands-grid">
            <c:forEach var="brand" items="${brands}">
                    <div class="brand-card">
                        <div class="brand-card-maincategory">
                            <img src="${pageContext.request.contextPath}/${brand.logoPath}" alt="${brand.brandName}" />
                            <h3>${brand.brandName}</h3>
                            <a  href="${pageContext.request.contextPath}/ProductListServlet?brandId=${brand.brandId}" class = "brand-card-maincategory-view" >Vedi prodotti</a>



                        </div>
                    </div>
            </c:forEach>
        </div>
    </section>

</main>

<jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
