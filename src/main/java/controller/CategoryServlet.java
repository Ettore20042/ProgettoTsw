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

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@WebServlet(name = "CategoryServlet", value = "/CategoryServlet", loadOnStartup = 1)
public class CategoryServlet extends HttpServlet {

    private static final long CACHE_EXPIRATION_MS = 60 * 60 * 12 * 1000;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        ServletContext context = getServletContext();
        refreshCategoryCache(context);
    }

    public static void checkCategoryCache(ServletContext context) {
        Long lastUpdate = (Long) context.getAttribute("categoryCacheTimestamp");
        if (lastUpdate == null || System.currentTimeMillis() - lastUpdate > CACHE_EXPIRATION_MS) { // 1 ora
            refreshCategoryCache(context);
        }
    }

    /**
     * Metodo statico e pubblico per caricare o ricaricare la cache delle categorie.
     * Può essere chiamato dall'init() o da qualsiasi altra servlet quando necessario.
     * @param context Il ServletContext in cui memorizzare i dati.
     */
    public static void refreshCategoryCache(ServletContext context) {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> allCategories = categoryDAO.doRetrieveAll();

        Map<Integer, Category> categoryMap = allCategories.stream()
                .collect(Collectors.toMap(Category::getCategoryId, Function.identity()));

        context.setAttribute("categoryCacheMap", categoryMap);
        context.setAttribute("categoryCacheTimestamp", System.currentTimeMillis());
    }

    public static List<Category> buildBreadcrumbFromMap(Map<Integer, Category> categoryMap, int leafCategoryId) {
        List<Category> breadcrumb = new ArrayList<>();
        if (categoryMap == null) return breadcrumb;

        Integer currentId = leafCategoryId;
        while (currentId != null && currentId != 0) {
            Category cat = categoryMap.get(currentId);
            if (cat != null) {
                breadcrumb.add(cat);
                currentId = cat.getParentCategory();
            } else {
                break;
            }
        }
        Collections.reverse(breadcrumb);
        return breadcrumb;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      CategoryDAO categoryDAO = new CategoryDAO();
      List<Category> categories = categoryDAO.doRetrieveAll();
      request.setAttribute("categories", categories);
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
