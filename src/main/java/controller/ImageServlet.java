package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Image;
import model.DAO.ImageDAO;

import java.io.IOException;

@WebServlet(name = "ImageServlet", value = "/ImageServlet",loadOnStartup = 1)
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

        try {
            // Converte il productId in intero
            int id = Integer.parseInt(productIdParam);
            ImageDAO service = new ImageDAO();
            // Recupera l'immagine dal database utilizzando l'ID
            Image image = service.doRetrievebyId(id);

            // Verifica che l'immagine esista
            if (image == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Immagine non trovata");
                return;
            }

            // Ottiene il percorso fisico dell'immagine nel server
            String path = getServletContext().getRealPath(image.getImagePath());
            File file = new File(path);

            // Verifica che il file esista effettivamente nel filesystem
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File immagine non trovato");
                return;
            }

            // Determina il tipo MIME dell'immagine
            String mimeType = getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "application/octet-stream";  // Tipo predefinito se non rilevato
            }

            // Imposta header per la cache lato client (1 giorno)
            response.setHeader("Cache-Control", "max-age=86400");
            // Imposta il tipo di contenuto appropriato
            response.setContentType(mimeType);
            // Imposta la dimensione del contenuto
            response.setContentLengthLong(file.length());

            // Legge il file immagine e lo invia al client
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {
                fis.transferTo(os);  // Trasferisce i byte dal file all'output
            }
        } catch (NumberFormatException e) {
            // Gestisce il caso in cui l'ID non sia un numero valido
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID non valido");
        }
    }

}
