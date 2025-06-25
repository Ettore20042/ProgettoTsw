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
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "FilterServlet", value = "/FilterServlet")
public class FilterServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryIdParam = request.getParameter("categoryId");
        String brandIdParam = request.getParameter("brandId");
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
        } catch (NumberFormatException e){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid price format");
            return;
        }

        List<Product> productList = productService.getFilteredProducts(
                 categoryIdParam, brandIdParam, color, material, minPrice, maxPrice);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(productList);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}

