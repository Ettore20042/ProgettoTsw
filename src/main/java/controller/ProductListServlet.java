package controller;


import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Category;
import model.Bean.Product;
import model.DAO.CategoryDAO;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.io.PrintWriter;
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
        String filterParam = request.getParameter("filter");

        ProductDAO productDAO = new ProductDAO();
        RequestDispatcher dispatcher;

        if (filterParam != null && filterParam.equalsIgnoreCase("true")) {
            Float minPrice = null;
            Float maxPrice = null;
            String color = request.getParameter("color");
            String material = request.getParameter("material");
            try {

                if (request.getParameter("minPrice") != null && !request.getParameter("minPrice").isBlank()
                    && request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isBlank()) {
                    minPrice = Float.parseFloat(request.getParameter("minPrice"));
                    maxPrice = Float.parseFloat(request.getParameter("maxPrice"));
                }
            } catch (Exception e){
                NumberFormatException nfe = new NumberFormatException("Invalid price format");
            }
            List<Product> productList = productDAO.doRetrieveByFilter(
                     brandIdParam, color, material, minPrice, maxPrice);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            String json = new Gson().toJson(productList);

            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
        }

        ServletContext context = getServletContext();
        CategoryServlet.checkCategoryCache(context);
        Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) context.getAttribute("categoryCacheMap");
        request.setAttribute("categoryCacheMap", categoryCacheMap);

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

            if(offersParam != null && offersParam.equals("true")){
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
        doGet(request, response);
    }
} 
