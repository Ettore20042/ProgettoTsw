package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Product;
import model.Bean.User;
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
        String idParam = request.getParameter("productId");
        ProductDAO service = new ProductDAO();
        RequestDispatcher rd = request.getRequestDispatcher("/jsp/Product.jsp");

        if(idParam != null) {
            try{
                int id = Integer.parseInt(idParam);
                Product product = service.doRetrieveById(id);
//              User loggedUser = (User) request.getSession().getAttribute("user");
                if(product != null) {
                    request.setAttribute("product", product);
                    rd.forward(request, response);
                }else{
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Prodotto non trovato");
                }
            }catch (NumberFormatException e){
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID non valido");
            }
        }else{
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametro 'productId' mancante");
        }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }

}
