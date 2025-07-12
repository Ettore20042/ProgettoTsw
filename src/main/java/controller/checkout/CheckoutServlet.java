package controller.checkout;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.*;
import service.ProductService;
import service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutServlet", value = "/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    @Override/* Si occupa dell'acquista ora*/
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantitySelected");



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


            request.setAttribute("productId", productId);
            request.setAttribute("quantity", quantity);
            request.setAttribute("total", total);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/cart/Checkout.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
        }
    }

    @Override /*Acquista tramite il carrello */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gestisci il checkout dal carrello
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(getServletContext().getContextPath() + "/LoginServlet");
            return;
        }
        int userid = user.getUserId();
        System.out.println("User ID: " + userid);

        if (cart == null || cart.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cart is empty");
            return;
        }

        double total = 0.0;
        for(CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }
        UserService userService = new UserService(getServletContext());
        List<UserAddress> addresses=userService.getUserAddresses(userid);




        request.setAttribute("addresses", addresses);
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/cart/Checkout.jsp");
        dispatcher.forward(request, response);
    }
}

