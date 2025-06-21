package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import model.DAO.UserDAO;

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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        if (userDAO.isEmailAlreadyUsed(email)) {
            request.setAttribute("error", "Email already in use");
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/auth/Registration.jsp");
            requestDispatcher.forward(request, response);
            return;
        }
        User user= new User(0, name, surname, phone, false, password, email);
        userDAO.doSaveUser(user);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/HomePage.jsp");
        requestDispatcher.forward(request, response);

    }
} 
