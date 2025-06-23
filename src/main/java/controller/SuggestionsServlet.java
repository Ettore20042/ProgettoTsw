package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;
import model.DAO.ProductDAO;

@WebServlet("/SuggestionsServlet")
public class SuggestionsServlet extends HttpServlet {

    private ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("searchQuery");

        if (query == null) query = "";

        List<String> results = dao.searchProductsByName(query);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = new Gson().toJson(results);

        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();


    }
}
