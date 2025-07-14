package controller.account;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import model.Bean.UserAddress;
import service.AddressService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AddAddressServlet", value = "/AddAddressServlet")
@MultipartConfig
public class AddAddressServlet extends HttpServlet {

    private AddressService addressService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.addressService = new AddressService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            // Validazione sessione utente
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Utente non autenticato");
                response.getWriter().write(new Gson().toJson(jsonResponse));
                return;
            }

            // Recupero parametri
            String city = request.getParameter("city");
            String street = request.getParameter("street");
            String streetNumber = request.getParameter("streetNumber");
            String zipCode = request.getParameter("zipCode");
            String country = request.getParameter("country");
            String province = request.getParameter("province");
            String addressType = request.getParameter("addressType");

            // Validazione parametri
            if (city == null || street == null || streetNumber == null ||
                    zipCode == null || country == null || province == null || addressType == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Parametri mancanti");
                response.getWriter().write(new Gson().toJson(jsonResponse));
                return;
            }

            // Utilizza il service per creare e associare l'indirizzo all'utente
            UserAddress savedUserAddress = addressService.createAndAddAddressToUser(
                user.getUserId(), city, street, streetNumber, zipCode, country, province, addressType
            );

            if (savedUserAddress != null) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Indirizzo aggiunto con successo");
                jsonResponse.put("addressId", savedUserAddress.getAddress().getAddressId());
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Errore durante l'aggiunta dell'indirizzo");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Errore del server: " + e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(jsonResponse));
        out.flush();
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            String addressId = request.getParameter("addressId");
            String addressType = request.getParameter("addressType");

            System.out.println("AddressId: " + addressId);
            System.out.println("AddressType: " + addressType);

            if (addressId == null || addressType == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Parametri mancanti");
                response.getWriter().write(new Gson().toJson(jsonResponse));
            }

            // Utilizza il service per eliminare l'indirizzo
            boolean success = addressService.deleteAddress(addressId, addressType);

            if (success) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Indirizzo eliminato con successo");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Errore durante l'eliminazione dell'indirizzo");
            }

        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Errore del server: " + e.getMessage());
            e.printStackTrace();
        }

        response.getWriter().write(new Gson().toJson(jsonResponse));
    }
}