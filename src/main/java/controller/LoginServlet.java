package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import model.DAO.UserDAO;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
/*
        boolean rememberMe = request.getParameter("remember-me") != null;
*/
        UserDAO userDAO = new UserDAO();
        User userLogged = userDAO.doLogin(email, password);
        if(userLogged != null) {
            request.getSession().setAttribute("user", userLogged);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/profile/User.jsp");
            dispatcher.forward(request, response);
        }

        /*if(rememberMe) {
            Cookie emailCookie = new Cookie("email", email);
            emailCookie.setMaxAge(60 * 60 * 24 * 30); // 30 giorni
            emailCookie.setSecure(true);
            response.addCookie(emailCookie);
            Cookie rememberMeCookie = new Cookie("remember-me", "true");
            rememberMeCookie.setMaxAge(60 * 60 * 24 * 30); // 30 giorni
            rememberMeCookie.setSecure(true);
            response.addCookie(rememberMeCookie);
        }*/

    }
} 
