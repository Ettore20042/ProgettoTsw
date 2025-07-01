package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Product;
import service.BrandService;
import service.FilterService;
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "FilterServlet", value = "/FilterServlet")
public class FilterServlet extends HttpServlet {

    private ProductService productService;
    private BrandService brandService;
    private FilterService filterService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
        this.brandService = new BrandService(context);
        this.filterService = new FilterService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String categoryIdStr = request.getParameter("categoryId");
        String[] brandIdParams = request.getParameterValues("brandId");
        String[] colorParams = request.getParameterValues("color");
        String[] materialParams = request.getParameterValues("material");
        Map<String, Object> filterData = null;
        List<Product> productFilteredList = null;
        Gson gson = new Gson();
        String json = null;




        try {
            Integer categoryId = null;
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID format");
                    return;
                }
            }

            if ("loadData".equals(action)) {

                // Carica i dati iniziali per i filtri
                filterData = filterService.loadFilterData(categoryId);
                json = gson.toJson(filterData);
            } else {

                Float minPrice = null;
                Float maxPrice = null;
                try {
                    if (request.getParameter("minPrice") != null && !request.getParameter("minPrice").isBlank()
                            && request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isBlank()) {
                        minPrice = Float.parseFloat(request.getParameter("minPrice"));
                        maxPrice = Float.parseFloat(request.getParameter("maxPrice"));
                    }
                } catch (NumberFormatException e){
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid price format");
                    return;
                }

                // Filtra i prodotti (comportamento originale)
                productFilteredList = filterService.getFilteredProducts(categoryId, brandIdParams, colorParams, materialParams, minPrice, maxPrice);
                json = gson.toJson(productFilteredList);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }



        // Restituisci i dati come JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
