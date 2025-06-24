package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.util.Collection;

@WebServlet(name = "AddProductServlet", value = "/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String productName = request.getParameter("productName");
        double productPrice = Double.parseDouble(request.getParameter("price"));
        double productDiscount = Double.parseDouble(request.getParameter("salePrice"));
        String productDescription = request.getParameter("description");
        String productCategory = request.getParameter("category");

        String productQuantity = request.getParameter("quantity");
        String productBrand = request.getParameter("brand");
        String productColor = request.getParameter("color");

        ProductDAO dao = new ProductDAO();
        int idproduct=dao.addProduct(productName, productPrice, productDiscount, productDescription, productCategory, productQuantity, productBrand, productColor);
        
        Collection<Part> parts = request.getParts();

    }
} 
