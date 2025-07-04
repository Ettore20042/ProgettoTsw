<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="sub-categories_wrapper">
    <c:if test="${not empty subCategories}">
        <h4 class="sub-categories_heading">Cerca per sottocategorie</h4>
    </c:if>
    <ul class="sub-categories_list">
        <c:forEach var="subCategory" items="${subCategories}">
            <li class="sub-categories_item">
                <a href="${pageContext.request.contextPath}/ProductListServlet?categoryId=${subCategory.categoryId}" class="sub-categories_link">
                    ${subCategory.categoryName}
                </a>
            </li>
        </c:forEach>
    </ul>
</section>