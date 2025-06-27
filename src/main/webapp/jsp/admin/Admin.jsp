<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <div id="message" style="display: none"></div>
    <div class="manage-components-container-right--search-table">

        <table class="search-components-on-table--table">
            <thead>
            <tr>
                <th>ID Utente</th>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Email</th>
                <th>Telefono</th>
                <th>Admin</th>
                <th colspan="1"></th>
            </tr>
            </thead>
            <tbody id="componentTableBody">
            <c:forEach var="item" items="${itemList}">
                <tr>
                    <td>${item.userId}</td>
                    <td>${item.firstName}</td>
                    <td>${item.lastName}</td>
                    <td>${item.email}</td>
                    <td>${item.phoneNumber}</td>
                    <c:choose>
                        <c:when test="${item.isAdmin() == true}">
                            <td>SI</td>
                        </c:when>
                        <c:otherwise>
                            <td>NO</td>
                        </c:otherwise>
                    </c:choose>
                    <td><a href="#">Modifica</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
