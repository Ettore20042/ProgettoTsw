<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="manage-components-container-right--modal" id="productModal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2>Aggiungi un prodotto</h2>
    <form id="addProductForm" action="${pageContext.request.contextPath}/AddProductServlet" method="post" enctype="multipart/form-data">
      <label for="productName">Nome Prodotto:</label>
      <input type="text" id="productName" name="productName" required>

      <label for="price">Prezzo:</label>
      <input type="number" id="price" name="price" step="0.01" required>

      <label for="salePrice">Prezzo in offerta:</label>
      <input type="number" id="salePrice" name="salePrice" step="0.01">

      <label for="color">Colore:</label>
      <input type="text" id="color" name="color">

      <label for="description">Descrizione:</label>
      <textarea id="description" name="description" rows="4" cols="50"></textarea>

      <label for="quantity">Quantità:</label>
      <input type="number" id="quantity" name="quantity" required>

      <label for="material">Materiale:</label>
      <input type="text" id="material" name="material" placeholder="Materiale del prodotto">

      <label for="image1">Immagine di copertina:</label>
      <input type="file" id="image1" name="image1" accept="image/*">

      <label for="images">Altre immagini:</label>
      <input type="file" id="images" name="images" accept="image/*" required multiple>

      <label for="descriptionImage">Descrizione Immagine:</label>
      <input type="text" id="descriptionImage" name="descriptionImage" placeholder="Descrizione dell'immagine">

      <label for="category">Categoria:</label>
      <select id="category" name="category" required>
        <option value="">Seleziona una categoria</option>
        <c:forEach var="entry" items="${categoryCacheMap}">
          <option value="${entry.key}">${entry.value.categoryName}</option>
        </c:forEach>
      </select>

      <label for="brand">Marca:</label>
      <select id="brand" name="brand" required>
        <option value="">Seleziona una marca</option>
        <c:forEach var="entry" items="${brandCacheMap}">
          <option value="${entry.key}">${entry.value.brandName}</option>
        </c:forEach>
      </select>

      <button type="submit">Aggiungi Prodotto</button>
    </form>
  </div>
</div>