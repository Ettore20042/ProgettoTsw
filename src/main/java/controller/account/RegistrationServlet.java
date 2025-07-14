package controller.account;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import service.AuthenticationService;

import java.io.IOException;

@WebServlet(name = "RegistrationServlet", value = "/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    private AuthenticationService authenticationService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.authenticationService = new AuthenticationService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String phone = request.getParameter("phone");
        System.out.println("Phone: " + phone);
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Verifica se l'email è già in uso
        if (authenticationService.isEmailAlreadyUsed(email)) {
            request.setAttribute("error", "Email already in use");
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/auth/Registration.jsp");
            requestDispatcher.forward(request, response);
            return;
        }

        // Utilizza il service per la registrazione
        User user = authenticationService.registerUser(name, surname, phone, email, password);

        if (user != null) {
            // Registrazione avvenuta con successo
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/HomePage.jsp");
            requestDispatcher.forward(request, response);
        } else {
            // Registrazione fallita
            request.setAttribute("error", "Registration failed");
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/auth/Registration.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
