package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.DAO.OrderDAO;
import model.DAO.UserDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/OrderServlet")
public class OrderServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userId = request.getParameter("userId");

        OrderDAO orderDAO = new OrderDAO();
        RequestDispatcher dispatcher;


        try {
            List<Order> orderList = orderDAO.doRetrieveByUserId(Integer.parseInt(userId));
            request.setAttribute("orderList", orderList);

            dispatcher = request.getRequestDispatcher("/jsp/profile/User.jsp");
            dispatcher.forward(request, response);
        }catch (Exception e) {
            request.setAttribute("error", e);
            dispatcher = request.getRequestDispatcher("/jsp/profile/User.jsp");
            dispatcher.forward(request, response);
        }



    }

}
