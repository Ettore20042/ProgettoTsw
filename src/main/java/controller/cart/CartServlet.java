package controller.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.CartItem;
import service.CartService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", value = "/CartServlet")
public class CartServlet extends HttpServlet {

    private CartService cartService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.cartService = new CartService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String productIdParam = request.getParameter("productId");

            if (productIdParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"error\": \"Missing product ID\"}");
                return;
            }

            int productId = Integer.parseInt(productIdParam);

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"error\": \"Cart is empty\"}");
                return;
            }

            // Utilizza il service per rimuovere dal carrello
            List<CartItem> updatedCart = cartService.removeFromCart(cart, productId);

            int totalItems = cartService.calculateTotalItems(updatedCart);
            session.setAttribute("cart", updatedCart);
            session.setAttribute("totalItemsCart", totalItems);

            String xRequestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(xRequestedWith)) {
                response.getWriter().write("{\"success\": true}");
            } else {
                // Regular form submission - redirect
                response.sendRedirect(request.getContextPath() + "/jsp/cart/Cart.jsp");
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"error\": \"Invalid product ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"error\": \"Error processing request\"}");
        }
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

            // Salva la quantità precedente se necessario per la risposta
            if (isUpdate) {
                lastQuantity = cartService.getLastQuantity(cart, productId);
            }

            // Utilizza il service per aggiungere/aggiornare il carrello
            List<CartItem> updatedCart = cartService.addOrUpdateCartItem(cart, productId, quantity, isUpdate);

            if (updatedCart == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }

            int totalItems = cartService.calculateTotalItems(updatedCart);
            session.setAttribute("cart", updatedCart);
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
