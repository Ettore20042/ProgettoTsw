package controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Product;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "SearchBarServlet", value = "/SearchBarServlet")
public class SearchBarServlet extends HttpServlet {


        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String searchQuery = request.getParameter("searchQuery");

            ProductDAO productDAO = new ProductDAO();
            if(searchQuery != null){
                List<Product> products = productDAO.findByNameLike(searchQuery);
                request.setAttribute("productList", products);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            }

        }
    }

