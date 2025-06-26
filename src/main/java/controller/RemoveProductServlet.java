package controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.ImageService;
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "RemoveProductServlet", value = "/RemoveProductServlet")
public class RemoveProductServlet extends HttpServlet {

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseMap = new HashMap<>();

        try {
            String productIdParam = request.getParameter("productId");

            if (productIdParam == null || productIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Product ID parameter is missing or empty");
            }

            int productId = Integer.parseInt(productIdParam.trim());
            ServletContext context = getServletContext();
            ProductService productService = new ProductService(context);

            // Rimuovi prima le immagini associate
            boolean imagesRemoved = ImageService.removeProductImages(context, productId);

            if (imagesRemoved) {
                boolean productRemoved = productService.removeProduct(productId);
                responseMap.put("success", productRemoved);
                responseMap.put("message", productRemoved ?
                        "Product removed successfully" : "Product not found");
            } else {
                responseMap.put("success", false);
                responseMap.put("message", "Failed to remove product images");
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            responseMap.put("success", false);
            responseMap.put("message", "Invalid product ID format");

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseMap.put("success", false);
            responseMap.put("message", "Internal server error");
        }

        try (PrintWriter out = response.getWriter()) {
            Gson gson = new Gson();
            out.print(gson.toJson(responseMap));
            out.flush();
        }
    }
}