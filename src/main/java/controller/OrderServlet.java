package controller;

import com.oracle.wls.shaded.org.apache.xpath.operations.Or;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.DAO.OrderDAO;
import model.DAO.OrderItemDAO;
import model.DAO.UserDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userId = request.getParameter("userId");
        System.out.println(userId);

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

}
