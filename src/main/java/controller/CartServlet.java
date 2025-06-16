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
        response.sendRedirect("jsp/profile/Cart.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String productIdParam = request.getParameter("productId");
            String quantityParam = request.getParameter("quantity");
            String updateParam = request.getParameter("update");
            boolean isUpdate = updateParam != null && updateParam.equalsIgnoreCase("true");

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
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    if (isUpdate) {
                        item.setQuantity(quantity); // ✅ aggiornamento diretto
                    } else {
                        item.setQuantity(item.getQuantity() + quantity); // ➕ aggiunta
                    }
                    found = true;
                    break;
                }
            }

            if (!found) {
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
                    // Close DAO resources if needed
                }
            }

            session.setAttribute("cart", cart);

            // Check if it's an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);

            if (isAjaxRequest) {
                // For AJAX requests, send simple response
                response.setContentType("text/plain");
                response.getWriter().write("ok");
            } else {
                // For regular form submissions, redirect
                response.sendRedirect("jsp/profile/Cart.jsp");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or quantity");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }
}