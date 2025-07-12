package controller.products;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Category;
import model.Bean.Product;
import service.CategoryService;
import service.ProductService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CategoryServlet", value = "/CategoryServlet", loadOnStartup = 1)
public class CategoryServlet extends HttpServlet {

    private CategoryService categoryService;
    private ProductService productService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = getServletContext();
        this.categoryService = new CategoryService(context);
        this.productService = new ProductService(context);
        categoryService.checkCategoryCache();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        categoryService.checkCategoryCache();

        // Passa la mappa delle categorie alla JSP
        Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) getServletContext().getAttribute("categoryCacheMap");
        request.setAttribute("categoryCacheMap", categoryCacheMap);

        List<Product> products = productService.getFirstNProducts(10);
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
