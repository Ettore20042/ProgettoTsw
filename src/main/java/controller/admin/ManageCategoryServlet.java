package controller.admin;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.CategoryService;
import model.Bean.Category;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ManageCategoryServlet", value = "/ManageCategoryServlet")
@MultipartConfig
public class ManageCategoryServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> responseMap = new HashMap<>();
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                String categoryIdParam = request.getParameter("id");

                if (categoryIdParam == null || categoryIdParam.isEmpty()) {
                    responseMap.put("success", false);
                    responseMap.put("message", "ID della categoria non fornito");
                    response.getWriter().write(gson.toJson(responseMap));
                    return;
                }

                int categoryId = Integer.parseInt(categoryIdParam);
                CategoryService categoryService = new CategoryService(getServletContext());
                Category category = categoryService.getCategoryById(categoryId);

                if (category != null) {
                    responseMap.put("success", true);
                    responseMap.put("category", category);
                } else {
                    responseMap.put("success", false);
                    responseMap.put("message", "Categoria non trovata");
                }

            } else {
                responseMap.put("success", false);
                responseMap.put("message", "Azione non supportata");
            }

        } catch (NumberFormatException e) {
            responseMap.put("success", false);
            responseMap.put("message", "ID della categoria non valido");
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
                // Per UPDATE, l'ID viene passato come parametro URL "id"
                int categoryId = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("categoryName");
                String categoryPath = request.getParameter("categoryPath");

                // Validazione input
                if (name == null || name.trim().isEmpty()) {
                    responseMap.put("success", false);
                    responseMap.put("message", "Nome categoria è obbligatorio");
                    response.getWriter().write(gson.toJson(responseMap));
                    return;
                }

                CategoryService categoryService = new CategoryService(getServletContext());
                Category updatedCategory = categoryService.updateCategory(categoryId, name.trim(), categoryPath);

                if (updatedCategory != null) {
                    responseMap.put("success", true);
                    responseMap.put("message", "Categoria aggiornata con successo");
                    responseMap.put("category", updatedCategory);
                } else {
                    responseMap.put("success", false);
                    responseMap.put("message", "Errore durante l'aggiornamento della categoria");
                }

            } catch (Exception e) {
                e.printStackTrace();
                responseMap.put("success", false);
                responseMap.put("message", "Errore del server: " + e.getMessage());
            }

        } else {
            // ADD operation
            try {
                String name = request.getParameter("categoryName");
                String categoryPath = request.getParameter("categoryPath");

                // Validazione input
                if (name == null || name.trim().isEmpty()) {
                    responseMap.put("success", false);
                    responseMap.put("message", "Nome categoria è obbligatorio");
                    response.getWriter().write(gson.toJson(responseMap));
                    return;
                }

                CategoryService categoryService = new CategoryService(getServletContext());
                Category newCategory = categoryService.addCategory(name.trim(), categoryPath);

                if (newCategory != null) {
                    responseMap.put("success", true);
                    responseMap.put("message", "Categoria aggiunta con successo");
                    responseMap.put("category", newCategory);
                } else {
                    responseMap.put("success", false);
                    responseMap.put("message", "Errore durante l'aggiunta della categoria");
                }

            } catch (Exception e) {
                e.printStackTrace();
                responseMap.put("success", false);
                responseMap.put("message", "Errore del server: " + e.getMessage());
            }
        }

        String jsonResponse = gson.toJson(responseMap);
        System.out.println("Risposta JSON Category: " + jsonResponse);
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
            System.out.println("ManageCategoryServlet DELETE: body ricevuto = " + requestBody);

            // Estraiamo il categoryId dal body (formato: categoryId=123)
            String categoryIdParam = null;
            if (requestBody.contains("categoryId=")) {
                String[] parts = requestBody.split("=");
                if (parts.length == 2) {
                    categoryIdParam = parts[1];
                }
            }

            System.out.println("ManageCategoryServlet DELETE: categoryId estratto = " + categoryIdParam);

            if (categoryIdParam == null || categoryIdParam.isEmpty()) {
                responseMap.put("success", false);
                responseMap.put("message", "ID della categoria non fornito");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write(gson.toJson(responseMap));
                return;
            }

            int categoryId = Integer.parseInt(categoryIdParam);
            System.out.println("ManageCategoryServlet DELETE: tentativo eliminazione categoria ID = " + categoryId);

            CategoryService categoryService = new CategoryService(getServletContext());
            boolean isDeleted = categoryService.deleteCategory(categoryId);

            if (isDeleted) {
                System.out.println("ManageCategoryServlet DELETE: categoria eliminata con successo");
                responseMap.put("success", true);
                responseMap.put("message", "Categoria eliminata con successo");
            } else {
                System.out.println("ManageCategoryServlet DELETE: errore nell'eliminazione");
                responseMap.put("success", false);
                responseMap.put("message", "Categoria non trovata o errore durante l'eliminazione");
            }
        } catch (NumberFormatException e) {
            System.out.println("ManageCategoryServlet DELETE: ID non valido");
            responseMap.put("success", false);
            responseMap.put("message", "ID della categoria non valido");
        } catch (Exception e) {
            System.out.println("ManageCategoryServlet DELETE: eccezione = " + e.getMessage());
            e.printStackTrace();
            responseMap.put("success", false);
            responseMap.put("message", "Errore del server: " + e.getMessage());
        }

        String jsonResponse = gson.toJson(responseMap);
        System.out.println("ManageCategoryServlet DELETE: risposta = " + jsonResponse);
        resp.getWriter().write(jsonResponse);
        resp.getWriter().flush();
        resp.getWriter().close();
    }
}
