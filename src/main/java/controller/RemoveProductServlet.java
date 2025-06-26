package controller;


import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "RemoveProductServlet", value = "/RemoveProductServlet")
public class RemoveProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }
    @Override
    public void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String pathInfo = request.getPathInfo();
        boolean success = false;
        if (pathInfo == null || pathInfo.isEmpty()) {
           try{
               int productId = Integer.parseInt(request.getParameter("productId"));
               ProductService productService = new ProductService(getServletContext());
               success = productService.removeProduct(productId);
           }catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Invalid request\"}");
            }
           Map<String, Object> responseMap = new HashMap<>();
           responseMap.put("success", success);

           PrintWriter out = response.getWriter();
              out.write(new Gson().toJson(responseMap));
              out.flush();


        }
    }
} 
