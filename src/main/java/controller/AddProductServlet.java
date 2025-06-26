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
        Map<String, Object> jsonResponse = new HashMap<>();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

            // 1. Estrai i dati e crea il bean Product
        try {
            Product product = new Product();
            product.setProductName(request.getParameter("productName"));
            product.setPrice(Float.parseFloat(request.getParameter("price")));
            product.setSalePrice(Double.parseDouble(request.getParameter("salePrice")));
            product.setColor(request.getParameter("color"));
            product.setDescription(request.getParameter("description"));
            product.setMaterial(request.getParameter("material"));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            product.setCategoryId(Integer.parseInt(request.getParameter("category")));
            product.setBrandId(Integer.parseInt(request.getParameter("brand")));
            String imageDescription = request.getParameter("imageDescription");

            int newProductId = productService.addProduct(product);

            if (newProductId > 0) {
                // 3. Estrai le immagini e chiama il service per salvarle
                List<Part> imageParts = new ArrayList<>();

                // First find Image1 if it exists
                Part image1 = request.getParts().stream()
                        .filter(part -> "image1".equals(part.getName()) && part.getSize() > 0)
                        .findFirst()
                        .orElse(null);

                // Add Image1 at the beginning if found
                if (image1 != null) {
                    imageParts.add(image1);
                }

                // Add the rest of the images
                imageParts.addAll(request.getParts().stream()
                        .filter(part -> "images".equals(part.getName()) && part.getSize() > 0)
                        .collect(Collectors.toList()));

                if (!imageParts.isEmpty()) {
                    imageService.saveProductImages(imageParts, newProductId, product.getCategoryId(), product.getProductName(), imageDescription);
                }
                success = true;
            }
        } catch (Exception e) {
            // Log dell'errore per il debug
            e.printStackTrace();
            success = false;
        }

        // 4. Invia una risposta JSON corretta
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        jsonResponse.put("success", success);


        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonResponse));
        out.flush();
    }
}