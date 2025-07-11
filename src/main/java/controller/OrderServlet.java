package controller;

import com.oracle.wls.shaded.org.apache.xpath.operations.Or;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.Bean.Product;
import model.DAO.OrderDAO;
import model.DAO.OrderItemDAO;
import model.DAO.ProductDAO;
import model.DAO.UserDAO;

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

        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/profile/User.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String userId = request.getParameter("userId");

        OrderDAO orderDAO = new OrderDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();

        try {
            List<Order> orderList = orderDAO.doRetrieveByUserId(Integer.parseInt(userId));

            for(Order order : orderList){
                List<OrderItem> items = orderItemDAO.doRetrieveByOrderID(order.getOrderId());
                order.setOrderItems(items);
            }
            // Usa il nuovo metodo
            List<Product> productList = getProductsFromOrderList(orderList);
            for(Product product : productList){
                System.out.println("Product: " + product.getProductName() + ", Price: " + product.getPrice());
            }

            request.setAttribute("orderList", orderList);
            request.setAttribute("productList", productList);


            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/profile/Order.jsp");
            dispatcher.forward(request, response);
        }catch (Exception e){
            e.printStackTrace();
        }


    }
    public static List<Product> getProductsFromOrderList(List<Order> orderList) throws SQLException {
        Set<Integer> productIds = new HashSet<>();

        // Estrai tutti i productId unici dagli OrderItem
        for (Order order : orderList) {
            if (order.getOrderItems() != null) {
                for (OrderItem item : order.getOrderItems()) {
                    productIds.add(item.getProductId());
                }
            }
        }

        // Recupera i prodotti usando il ProductDAO
        ProductDAO productDAO = new ProductDAO();
        return productDAO.doRetrieveByProductIds(new ArrayList<>(productIds));
    }

}
