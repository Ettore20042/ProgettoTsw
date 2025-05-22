package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Brand;
import model.Bean.Image;
import model.Bean.Product;
import model.Bean.User;
import model.DAO.BrandDAO;
import model.DAO.ImageDAO;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
//        String idParam = request.getParameter("productId");  commentato per implementare e provare la pagina product.jsp
        String idParam = "4"; // Simulazione di un ID prodotto per il test
        ProductDAO service = new ProductDAO();
        RequestDispatcher rd = request.getRequestDispatcher("/jsp/products/Product.jsp");

        if(idParam != null) {
            try{
                int id = Integer.parseInt(idParam);
                Product product = service.doRetrieveById(id);
                if(product != null) {
                    ImageDAO imageDAO = new ImageDAO();
                    BrandDAO brandDAO = new BrandDAO();
                    Brand brand = brandDAO.doRetrieveById(product.getBrandId());
                    List<Image> images = imageDAO.doRetrieveById(id);
                    request.setAttribute("product", product);
                    request.setAttribute("productImages", images);
                    request.setAttribute("productBrand", brand);
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
