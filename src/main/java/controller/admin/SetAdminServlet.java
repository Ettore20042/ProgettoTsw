package controller.admin;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.UserService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "SetAdminServlet", value = "/SetAdminServlet")
public class SetAdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseMap = new HashMap<>();

        try {
            String userId = request.getParameter("userId");
            String isAdminParam = request.getParameter("isAdmin");

            // Validazione parametri
            if (userId == null || isAdminParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseMap.put("success", false);
                responseMap.put("message", "Missing parameters");
                return;
            }

            UserService userService = new UserService(getServletContext());


            boolean adminStatus = "yes".equals(isAdminParam); // ✅ Corretto
            boolean result = userService.updateAdmin(userId, adminStatus);

            if (result) {
                responseMap.put("success", true);
                responseMap.put("message", "Admin status updated successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                responseMap.put("success", false);
                responseMap.put("message", "Failed to update admin status");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseMap.put("success", false);
            responseMap.put("message", "Server error: " + e.getMessage());
        }
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(responseMap));
        out.flush();
    }


}