package controller;

//import com.google.gson.Gson;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import model.Bean.Product;
//import model.DAO.ProductDAO;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet(name = "SearchBarServlet", value = "/SearchBarServlet")
//public class SearchBarServlet extends HttpServlet {
//    private Gson gson = new Gson();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        doPost(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // nel metodo doPost:
//        String query = request.getParameter("query");
//        List<Product> prodotti = new ProductDAO().searchProductsByName(query);
//
//// Conversione in JSON:
//        String json = new Gson().toJson(prodotti);
//
//// Risposta:
//        response.setContentType("application/json");
//        response.setCharacterEncoding("UTF-8");
//        response.getWriter().write(json);
//    }
//}