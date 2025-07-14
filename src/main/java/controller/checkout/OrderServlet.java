package controller.checkout;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Bean.Order;
import model.Bean.Product;
import model.Bean.User;
import service.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.orderService = new OrderService(context);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String userId = null;
        if (user != null) {
            userId = String.valueOf(user.getUserId());
        } else {
            userId = request.getParameter("userId");
        }
        
        if(userId == null || userId.isEmpty()) {
            request.setAttribute("errorMessage", "Non sei autenticato, devi effettuare il login per visualizzare gli ordini");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/auth/Login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            // Utilizza il service per recuperare gli ordini recenti
            List<Order> recentOrders = orderService.getUserRecentOrders(Integer.parseInt(userId));
            recentOrders = orderService.setOrdersStatus(recentOrders);

            if(recentOrders.isEmpty()){
                request.setAttribute("orderMessage", "Non hai ancora effettuato alcun ordine");
            } else {
                request.setAttribute("recentOrderList", recentOrders);
            }
        } catch(Exception e){
            e.printStackTrace();
            request.setAttribute("errorMessage", "Si è verificato un errore nel recupero dei dati");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/account/User.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Recupera l'utente loggato dalla sessione
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            request.setAttribute("errorMessage", "Non sei autenticato, effettua il login.");
            request.getRequestDispatcher("/jsp/auth/Login.jsp").forward(request, response);
            return;
        }

        int userId = user.getUserId();

        try {
            // Utilizza il service per recuperare tutti gli ordini con dettagli
            List<Order> orderList = orderService.getUserAllOrdersWithDetails(userId);
            orderList = orderService.setOrdersStatus(orderList);

            // Utilizza il service per ottenere i prodotti dalla lista ordini
            List<Product> productList = orderService.getProductsFromOrderList(orderList);

            request.setAttribute("orderList", orderList);
            request.setAttribute("productList", productList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/account/Order.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Errore durante il recupero degli ordini");
            request.getRequestDispatcher("/WEB-INF/jsp/account/Order.jsp").forward(request, response);
        }
    }
}
