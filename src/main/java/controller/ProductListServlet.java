package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Product;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductListServlet", value = "/ProductListServlet")
public class ProductListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
        String brandIdParam = request.getParameter("brandId");
        String categoryIdParam = request.getParameter("categoryId");
        ProductDAO productDAO = new ProductDAO();
        RequestDispatcher dispatcher;


        try{
            if(brandIdParam == null && categoryIdParam == null){
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            if(brandIdParam != null){
                List<Product> productList = productDAO.doRetrieveByBrandId(Integer.parseInt(brandIdParam));
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            }else if(categoryIdParam != null){
                List<Product> productList = productDAO.doRetrieveByCategoryId(Integer.parseInt(categoryIdParam));
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            }
        }catch (Exception e){
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta

    }
} 
