package controller.account;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.User;
import service.AuthenticationService;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private AuthenticationService authenticationService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.authenticationService = new AuthenticationService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/auth/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String redirectAfterLogin = request.getParameter("redirectAfterLogin");
        String productId = request.getParameter("productId");
        String quantitySelected = request.getParameter("quantitySelected");

        // Utilizza il service per l'autenticazione
        User user = authenticationService.authenticateUser(email, password);

        if (user != null) {
            // Salva l'utente nella sessione
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Se non viene passato alcun redirectAfterLogin, imposto default alla homepage
            if (redirectAfterLogin == null || redirectAfterLogin.isEmpty() || redirectAfterLogin.equals("jsp/HomePage.jsp")) {
                // Redirect alla homepage senza parametri
                String redirectURL = request.getContextPath() + "/";
                System.out.println("Redirect URL (homepage): " + redirectURL);
                response.sendRedirect(redirectURL);
            }

            // Costruisco l'URL di redirect per altre pagine
            String redirectURL = request.getContextPath() + "/" + redirectAfterLogin;

            // Aggiungo i parametri solo se esistono e NON sono vuoti
            if (productId != null && !productId.isEmpty() &&
                quantitySelected != null && !quantitySelected.isEmpty()) {
                redirectURL += "?productId=" + URLEncoder.encode(productId, "UTF-8") +
                              "&quantitySelected=" + URLEncoder.encode(quantitySelected, "UTF-8");
            }

            System.out.println("Redirect URL: " + redirectURL);
            response.sendRedirect(redirectURL);

        } else {
            // Login fallito
            request.setAttribute("loginError", "Credenziali errate");
            request.getRequestDispatcher("/jsp/auth/Login.jsp").forward(request, response);
        }
    }

}