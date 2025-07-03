package controller;


import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Order;
import model.Bean.User;
import service.OrderService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ProcessOrderServlet", value = "/ProcessOrderServlet")
public class ProcessOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> jsonResponse = new HashMap<>();

        try{
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int userId=user.getUserId();
            String shippingAddress = request.getParameter("shippingAddressId");
            String billingAddress = request.getParameter("billingAddressId");
            float totalPrice = Float.parseFloat(request.getParameter("total"));

            String status ="In elaborazione";
            LocalDate orderDate = LocalDate.now();        // Solo la data (yyyy-MM-dd)
            LocalDateTime orderDateTime = LocalDateTime.now(); // Data e orario completo
            int orderId = (int) (Math.random() * 1000000); // Generazione ID ordine casuale
            // Creazione dell'oggetto Order
            Order order = new Order(orderId, userId, Integer.parseInt(billingAddress), Integer.parseInt(shippingAddress),  totalPrice, orderDateTime.toLocalTime(), orderDate, status);

            // Logica per elaborare l'ordine (ad esempio, salvataggio nel database)
            // Qui dovresti chiamare un metodo del servizio per salvare l'ordine nel database
            OrderService orderService = new OrderService(getServletContext());
            orderService.processOrder(order);
            // Simulazione di elaborazione dell'ordine
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Ordine elaborato con successo");
            jsonResponse.put("orderId", order.getOrderId());
            response.getWriter().write(new Gson().toJson(jsonResponse));



        }catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Errore durante l'elaborazione dell'ordine: " + e.getMessage());
            response.getWriter().write(new Gson().toJson(jsonResponse));
            return;
        }
    }
} 
