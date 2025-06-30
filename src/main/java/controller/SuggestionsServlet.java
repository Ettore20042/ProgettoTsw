package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.CategoryService;
import service.ProductService;
import service.UserService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SuggestionsServlet")
public class SuggestionsServlet extends HttpServlet {

    private ProductService productService;
    private UserService userService;
    private CategoryService categoryService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
        this.userService = new UserService(context);
        this.categoryService = new CategoryService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String entity = request.getParameter("entity");
        String query = request.getParameter("query");
        List<String> results = new ArrayList<>();

        if (entity != null && query != null && !query.trim().isEmpty()) {
            switch (entity) {
                case "products":
                    results = productService.getSearchSuggestions(query);
                    break;

                case "users":
                    results = userService.getUserEmails(query);
                    break;

                case "categories":
                    results = categoryService.getSearchSuggestions(query);
                    break;
                // Altri casi per altre entità da fare, tipo "Users" "categories" o "brands"
            }
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String json = new Gson().toJson(results);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
