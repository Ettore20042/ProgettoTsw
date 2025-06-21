package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Category;
import model.Bean.Product;
import model.DAO.CategoryDAO;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@WebServlet(name = "ProductListServlet", value = "/ProductListServlet")
public class ProductListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String brandIdParam = request.getParameter("brandId");
        String categoryIdParam = request.getParameter("categoryId");
        String offersParam = request.getParameter("offers");
        boolean filterQuery = Boolean.parseBoolean(request.getParameter("filter"));

        ServletContext context = getServletContext();
        CategoryServlet.checkCategoryCache(context);
        Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) context.getAttribute("categoryCacheMap");
        ProductDAO productDAO = new ProductDAO();
        RequestDispatcher dispatcher;


        try{
            if(brandIdParam == null && categoryIdParam == null && offersParam == null){
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            if(brandIdParam != null){
                List<Product> productList = productDAO.doRetrieveByBrandId(Integer.parseInt(brandIdParam));
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            }

            if(categoryIdParam != null){
                List<Product> productList = productDAO.doRetrieveByCategoryId(Integer.parseInt(categoryIdParam));
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            }

            if(offersParam.equals("true")){
                List<Product> productList = productDAO.doRetrieveBySalePrice();
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/Offers.jsp");
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
