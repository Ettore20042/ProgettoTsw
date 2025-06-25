package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Product;
import service.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchBarServlet", value = "/SearchBarServlet")
public class SearchBarServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        List<Product> products;

        if(searchQuery != null && !searchQuery.trim().isEmpty()){
            products = productService.searchProducts(searchQuery);
        } else {
            products = new ArrayList<>();
        }
        request.setAttribute("productList", products);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
        dispatcher.forward(request, response);
    }
}
