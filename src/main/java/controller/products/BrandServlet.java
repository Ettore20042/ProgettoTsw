package controller.products;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Brand;
import service.BrandService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BrandServlet", value = "/BrandServlet", loadOnStartup = 1)
public class BrandServlet extends HttpServlet {

    private BrandService brandService;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = getServletContext();
        this.brandService = new BrandService(context);
        // Inizializza la cache dei brand all'avvio
        this.brandService.checkBrandCache();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Controlla se la cache deve essere aggiornata
        this.brandService.checkBrandCache();
        // Recupera i brand tramite il service
        List<Brand> brands = this.brandService.getAllBrands();
        request.setAttribute("brands", brands);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/products/Brand.jsp");

        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);  // Reindirizza le richieste POST al metodo GET
    }
}
