package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Brand;
import model.DAO.BrandDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BrandServlet", value = "/BrandServlet")
public class BrandServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        BrandDAO brandDAO = new BrandDAO();
        List<Brand> brands = brandDAO.doRetrieveAll();
        request.setAttribute("brands", brands);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/products/Brand.jsp");

        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);  // Reindirizza le richieste POST al metodo GET
    }
}
