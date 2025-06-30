package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Brand;
import model.Bean.Category;
import model.Bean.Product;
import model.Bean.User;
import service.BrandService;
import service.CategoryService;
import service.ProductService;
import service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageServlet", value = "/ManageServlet")
public class ManageServlet extends HttpServlet {

    private ProductService productService;
    private UserService userService; // Futuri service per altre entità
    private BrandService brandService; // Servizio per gestire i brand
    private CategoryService categoryService; // Servizio per gestire le categorie
    // private CategoryService categoryService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
        this.userService = new UserService(context);
        this.brandService = new BrandService(context); // Inizializza il servizio Brand
        this.categoryService = new CategoryService(context); // Inizializza il servizio Category
        // Inizializza gli altri service qui quando verranno creati
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String entity = request.getParameter("entity");
        String searchQuery = request.getParameter("searchQuery");
        String forwardPage = "/jsp/admin/Manage.jsp"; // Per ora punta alla vecchia JSP

        if (entity == null || entity.trim().isEmpty()) {
            entity = "products"; // Imposta "products" come default se non specificato
        }

        // Lo switch ci permette di estendere facilmente la logica per altre entità
        switch (entity) {
            case "products":
                List<Product> productList;
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    productList = productService.searchProducts(searchQuery);
                } else {
                    // Se non c'è una ricerca, mostra tutti i prodotti
                    productList = productService.getAllProducts();
                }
                request.setAttribute("itemList", productList);
                break;

            case "users":
                List<User> userList;
                if(searchQuery != null && !searchQuery.trim().isEmpty()) {
                    userList = userService.searchUsers(searchQuery);
                }else{
                    userList = userService.getAllUsers();
                }

                request.setAttribute("itemList", userList);
                break;
            case  "brands":
                List<Brand> brandList;
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    brandList = brandService.searchBrands(searchQuery);
                } else {
                    brandList = brandService.getAllBrands();
                }
                request.setAttribute("itemList", brandList);
                break;

            case "categories":
                List<Category> categoryList;

                if(searchQuery != null && !searchQuery.trim().isEmpty()){
                    categoryList = categoryService.searchCategories(searchQuery);
                }else{
                    categoryList = categoryService.getAllCategories();
                }

                request.setAttribute("itemList", categoryList);
                break;

            default:
                // In caso di entità non riconosciuta, imposta una lista vuota
                request.setAttribute("itemList", List.of());
                break;
        }

        // Passiamo alla JSP sia la lista di item che il tipo di entità che stiamo gestendo
        request.setAttribute("entity", entity);
        RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPage);
        dispatcher.forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
