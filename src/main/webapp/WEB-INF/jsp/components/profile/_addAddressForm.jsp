<c:taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" />
<c:taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Modal per aggiungere indirizzo -->
<div class="manage-components-container-right--modal" id="addressModal">
  <div class="modal-content">
    <span class="close" id="close-address-modal">&times;</span>
    <h2 id="addressModalTitle">Aggiungi un indirizzo</h2>
    <form id="addAddressForm" method="post">
      <label for="addressType">Tipo indirizzo:</label>
      <div class="address-type-container">
        <input type="radio" id="shipping" name="addressType" value="shipping" required>
        <label for="shipping">Spedizione</label>

        <input type="radio" id="billing" name="addressType" value="billing" required>
        <label for="billing">Fatturazione</label>
      </div>

      <label for="street">Via:</label>
      <input type="text" id="street" name="street" required>

      <label for="streetNumber">Numero civico:</label>
      <input type="text" id="streetNumber" name="streetNumber" required>

      <label for="city">Città:</label>
      <input type="text" id="city" name="city" required>

      <label for="zipCode">CAP:</label>
      <input type="text" id="zipCode" name="zipCode" pattern="[0-9]{5}" maxlength="5" required>

      <label for="province">Provincia:</label>
      <input type="text" id="province" name="province" maxlength="2" required>

      <label for="country">Paese:</label>
      <input type="text" id="country" name="country" required>

      <input type="hidden" id="addressId" name="addressId">
      <button type="submit" id="submitAddressBtn">Aggiungi Indirizzo</button>
    </form>
  </div>
</div>