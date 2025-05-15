package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Invalidare la sessione dell'utente
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		// Reindirizzare l'utente alla pagina di login o alla home page
		response.sendRedirect(request.getContextPath() + "/jsp/auth/Login.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// In caso di richiesta POST, chiama doGet
		doGet(request, response);
	}
}
