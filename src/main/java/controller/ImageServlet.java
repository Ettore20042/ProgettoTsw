package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Image;
import model.DAO.ImageDAO;

import java.io.IOException;

@WebServlet(name = "ImageServlet", value = "/ImageServlet", loadOnStartup = 1)
public class ImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ottiene il parametro productId dalla richiesta
        String productIdParam = request.getParameter("productId");

        // Verifica che il parametro sia presente e non vuoto
        if (productIdParam == null || productIdParam.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parametro 'productId' mancante");
            return;
        }

//        try {
//            // Converte il productId in intero
//            int id = Integer.parseInt(productIdParam);
//            ImageDAO service = new ImageDAO();
//
//            // Recupera l'immagine dal database utilizzando l'ID
//            Image image = service.doRetrieveById(id);
//
//            // Verifica che l'immagine esista
//            if (image == null) {
//                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Immagine non trovata");
//                return;
//            }
//
//            // Il percorso deve essere accessibile direttamente dal browser
//            String imageUrl = request.getContextPath() + image.getImagePath();
//
//            // Reindirizza il browser all'URL dell'immagine
//            response.sendRedirect(imageUrl);
//
//        } catch (NumberFormatException e) {
//            // Gestisce il caso in cui l'ID non sia un numero valido
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID non valido");
//        }
    }
}