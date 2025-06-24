package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;
import model.DAO.ProductDAO;

@WebServlet("/SuggestionsTableServlet")
public class SuggestionsTableServlet extends HttpServlet {

    private ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String queryTable = request.getParameter("searchQueryTable");

        if (queryTable == null) queryTable = "";

        List<String> results = dao.searchProductsByName(queryTable);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = new Gson().toJson(results);

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();


    }
}

