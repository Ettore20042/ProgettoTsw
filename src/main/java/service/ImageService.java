package service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import model.Bean.Category;
import model.Bean.Image;
import model.Bean.Product;
import model.DAO.ImageDAO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ImageService {

    private final ImageDAO imageDAO;
    private final CategoryService categoryService;
    private final ServletContext context;

    public ImageService(ServletContext context) {
        this.imageDAO = new ImageDAO();
        this.categoryService = new CategoryService(context);
        this.context = context;
    }

    /**
     * Recupera la lista di immagini associate a un prodotto.
     * @param productId l'ID del prodotto.
     * @return una lista di oggetti Image.
     */
    public List<Image> getImagesByProductId(int productId) {
		return imageDAO.doRetrieveAllByProduct(productId);
    }

    /**
     * Recupera la prima immagine associata a un prodotto.
     * @param productId l'ID del prodotto.
     * @return un oggetto Image, o null se non viene trovata nessuna immagine.
     */
    public Image getFirstImageByProductId(int productId) {
        return imageDAO.doRetrieveFirstByProduct(productId);
    }



    public void saveProductImages(List<Part> imageParts, int productId, int categoryId, String productName, String imageDescription) throws IOException {
        if (imageParts == null || imageParts.isEmpty()) {
            return;
        }

        categoryService.checkCategoryCache();
        Map<Integer, Category> categoryMap = (Map<Integer, Category>) context.getAttribute("categoryCacheMap");
        List<Category> breadcrumb = categoryService.buildBreadcrumbFromMap(categoryMap, categoryId);
        String dynamicUploadDir = buildUploadPath(breadcrumb);

        String uploadPath = context.getRealPath("") + File.separator + dynamicUploadDir;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            if (!uploadDir.mkdirs()) {
                throw new IOException("Impossibile creare la directory di upload: " + uploadPath);
            }
        }

        int displayOrder = 1;
        for (Part part : imageParts) {
            String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

            if (originalFileName != null && !originalFileName.isEmpty() && isValidImageFile(originalFileName)) {
                String cleanProductName = productName.replaceAll("[^a-zA-Z0-9]", "_").toLowerCase();
                String newFileName = cleanProductName + "_" + productId + "_" + displayOrder + getFileExtension(originalFileName);

                String filePath = uploadPath + File.separator + newFileName;
                File savedFile = new File(filePath);

                try {
                    // Save the file
                    part.write(filePath);

                    // Verify file was actually written
                    if (savedFile.exists() && savedFile.length() > 0) {
                        // Save to database
                        String relativePath = dynamicUploadDir.replace(File.separator, "/") + "/" + newFileName;
                        boolean dbResult = imageDAO.addImage(productId, relativePath, imageDescription, displayOrder);

                        if (dbResult) {
                            displayOrder++;
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

    private String buildUploadPath(List<Category> breadcrumb) {
        StringBuilder path = new StringBuilder("img" + File.separator + "categories");
        for (Category cat : breadcrumb) {
            path.append(File.separator).append(formatForPath(cat.getCategoryName()));
        }
        return path.toString();
    }

    private String formatForPath(String text) {
        if (text == null) return "";
        return text.trim().toLowerCase().replaceAll("\\s+", "-");
    }

    private boolean isValidImageFile(String fileName) {
        String lowerFileName = fileName.toLowerCase();
        return lowerFileName.endsWith(".jpg") ||
                lowerFileName.endsWith(".jpeg") ||
                lowerFileName.endsWith(".png") ||
                lowerFileName.endsWith(".gif") ||
                lowerFileName.endsWith(".webp") ||
                lowerFileName.endsWith(".svg");
    }

    private String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0 && lastDot < fileName.length() - 1) {
            return fileName.substring(lastDot);
        }
        return ".jpg"; // Default extension
    }
    public static boolean removeProductImages(ServletContext servletContext,int productId) {
        ImageDAO imageDAO = new ImageDAO();
        List<Image> images = imageDAO.doRetrieveAllByProduct(productId);
        if (images.isEmpty()) {
            return true; // No images to remove
        }

        boolean allDeleted = true;
        for (Image image : images) {
            String filePath = servletContext.getRealPath("") + File.separator + image.getImagePath();
            File file = new File(filePath);
            if (file.exists() && !file.delete()) {
                allDeleted = false; // At least one file could not be deleted
            }
        }

        if (allDeleted) {
            return imageDAO.removeImagesByProduct(productId);
        }
        return false;
    }


}
