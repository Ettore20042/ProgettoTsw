<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="manage-components-container-right--modal" id="productModal">
    <div class="modal-content">
        <span class="close" id="close-modal">&times;</span>
        <h2 id="modalTitle">Aggiungi una nuova categoria</h2>
        <form id="addCategoryForm" action="${pageContext.request.contextPath}/ManageCategoryServlet" method="post">
            <label for="categoryName">Nome Categoria:</label>
            <input type="text" id="categoryName" name="categoryName" required>

           <label for="categoryPath">Percorso Categoria:</label>
            <input type="text" id="categoryPath" name="categoryPath" required>

            <button type="submit" id="submitBtn">Aggiungi Categoria</button>
        </form>
    </div>
</div>
