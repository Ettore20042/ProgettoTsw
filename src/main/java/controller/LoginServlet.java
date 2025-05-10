package controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.DAO.UserDAO;

import java.io.IOException;
@WebServlet("/jsp/auth/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Elabora la richiesta
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        Boolean loginSuccess = userDAO.doLogin(email, password);


        if(email.equals("admin") && password.equals("admin")) {

            response.sendRedirect(request.getContextPath() + "/jsp/profile/Admin.jsp");
        } else if(loginSuccess) {

            response.sendRedirect(request.getContextPath() + "/");
        } else {
            response.sendRedirect(request.getContextPath() + "/jsp/auth/login.jsp?error=invalid_credentials");
        }
    }
}
