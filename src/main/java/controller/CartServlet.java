package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.CartItem;
import model.Bean.Product;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartServlet", value = "/CartServlet")
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to cart page if accessed directly
        response.sendRedirect("WEB-INF/jsp/cart/Cart.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productIdParam = request.getParameter("productId");
            String quantityParam = request.getParameter("quantity");
            String updateParam = request.getParameter("update");
            boolean isUpdate = updateParam != null && updateParam.equalsIgnoreCase("true");
            int lastQuantity = 0;

            if (productIdParam == null || quantityParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);

            if (quantity <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity must be positive");
                return;
            }

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean found = false;
            for (CartItem item : cart) { // Itera sugli elementi del carrello e cerca il prodotto
                if (item.getProductId() == productId) {
                    if (isUpdate) { //Se il prodotto è già presente sovrascrive la quantità
                        lastQuantity = item.getQuantity(); // Salva la nuova quantità per l'eventuale risposta
                        item.setQuantity(quantity); // aggiornamento diretto
                    } else { //Se il prodotto non c'è lo aggiunge
                        item.setQuantity(item.getQuantity() + quantity); //  aggiunta
                    }
                    found = true;

                    break;
                }
            }

            if (!found) { //Se il prodotto esiste crea un nuovo oggetto CartItem e lo aggiunge al carrello
                ProductDAO productDAO = new ProductDAO();
                try {
                    Product product = productDAO.doRetrieveById(productId);
                    if (product == null) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                        return;
                    }
                    CartItem newItem = new CartItem(product.getProductId(), product.getProductName(), product.getPrice(), quantity);
                    cart.add(newItem);
                } finally {

                }
            }
            int totalItems = cart.stream().mapToInt(CartItem::getQuantity).sum();
            session.setAttribute("cart", cart);
            session.setAttribute("totalItemsCart", totalItems);


            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{" +
                    "\"status\":\"ok\"," +
                    "\"lastQuantity\":" + lastQuantity +
                    "}");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or quantity");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }
}