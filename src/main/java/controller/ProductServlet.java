package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.*;
import service.CategoryService;
import service.ProductService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductServlet", value = "/ProductServlet",loadOnStartup = 1)
public class ProductServlet extends HttpServlet {
    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
        this.categoryService = new CategoryService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("productId");
        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametro 'productId' mancante");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);

            Product product = productService.getFullProductDetails(id);

            if (product != null) {
                categoryService.checkCategoryCache();
                Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) getServletContext().getAttribute("categoryCacheMap");
                List<Category> breadcrumbCategories = categoryService.buildBreadcrumbFromMap(categoryCacheMap, product.getCategoryId());

                request.setAttribute("product", product);
                request.setAttribute("breadcrumbCategories", breadcrumbCategories);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/products/Product.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Prodotto non trovato");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID non valido");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
