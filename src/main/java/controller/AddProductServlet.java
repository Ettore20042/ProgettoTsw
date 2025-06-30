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
        boolean success = false;
        Product product = null;
        Map<String, Object> jsonResponse = new HashMap<>();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String productIdParam = request.getParameter("productId");
            boolean isUpdate = productIdParam != null && !productIdParam.trim().isEmpty();

            if (isUpdate) {
                // MODIFICA PRODOTTO ESISTENTE - Recupera quello esistente
                int productId = Integer.parseInt(productIdParam);
                product = productService.getProductById(productId); // ✅ Recupera l'esistente

                if (product == null) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Prodotto non trovato");
                    response.getWriter().write(new Gson().toJson(jsonResponse));
                    return;
                }

                // Aggiorna solo i campi modificati
                product.setProductName(request.getParameter("productName"));
                product.setPrice(Float.parseFloat(request.getParameter("price")));
                product.setSalePrice(Double.parseDouble(request.getParameter("salePrice")));
                product.setColor(request.getParameter("color"));
                product.setDescription(request.getParameter("description"));
                product.setMaterial(request.getParameter("material"));
                product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                product.setCategoryId(Integer.parseInt(request.getParameter("category")));
                product.setBrandId(Integer.parseInt(request.getParameter("brand")));

                boolean updateResult = productService.updateProduct(product);

                if (updateResult) {
                    List<Part> imageParts = getImageParts(request);
                    if (!imageParts.isEmpty()) {
                        String imageDescription = request.getParameter("descriptionImage");
                        imageService.saveProductImages(imageParts, productId, product.getCategoryId(),
                                product.getProductName(), imageDescription);
                    }
                    success = true;
                    System.out.println("MODIFICA - Prodotto aggiornato: " + product.getProductName());
                }

            } else {
                // AGGIUNTA NUOVO PRODOTTO - Crea nuovo oggetto
                product = new Product();
                product.setProductName(request.getParameter("productName"));
                product.setPrice(Float.parseFloat(request.getParameter("price")));
                product.setSalePrice(Double.parseDouble(request.getParameter("salePrice")));
                product.setColor(request.getParameter("color"));
                product.setDescription(request.getParameter("description"));
                product.setMaterial(request.getParameter("material"));
                product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                product.setCategoryId(Integer.parseInt(request.getParameter("category")));
                product.setBrandId(Integer.parseInt(request.getParameter("brand")));

                int newProductId = productService.addProduct(product);
                product.setProductId(newProductId);

                if (newProductId > 0) {
                    List<Part> imageParts = getImageParts(request);
                    if (!imageParts.isEmpty()) {
                        String imageDescription = request.getParameter("descriptionImage");
                        imageService.saveProductImages(imageParts, newProductId, product.getCategoryId(),
                                product.getProductName(), imageDescription);
                    }
                    success = true;
                    System.out.println("AGGIUNTA - Nuovo prodotto creato: " + product.getProductName());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            success = false;
            jsonResponse.put("message", "Errore del server: " + e.getMessage());
        }

        jsonResponse.put("success", success);
        jsonResponse.put("product", success ? product : null);

        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonResponse));
        out.flush();
    }
    // Metodo helper per estrarre le immagini
    private List<Part> getImageParts(HttpServletRequest request) throws IOException, ServletException {
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

        return imageParts;
    }
@Override
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     response.setContentType("application/json;charset=UTF-8");
     Map<String, Object> responseMap = new HashMap<>();
     String azione = request.getParameter("azione");
     Gson gson = new Gson();

     if ("modifica".equals(azione)) {
         try {
             String productIdParam = request.getParameter("productId");
             System.out.println("MODIFICA - Richiesta per prodotto ID: " + productIdParam);

             int productId = Integer.parseInt(productIdParam);

             // Solo recupera il prodotto esistente per popolare il form
             Product product = productService.getProductById(productId);

             if (product != null) {
                 responseMap.put("success", true);
                 responseMap.put("product", product);
                 System.out.println("MODIFICA - Prodotto trovato: " + product.getProductName());
             } else {
                 responseMap.put("success", false);
                 responseMap.put("message", "Prodotto non trovato");
                 System.out.println("MODIFICA - Prodotto non trovato per ID: " + productId);
             }

         } catch (NumberFormatException e) {
             responseMap.put("success", false);
             responseMap.put("message", "ID prodotto non valido");
             System.out.println("MODIFICA - Errore parsing ID: " + e.getMessage());
         } catch (Exception e) {
             e.printStackTrace();
             responseMap.put("success", false);
             responseMap.put("message", "Errore del server: " + e.getMessage());
         }
     } else {
         // Gestione altre azioni GET o redirect
         response.sendRedirect(request.getContextPath() + "/view/profile/manage-products.jsp");
         return;
     }

     response.getWriter().write(gson.toJson(responseMap));
 }}