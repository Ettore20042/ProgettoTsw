package controller;

import jakarta.servlet.RequestDispatcher;
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
import java.util.List;

@WebServlet(name = "ManageServlet", value = "/ManageServlet")
public class ManageServlet extends HttpServlet {

    private ProductService productService;
    // private UserService userService; // Futuri service per altre entità
    // private CategoryService categoryService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
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
            /*
            case "users":
                // Qui andrà la logica per gestire gli utenti
                // List<User> userList = userService.searchUsers(searchQuery);
                // request.setAttribute("itemList", userList);
                break;
            case "categories":
                // Qui andrà la logica per le categorie
                break;
            */
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
}

