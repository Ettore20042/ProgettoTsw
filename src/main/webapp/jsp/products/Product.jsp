<%@ page import="model.Bean.Product" %>
<%@ page import="model.Bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Product product = (Product) request.getAttribute("product");
    request.setAttribute("pageTitle", product.getProductName());
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <title><c:out value="${pageTitle}" default="BricoShop"/></title>
    <jsp:include page="/WEB-INF/jsp/components/common/headContent.jsp" />
    <script src="${pageContext.request.contextPath}/Js/products/ProductPage.js" defer></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productPage.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/components/common/header.jsp"/>
    <main class="product-page">

        <div class="breadcrumb">
            <div class="breadcrumb_wrapper">
                <c:forEach var="category" items="${breadcrumbCategories}">
                    <a href="${pageContext.request.contextPath}/ProductListServlet?categoryId=${category.categoryId}" class="breadcrumb_item breadcrumb_link">${category.categoryName}</a>
                    <span class="material-symbols-rounded">keyboard_arrow_right</span>
                </c:forEach>
                <span class="breadcrumb_item">${product.getProductName()}</span>
            </div>
        </div>

        <jsp:include page="../../WEB-INF/jsp/components/products/_productCard.jsp"/>
    </main>


    <jsp:include page="/WEB-INF/jsp/components/common/footer.jsp"/>
</body>
</html>
