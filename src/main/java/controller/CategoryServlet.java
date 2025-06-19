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
import java.util.List;

@WebServlet(name = "CategoryServlet", value = "/CategoryServlet")
public class CategoryServlet extends HttpServlet {

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
