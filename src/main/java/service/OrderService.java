package service;

import jakarta.servlet.ServletContext;
import model.Bean.Order;

public class OrderService {

    private final ServletContext context; /* memorizziamo dati che devono essere accessibili da diverse parti del codice */


    public OrderService(ServletContext context) {
        this.context = context;
    }


    public void processOrder(Order order) {
        // Logica per elaborare l'ordine, ad esempio salvataggio nel database
        // Qui dovresti chiamare un metodo del DAO per salvare l'ordine nel database
        // Per esempio:
        // OrderDAO orderDAO = new OrderDAO();
        // orderDAO.saveOrder(order);

        // Simulazione di elaborazione dell'ordine
        System.out.println("Ordine elaborato: " + order.getOrderId());
    }
}
