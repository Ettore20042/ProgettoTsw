package controller.checkout;


import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.CartItem;
import model.Bean.Order;
import model.Bean.User;
import service.OrderService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@MultipartConfig
@WebServlet(name = "ProcessOrderServlet", value = "/ProcessOrderServlet")
public class ProcessOrderServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.orderService = new OrderService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       /*prova*/
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

            // Ottieni il carrello dalla sessione
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
            if (cartItems == null || cartItems.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Carrello vuoto");
                response.getWriter().write(new Gson().toJson(jsonResponse));
                return;
            }

            // Utilizza il service per creare l'ordine
            Order order = orderService.createOrderFromCheckout(
                user.getUserId(), shippingAddressId, billingAddressId, totalPrice
            );

            // Utilizza il service per processare l'ordine
            orderService.processOrder(order, cartItems);

            // Pulisce il carrello dalla sessione dopo il successo
            session.removeAttribute("cart");
            session.removeAttribute("totalItemsCart");

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
}
