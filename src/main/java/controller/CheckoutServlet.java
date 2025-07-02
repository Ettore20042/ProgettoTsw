package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.CartItem;
import model.Bean.Product;
import service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutServlet", value = "/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        System.out.println("Product ID: " + productId);
        String quantity = request.getParameter("quantitySelected");
        System.out.println("Quantity: " + quantity);

        // Validate parameters
        if (productId == null || quantity == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        try {
            ProductService productService = new ProductService(getServletContext());
            Product product = productService.getProductById(Integer.parseInt(productId));

            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }

            int qty = Integer.parseInt(quantity);
            if (qty <= 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity");
                return;
            }

            double total = product.getPrice() * qty;
            System.out.println("Product ID: " + productId);
            System.out.println("Quantity: " + quantity);
            System.out.println("Total: " + total);

            request.setAttribute("productId", productId);
            request.setAttribute("quantity", quantity);
            request.setAttribute("total", total);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/profile/Checkout.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.sendRedirect(request.getContextPath() + "/jsp/profile/Checkout.jsp");
       HttpSession session = request.getSession();
       List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
       double total = 0.0;
       request.setAttribute("cart", cart);
       for(CartItem item : cart) {
              total += item.getPrice() * item.getQuantity();
       }
       request.setAttribute("total", total);
       RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/profile/Checkout.jsp");
       dispatcher.forward(request, response);

    }
} 
