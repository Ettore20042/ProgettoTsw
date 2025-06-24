package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Product;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageProductServlet", value = "/ManageProductServlet")
public class ManageProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
        String searchQueryTable = request.getParameter("searchQueryTable");
        ProductDAO productDAO = new ProductDAO();
        RequestDispatcher dispatcher;

        List<Product> productList = productDAO.findByNameLike(searchQueryTable);
        request.setAttribute("productList", productList);
        dispatcher = request.getRequestDispatcher("jsp/profile/ManageProducts.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

