<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="manage-components-container-right--modal" id="productModal">
    <div class="modal-content">
        <span class="close" id="close-modal">&times;</span>
        <h2 id="modalTitle">Aggiungi un Brand</h2>
        <form id="addBrandForm" action="${pageContext.request.contextPath}/ManageBrandServlet" method="post" enctype="multipart/form-data">
            <label for="brandName">Nome del Brand:</label>
            <input type="text" id="brandName" name="brandName" required>

            <label for="brandPath">Percorso del Brand:</label>
            <input type="text" id="brandPath" name="logoPath" required>


            <button type="submit" id="submitBtn">Aggiungi Brand</button>
        </form>
    </div>
</div>
