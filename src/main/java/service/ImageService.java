package service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import model.Bean.Category;
import model.Bean.Image;
import model.DAO.ImageDAO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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

    public void saveProductImages(List<Part> imageParts, int productId, int categoryId) throws IOException {
        if (imageParts == null || imageParts.isEmpty()) {
            return;
        }

        categoryService.checkCategoryCache();
        Map<Integer, Category> categoryMap = (Map<Integer, Category>) context.getAttribute("categoryCacheMap");
        List<Category> breadcrumb = categoryService.buildBreadcrumbFromMap(categoryMap, categoryId);
        String uploadPath = buildUploadPath(breadcrumb);

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean createdDir = uploadDir.mkdirs();
            if (!createdDir) {
                throw new RuntimeException("Impossibile creare la directory di upload: " + uploadPath);
            }

        }

        Pattern pattern = Pattern.compile("(.*)_(\\d+)\\.(jpg|jpeg|png|webp|svg)$", Pattern.CASE_INSENSITIVE);

        for (Part part : imageParts) {
            String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

            if (originalFileName != null && !originalFileName.isEmpty()) {
                String formattedFileName = originalFileName.trim().replaceAll("\\s+", "_").toLowerCase();
                Matcher matcher = pattern.matcher(formattedFileName);

                if (matcher.matches()) {
                    String baseName = matcher.group(1);
                    int displayOrder = Integer.parseInt(matcher.group(2));
                    String imageDescription = baseName.replace("_", " ");

                    part.write(uploadPath + File.separator + formattedFileName);

                    String relativePath = "img/products/" +
                            breadcrumb.stream()
                                    .map(cat -> formatForPath(cat.getCategoryName()))
                                    .collect(Collectors.joining("/")) + "/" + formattedFileName;
                    imageDAO.addImage(productId, relativePath, imageDescription, displayOrder);
                } else {
                    context.log("WARN: Skipped invalid image file name: " + originalFileName);
                }
            }
        }
    }

    private String buildUploadPath(List<Category> breadcrumb) {
        String basePath = context.getRealPath("/") + "img" + File.separator + "products";
        StringBuilder pathBuilder = new StringBuilder(basePath);
        for (Category cat : breadcrumb) {
            pathBuilder.append(File.separator).append(formatForPath(cat.getCategoryName()));
        }
        return pathBuilder.toString();
    }

    private String formatForPath(String text) {
        if (text == null) return "";
        return text.trim().toLowerCase().replaceAll("\\s+", "-");
    }
}
