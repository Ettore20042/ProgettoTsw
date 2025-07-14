package controller.checkout;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.Bean.Product;
import model.Bean.User;
import model.DAO.OrderDAO;
import model.DAO.OrderItemDAO;
import model.DAO.ProductDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userId = request.getParameter("userId");
        if(userId == null || userId.isEmpty()) {
            request.setAttribute("errorMessage", "Non sei autenticato, devi effettuare il login per visualizzare gli ordini");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/auth/Login.jsp");
            dispatcher.forward(request, response);
            return;
        }
        OrderDAO orderDAO = new OrderDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();

        try{
            List<Order> recentOrders = orderDAO.doRetrieveLastNOrdersByUserId(Integer.parseInt(userId));

            for(Order order : recentOrders){
                List<OrderItem> items = orderItemDAO.doRetrieveByOrderID(order.getOrderId());
                order.setOrderItems(items);
            }

            if(recentOrders.isEmpty()){
                request.setAttribute("orderMessage", "Non hai ancora effettuato alcun ordine");
            }else{
                request.setAttribute("recentOrderList", recentOrders);
            }
        }catch(Exception e){
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

        OrderDAO orderDAO = new OrderDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();

        try {
            List<Order> orderList = orderDAO.doRetrieveByUserId(userId);

            for(Order o : orderList) {
                List<OrderItem> items = orderItemDAO.doRetrieveByOrderID(o.getOrderId());
                o.setOrderItems(items);
            }

            List<Product> productList = getProductsFromOrderList(orderList);
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

    public static List<Product> getProductsFromOrderList(List<Order> orderList) throws SQLException {
        Set<Integer> productIds = new HashSet<>();

        // Estrai tutti i productId unici dagli OrderItem
        for (Order order : orderList) {
            if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
                for (OrderItem item : order.getOrderItems()) {
                    productIds.add(item.getProductId());
                }
            }
        }

        if (productIds.isEmpty()) {
            return new ArrayList<>();
        }

        // Recupera i prodotti usando il ProductDAO
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.doRetrieveByProductIds(new ArrayList<>(productIds));

        return products;
    }
}
