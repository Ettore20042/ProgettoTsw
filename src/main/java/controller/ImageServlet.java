package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Image;
import model.DAO.ImageDAO;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ImageServlet", value = "/ImageServlet", loadOnStartup = 1)
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "productId mancante");
            return;
        }

        ImageDAO dao = new ImageDAO();
        List<Image> images = dao.doRetrieveByProductId(productIdParam);

        if (images.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Nessuna immagine trovata");
            return;
        }

        // Get the actual path without forcing /images/ directory
        String imagePath = images.get(0).getImagePath();

        // Make sure path starts with /
        String fullPath = imagePath.startsWith("/") ? imagePath : "/" + imagePath;

        // Debug
        System.out.println("Looking for image at: " + fullPath);

        // Determine content type based on file extension
        String contentType = "image/jpeg"; // Default
        if (imagePath.endsWith(".png")) contentType = "image/png";
        else if (imagePath.endsWith(".webp")) contentType = "image/webp";
        else if (imagePath.endsWith(".gif")) contentType = "image/gif";

        // Get the ServletContext to access resources
        ServletContext context = getServletContext();
        InputStream is = context.getResourceAsStream(fullPath);

        if (is == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File immagine non trovato: " + fullPath);
            return;
        }

        response.setContentType(contentType);

        // Copy from input stream to output stream
        try (InputStream inputStream = is;
             OutputStream outputStream = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
}