package controller.admin;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.BrandService;
import model.Bean.Brand;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ManageBrandServlet", value = "/ManageBrandServlet")
@MultipartConfig
public class ManageBrandServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> responseMap = new HashMap<>();
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                String brandIdParam = request.getParameter("id");

                if (brandIdParam == null || brandIdParam.isEmpty()) {
                    responseMap.put("success", false);
                    responseMap.put("message", "ID del brand non fornito");
                    response.getWriter().write(gson.toJson(responseMap));
                    return;
                }

                int brandId = Integer.parseInt(brandIdParam);
                BrandService brandService = new BrandService(getServletContext());
                Brand brand = brandService.getBrandById(brandId);

                if (brand != null) {
                    responseMap.put("success", true);
                    responseMap.put("brand", brand);
                } else {
                    responseMap.put("success", false);
                    responseMap.put("message", "Brand non trovato");
                }

            } else {
                responseMap.put("success", false);
                responseMap.put("message", "Azione non supportata");
            }

        } catch (NumberFormatException e) {
            responseMap.put("success", false);
            responseMap.put("message", "ID del brand non valido");
        } catch (Exception e) {
            e.printStackTrace();
            responseMap.put("success", false);
            responseMap.put("message", "Errore del server: " + e.getMessage());
        }

        response.getWriter().write(gson.toJson(responseMap));
        response.getWriter().flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        Map<String,Object> responseMap = new HashMap<>();
        String action = request.getParameter("action");
        if("update".equals(action)){
            try {
                // Per UPDATE, l'ID viene passato come parametro URL "id", non "brandId" nel body
                int brandId = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("brandName");
                String logoPath = request.getParameter("logoPath");

                // Validazione input
                if (name == null || name.trim().isEmpty()) {
                    responseMap.put("success", false);
                    responseMap.put("message", "Nome brand è obbligatorio");
                    response.getWriter().write(gson.toJson(responseMap));
                    return;
                }

                BrandService brandService = new BrandService(getServletContext());
                Brand updatedBrand = brandService.updateBrand(brandId, name.trim(), logoPath);

                if (updatedBrand != null) {
                    responseMap.put("success", true);
                    responseMap.put("message", "Brand aggiornato con successo");
                    responseMap.put("brand", updatedBrand);
                } else {
                    responseMap.put("success", false);
                    responseMap.put("message", "Errore durante l'aggiornamento del brand");
                }

            } catch (Exception e) {
                e.printStackTrace();
                responseMap.put("success", false);
                responseMap.put("message", "Errore del server: " + e.getMessage());
            }

        }else {

            try {
                String name = request.getParameter("brandName");
                String logoPath = request.getParameter("logoPath");


                // Validazione input
                if (name == null || name.trim().isEmpty()) {

                    responseMap.put("success", false);
                    responseMap.put("message", "Nome brand è obbligatorio");
                    response.getWriter().write(gson.toJson(responseMap));
                    return;
                }


                BrandService brandService = new BrandService(getServletContext());
                Brand newBrand = brandService.addBrand(name.trim(), logoPath);

                if (newBrand != null) {

                    responseMap.put("success", true);
                    responseMap.put("message", "Brand aggiunto con successo");
                    responseMap.put("brand", newBrand);
                } else {

                    responseMap.put("success", false);
                    responseMap.put("message", "Errore durante l'aggiunta del brand");
                }

            } catch (Exception e) {

                e.printStackTrace();
                responseMap.put("success", false);
                responseMap.put("message", "Errore del server: " + e.getMessage());
            }
        }

        String jsonResponse = gson.toJson(responseMap);
        System.out.println("Risposta JSON: " + jsonResponse);
        response.getWriter().write(jsonResponse);
        response.getWriter().flush();
        response.getWriter().close();
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        Map<String, Object> responseMap = new HashMap<>();

        try {
            // Leggiamo il body della richiesta DELETE
            StringBuilder body = new StringBuilder();
            String line;
            try (java.io.BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    body.append(line);
                }
            }

            String requestBody = body.toString();
            System.out.println("ManageBrandServlet DELETE: body ricevuto = " + requestBody);

            // Estraiamo il brandId dal body (formato: brandId=123)
            String brandIdParam = null;
            if (requestBody.contains("brandId=")) {
                String[] parts = requestBody.split("="); // separa per il simbolo '='
                if (parts.length == 2) {
                    brandIdParam = parts[1];
                }
            }

            System.out.println("ManageBrandServlet DELETE: brandId estratto = " + brandIdParam);

            if (brandIdParam == null || brandIdParam.isEmpty()) {
                responseMap.put("success", false);
                responseMap.put("message", "ID del brand non fornito");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(gson.toJson(responseMap));
                return;
            }

            int brandId = Integer.parseInt(brandIdParam);
            System.out.println("ManageBrandServlet DELETE: tentativo eliminazione brand ID = " + brandId);

            BrandService brandService = new BrandService(getServletContext());
            boolean isDeleted = brandService.deleteBrand(brandId);

            if (isDeleted) {
                System.out.println("ManageBrandServlet DELETE: brand eliminato con successo");
                responseMap.put("success", true);
                responseMap.put("message", "Brand eliminato con successo");
            } else {
                System.out.println("ManageBrandServlet DELETE: errore nell'eliminazione");
                responseMap.put("success", false);
                responseMap.put("message", "Brand non trovato o errore durante l'eliminazione");
            }
        } catch (NumberFormatException e) {
            System.out.println("ManageBrandServlet DELETE: ID non valido");
            responseMap.put("success", false);
            responseMap.put("message", "ID del brand non valido");
        } catch (Exception e) {
            System.out.println("ManageBrandServlet DELETE: eccezione = " + e.getMessage());
            e.printStackTrace();
            responseMap.put("success", false);
            responseMap.put("message", "Errore del server: " + e.getMessage());
        }

        String jsonResponse = gson.toJson(responseMap);
        System.out.println("ManageBrandServlet DELETE: risposta = " + jsonResponse);
        resp.getWriter().write(jsonResponse);
        resp.getWriter().flush();
        resp.getWriter().close();
    }
}
