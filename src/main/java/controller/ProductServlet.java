package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ProductServlet", value = "/ProductServlet",loadOnStartup = 1)
public class ProductServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
        ProductDAO service = new ProductDAO();
        // Salva i prodotti nell'application scope invece che nella request
        getServletContext().setAttribute("products", service.doRetrieveFirstNProducts(10));
        System.out.println("Prodotti caricati nell'application scope durante l'inizializzazione della servlet");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/HomePage.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }

}
