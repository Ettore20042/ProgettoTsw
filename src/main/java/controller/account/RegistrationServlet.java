package controller.account;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import model.DAO.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet(name = "RegistrationServlet", value = "/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {


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
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt()); // Hash della password per sicurezza
        UserDAO userDAO = new UserDAO();
        if (userDAO.isEmailAlreadyUsed(email)) {
            request.setAttribute("error", "Email already in use");
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/auth/Registration.jsp");
            requestDispatcher.forward(request, response);
            return;
        }

        User user=userDAO.doSaveUser(name,surname, phone, hashedPassword, email);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/HomePage.jsp");
        requestDispatcher.forward(request, response);

    }
}

