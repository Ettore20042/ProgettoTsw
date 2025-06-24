package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Category;
import model.DAO.ImageDAO;
import model.DAO.ProductDAO;
import service.CategoryService;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddProductServlet", value = "/AddProductServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 1. Read parameters
            String productName = request.getParameter("productName");
            String priceStr = request.getParameter("price");
            String salePriceStr = request.getParameter("salePrice");
            String productDescription = request.getParameter("description");
            String productCategory = request.getParameter("category");
            String imageDescription = request.getParameter("imageDescription");
            String productQuantity = request.getParameter("quantity");
            String productBrand = request.getParameter("brand");
            String productColor = request.getParameter("color");

            // Validate required parameters
            if (productName == null || productName.trim().isEmpty()) {
                throw new IllegalArgumentException("Nome prodotto obbligatorio");
            }
            if (priceStr == null || priceStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Prezzo obbligatorio");
            }
            if (productCategory == null || productCategory.trim().isEmpty()) {
                throw new IllegalArgumentException("Categoria obbligatoria");
            }

            // 2. Convert numbers with validation
            double productPrice;
            double productDiscount = 0.0;
            int categoryId;

            try {
                productPrice = Double.parseDouble(priceStr);
                if (productPrice < 0) {
                    throw new IllegalArgumentException("Il prezzo non può essere negativo");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Prezzo non valido: " + priceStr);
            }

            try {
                if (salePriceStr != null && !salePriceStr.trim().isEmpty()) {
                    productDiscount = Double.parseDouble(salePriceStr);
                    if (productDiscount < 0) {
                        throw new IllegalArgumentException("Il prezzo scontato non può essere negativo");
                    }
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Prezzo scontato non valido: " + salePriceStr);
            }

            try {
                categoryId = Integer.parseInt(productCategory);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("ID categoria non valido: " + productCategory);
            }

            // 3. Save product
            ProductDAO dao = new ProductDAO();
            int productId = dao.addProduct(productName, productPrice, productDiscount,
                    productDescription, productCategory, productQuantity,
                    productBrand, productColor);

            if (productId <= 0) {
                throw new RuntimeException("Errore nel salvare il prodotto nel database");
            }

            // 4. Handle image path
            Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) getServletContext().getAttribute("categoryCacheMap");

            String dynamicUploadDir;
            if (categoryCacheMap != null) {
                List<Category> breadcrumb = CategoryService.buildBreadcrumbFromMap(categoryCacheMap, categoryId);
                dynamicUploadDir = buildUploadPath(breadcrumb);
            } else {
                dynamicUploadDir = "img" + File.separator + "categories" + File.separator + "default";
            }

            // 5. Create directory
            String uploadPath = getServletContext().getRealPath("") + File.separator + dynamicUploadDir;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                if (!created) {
                    throw new RuntimeException("Impossibile creare la directory di upload: " + uploadPath);
                }
            }

            // 6. Handle images
            Collection<Part> parts = request.getParts();
            ImageDAO imageDAO = new ImageDAO();
            int uploadedImages = 1;

            for (Part part : parts) {
                String fileName = part.getSubmittedFileName();

                // Check if this is the images part AND has actual content
                if ("images".equals(part.getName()) && part.getSize() > 0) {
                    // Additional validation for image files
                    if (fileName != null && !fileName.isEmpty()) {
                        // Check file extension for image types
                        String lowerFileName = fileName.toLowerCase();
                        if (isValidImageFile(lowerFileName)) {
                            // Generate new filename
                            String cleanProductName = productName.replaceAll("[^a-zA-Z0-9]", "_");
                            String newFileName = cleanProductName + "_" + productId + "_" + (uploadedImages + 1) + getFileExtension(fileName);

                            String filePath = uploadPath + File.separator + newFileName;

                            try {
                                // Save the file
                                part.write(filePath);

                                // Verify file was actually written
                                File savedFile = new File(filePath);
                                if (savedFile.exists() && savedFile.length() > 0) {
                                    // Save to database
                                    String relativePath = dynamicUploadDir.replace(File.separator, "/") + "/" + newFileName;
                                    boolean dbResult = imageDAO.addImage(productId, relativePath, imageDescription, uploadedImages);

                                    if (dbResult) {
                                        uploadedImages++;
                                    } else {
                                        // Delete physical file if DB fails
                                        savedFile.delete();
                                    }
                                }
                            } catch (Exception e) {
                                throw new RuntimeException("Errore nel salvare l'immagine: " + e.getMessage(), e);
                            }
                        }
                    }
                }
            }

            // Nel tuo servlet, modifica le sezioni di risposta così:

// 7. Success response - AGGIUNGI HEADERS
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Cache-Control", "no-cache");

            String jsonResponse = String.format(
                    "{\"success\": true, \"productId\": %d, \"imagesUploaded\": %d, \"message\": \"Prodotto salvato con successo\"}",
                    productId, uploadedImages
            );

// IMPORTANTE: Usa PrintWriter correttamente
            try (PrintWriter out = response.getWriter()) {
                out.print(jsonResponse);
                out.flush();
            }

// Stesso fix per gli errori
        } catch (IllegalArgumentException e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

            String errorResponse = String.format(
                    "{\"success\": false, \"message\": \"Errore di validazione: %s\"}",
                    e.getMessage().replace("\"", "\\\"")
            );

            try (PrintWriter out = response.getWriter()) {
                out.print(errorResponse);
                out.flush();
            }

        } catch (Exception e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            String errorResponse = String.format(
                    "{\"success\": false, \"message\": \"Errore interno del server: %s\"}",
                    e.getMessage().replace("\"", "\\\"")
            );

            try (PrintWriter out = response.getWriter()) {
                out.print(errorResponse);
                out.flush();
            }
        }
    }

    /**
     * Costruisce il percorso di upload basato sulla categoria
     */
    private String buildUploadPath(List<Category> breadcrumb) {
        StringBuilder path = new StringBuilder("uploads" + File.separator + "products");

        for (Category category : breadcrumb) {
            String categoryName = category.getCategoryName()
                    .toLowerCase()
                    .replaceAll("[^a-z0-9]", "_")
                    .replaceAll("_+", "_"); // Remove multiple underscores
            path.append(File.separator).append(categoryName);
        }

        return path.toString();
    }

    /**
     * Verifica se il file è un'immagine supportata
     */
    private boolean isValidImageFile(String fileName) {
        return fileName.endsWith(".jpg") ||
                fileName.endsWith(".jpeg") ||
                fileName.endsWith(".png") ||
                fileName.endsWith(".gif") ||
                fileName.endsWith(".webp") ||
                fileName.endsWith(".bmp") ||
                fileName.endsWith(".svg");
    }

    /**
     * Ottiene l'estensione del file
     */
    private String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0 && lastDot < fileName.length() - 1) {
            return fileName.substring(lastDot);
        }
        return ".jpg"; // Default extension
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String errorResponse = "{\"success\": false, \"message\": \"Metodo GET non supportato. Utilizzare POST.\"}";
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.getWriter().write(errorResponse);
    }
}