package controller;


import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.CartItem;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.Bean.User;
import service.OrderService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@MultipartConfig
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

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");


            if (user == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Utente non autenticato");
                response.getWriter().write(new Gson().toJson(jsonResponse));
                return;
            }

            String shippingAddress = request.getParameter("shippingAddressId");
            String billingAddress = request.getParameter("billingAddressId");
            String totalParam = request.getParameter("total");

            if (shippingAddress == null || shippingAddress.isEmpty() ||
                billingAddress == null || billingAddress.isEmpty() ||
                totalParam == null || totalParam.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Parametri mancanti");
                response.getWriter().write(new Gson().toJson(jsonResponse));
                return;
            }

            float totalPrice = Float.parseFloat(totalParam);
            int shippingAddressId = Integer.parseInt(shippingAddress);
            int billingAddressId = Integer.parseInt(billingAddress);


            LocalDate orderDate = LocalDate.now();
            String status = calculateOrderStatus(orderDate);
            LocalDateTime orderDateTime = LocalDateTime.now();

            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setShippingAddressId(shippingAddressId);
            order.setBillingAddressId(billingAddressId);
            order.setTotalAmount(totalPrice);
            order.setOrderDate(orderDate);
            order.setOrderTime(orderDateTime.toLocalTime());
            order.setStatus(status);

            OrderService orderService = new OrderService(getServletContext());
            orderService.processOrder(order, session);

            jsonResponse.put("success", true);
            jsonResponse.put("message", "Ordine elaborato con successo");
            jsonResponse.put("orderId", order.getOrderId());

            response.getWriter().write(new Gson().toJson(jsonResponse));

        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Formato parametri non valido");
            response.getWriter().write(new Gson().toJson(jsonResponse));
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Errore del server: " + e.getMessage());
            response.getWriter().write(new Gson().toJson(jsonResponse));
        }
    }
    private String calculateOrderStatus(LocalDate orderDate) {
        long daysSinceOrder = java.time.temporal.ChronoUnit.DAYS.between(orderDate, LocalDate.now());

        if (daysSinceOrder < 3) {
            return "In elaborazione";
        } else if (daysSinceOrder < 6) {
            return "Spedito";
        } else if (daysSinceOrder < 9) {
            return "In consegna";
        } else {
            return "Consegnato";
        }
    }

}
