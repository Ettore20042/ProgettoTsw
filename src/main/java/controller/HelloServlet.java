package controller;

import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Address;
import model.DAO.AddressDAO;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


            Address address = new Address();
            address.setCity("Rome");
            address.setStreet("Via Roma");
            address.setStreetNumber("1");
            address.setZipCode("00100");
            address.setCountry("Italy");
            address.setProvince("Lazio");

            AddressDAO service = new AddressDAO();
            service.doSave(address);

            out.println("<html><body>");
            out.println("<h1> salvato con successo!</h1>");
            out.println("<p>ID assegnato: " + address.getAddressId()+ "</p>");
            out.println("</body></html>");

    }

    public void destroy() {
    }
}