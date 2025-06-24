package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import model.DAO.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Mostra la pagina di login
        request.getRequestDispatcher("/jsp/auth/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        // Hash della password per sicurezza
        //gensalt() genera un "salt" casuale (una stringa casuale lunga).
        //hashpw() usa il salt e la password per calcolare un hash.
        String redirectAfterLogin = request.getParameter("redirectAfterLogin");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.doLogin(email, hashedPassword);

        if (user != null) {
            // Salva l'utente nella sessione
            HttpSession session = request.getSession();
            session.setAttribute("user", user);


            // Se non viene passato alcun redirectAfterLogin, imposto default
            if (redirectAfterLogin == null || redirectAfterLogin.isEmpty()) {
                redirectAfterLogin = "jsp/HomePage.jsp";
            }

            // Effettuo sempre un redirect per evitare problemi di refresh dopo POST
            response.sendRedirect(request.getContextPath() + "/" + redirectAfterLogin);

        } else {
            // Login fallito
            request.setAttribute("loginError", "Credenziali errate");
            request.getRequestDispatcher("/jsp/auth/Login.jsp").forward(request, response);
            return;
        }
    }

}