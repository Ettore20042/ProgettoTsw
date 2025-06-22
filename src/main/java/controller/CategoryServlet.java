package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Category;
import model.Bean.Image;
import model.Bean.Product;
import model.DAO.CategoryDAO;
import model.DAO.ImageDAO;
import model.DAO.ProductDAO;
import service.CategoryService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@WebServlet(name = "CategoryServlet", value = "/CategoryServlet", loadOnStartup = 1)
public class CategoryServlet extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        ServletContext context = getServletContext();
        CategoryService categoryService = new CategoryService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = getServletContext();
        CategoryService.checkCategoryCache(context);
        Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) context.getAttribute("categoryCacheMap");
        request.setAttribute("categoryCacheMap", categoryCacheMap);
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = new ArrayList<>();
        products = productDAO.doretrieveAll();
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/products/CategoryList.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);  // Reindirizza le richieste POST al metodo GET
    }
}
