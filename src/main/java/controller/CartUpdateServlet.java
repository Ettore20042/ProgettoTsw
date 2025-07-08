package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.CartItem;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartUpdateServlet", urlPatterns = {"/cart-update"})
public class CartUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.out.println("CartUpdateServlet: Processing request to update or remove cart item");
        String productIdParam = request.getParameter("productId");
        String action = request.getParameter("action");
        String quantityParam = request.getParameter("quantity");
        System.out.println("Received parameters: productId=" + productIdParam + ", action=" + action + ", quantity=" + quantityParam);

        if (productIdParam == null) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Missing product ID");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            return;
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Cart is empty");
            return;
        }

        if ("update".equals(action) && quantityParam != null) {
            try {
                int quantity = Integer.parseInt(quantityParam);
                if (quantity < 1) quantity = 1;

                boolean updated = false;
                for (CartItem item : cart) {
                    if (item.getProductId() == productId) {
                        item.setQuantity(quantity);
                        updated = true;
                        break;
                    }
                }

                if (updated) {
                    session.setAttribute("cart", cart);
                    response.getWriter().write("{\"success\": true}");
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Product not found");
                }
            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity");
            }

        } else if ("remove".equals(action)) {
            boolean removed = false;
            for (int i = 0; i < cart.size(); i++) {
                if (cart.get(i).getProductId() == productId) {
                    cart.remove(i);
                    removed = true;
                    break;
                }
            }

            if (removed) {
                session.setAttribute("cart", cart);
                String xRequestedWith = request.getHeader("X-Requested-With");
                if ("XMLHttpRequest".equals(xRequestedWith)) {

                    response.getWriter().write("{\"success\": true}");
                } else {
                    // Regular form submission - redirect
                    response.sendRedirect(request.getContextPath() + "/jsp/profile/Cart.jsp");
                }
            } else {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } else {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing parameters");
        }
    }

    private void sendError(HttpServletResponse response, int statusCode, String message) throws IOException {
        response.setStatus(statusCode);
        response.getWriter().write("{\"success\": false, \"error\": \"" + message + "\"}");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/jsp/profile/Cart.jsp");
    }
}