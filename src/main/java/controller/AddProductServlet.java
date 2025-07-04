package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Bean.Image;
import model.Bean.Product;
import service.ImageService;
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "AddProductServlet", value = "/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    private ProductService productService;
    private ImageService imageService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
        this.imageService = new ImageService(context);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Object> jsonResponse = new HashMap<>();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String azione = request.getParameter("azione");


        if ("confermaModifica".equals(azione)) {
            try {
                // Debug: print all parameters
                System.out.println("=== DEBUG PARAMETERS ===");
                request.getParameterMap().forEach((key, values) -> {
                    System.out.println(key + " = " + String.join(", ", values));
                });
                System.out.println("========================");

                String productIdStr = request.getParameter("id");
                System.out.println("Product ID received: " + productIdStr);

                if (productIdStr == null || productIdStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("Product ID is required");
                }
                int productId = Integer.parseInt(productIdStr);

                Product product = productService.getProductById(productId);
                System.out.println("Product found: " + (product != null));

                if (product == null) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Product not found");
                } else {
                    // Log original product data
                    System.out.println("Original product: " + product.getProductName() + ", Price: " + product.getPrice());

                    // Update fields
                    product.setProductName(request.getParameter("productName"));
                    product.setColor(request.getParameter("color"));
                    product.setDescription(request.getParameter("description"));
                    product.setMaterial(request.getParameter("material"));
                    String imageDescription = request.getParameter("descriptionImage");

                    String priceStr = request.getParameter("price");
                    if (priceStr != null && !priceStr.isEmpty()) {
                        product.setPrice(Float.parseFloat(priceStr));
                    }

                    String salePriceStr = request.getParameter("salePrice");
                    if (salePriceStr != null && !salePriceStr.isEmpty()) {
                        product.setSalePrice(Double.parseDouble(salePriceStr));
                    }

                    String quantityStr = request.getParameter("quantity");
                    if (quantityStr != null && !quantityStr.isEmpty()) {
                        product.setQuantity(Integer.parseInt(quantityStr));
                    }

                    String categoryIdStr = request.getParameter("category");
                    if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                        product.setCategoryId(Integer.parseInt(categoryIdStr));
                    }

                    String brandIdStr = request.getParameter("brand");
                    if (brandIdStr != null && !brandIdStr.isEmpty()) {
                        product.setBrandId(Integer.parseInt(brandIdStr));
                    }

                    // Log updated product data
                    System.out.println("Updated product: " + product.getProductName() + ", Price: " + product.getPrice());
                    System.out.println("Calling updateProduct for ID: " + product.getProductId());

                    boolean updated = productService.updateProduct(product);

                    if (updated) {
                        List<Part> imageParts = new ArrayList<>();

                        Part image1 = request.getParts().stream()
                                .filter(part -> "image1".equals(part.getName()) && part.getSize() > 0)
                                .findFirst()
                                .orElse(null);

                        if (image1 != null) {
                            imageParts.add(image1);
                        }

                        imageParts.addAll(request.getParts().stream()
                                .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                                .collect(Collectors.toList()));

                        if (!imageParts.isEmpty()) {
                            boolean removed = ImageService.removeProductImages(getServletContext(), product.getProductId());
                            if (removed) {
                                imageService.saveProductImages(imageParts, product.getProductId(), product.getCategoryId(),
                                        product.getProductName(), imageDescription);
                            }

                        }

                    }

                    System.out.println("Update result: " + updated);

                    if (updated) {
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "Prodotto aggiornato con successo");
                    } else {
                        jsonResponse.put("success", false);
                        jsonResponse.put("error", "Errore durante l'aggiornamento del prodotto");
                    }
                }
            } catch (Exception e) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", e.getMessage());
                e.printStackTrace();
            }
        }
        // Handle new product creation (normal flow)
        else {
            Product product = null;
            boolean success = false;

            try {
                product = new Product();
                product.setProductName(request.getParameter("productName"));
                product.setPrice(Float.parseFloat(request.getParameter("price")));

                String salePriceStr = request.getParameter("salePrice");
                if (salePriceStr != null && !salePriceStr.isEmpty()) {
                    product.setSalePrice(Double.parseDouble(salePriceStr));
                }

                product.setColor(request.getParameter("color"));
                product.setDescription(request.getParameter("description"));
                product.setMaterial(request.getParameter("material"));
                product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                product.setCategoryId(Integer.parseInt(request.getParameter("category")));
                product.setBrandId(Integer.parseInt(request.getParameter("brand")));
                String imageDescription = request.getParameter("descriptionImage");

                int newProductId = productService.addProduct(product);
                product.setProductId(newProductId);

                if (newProductId > 0) {
                    List<Part> imageParts = new ArrayList<>();

                    Part image1 = request.getParts().stream()
                            .filter(part -> "image1".equals(part.getName()) && part.getSize() > 0)
                            .findFirst()
                            .orElse(null);

                    if (image1 != null) {
                        imageParts.add(image1);
                    }

                    imageParts.addAll(request.getParts().stream()
                            .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                            .collect(Collectors.toList()));

                    if (!imageParts.isEmpty()) {
                        imageService.saveProductImages(imageParts, newProductId, product.getCategoryId(),
                                product.getProductName(), imageDescription);
                    }
                    success = true;
                }
            } catch (Exception e) {
                e.printStackTrace();
                success = false;
            }

            jsonResponse.put("success", success);
            jsonResponse.put("product", success ? product : null);
        }

        // Send the JSON response
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonResponse));
        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> jsonResponse = new HashMap<>();

        // Only handle the "modifica" action in GET to retrieve product info

        try {
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Product ID is required");
            }
            int productId = Integer.parseInt(productIdStr);
            Product product = productService.getProductById(productId);
            if (product != null) {
                jsonResponse.put("success", true);
                jsonResponse.put("product", product);
                Image image = imageService.getFirstImageByProductId(productId);
                jsonResponse.put("image", image);
                List<Image> images = imageService.getOtherImagesByProductId(productId);
                jsonResponse.put("images", images);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Product not found");
            }
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", e.getMessage());
            e.printStackTrace();
        }


        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonResponse));
        out.flush();
    }
}