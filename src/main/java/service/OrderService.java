package service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import model.Bean.Order;
import model.DAO.OrderDAO;

public class OrderService {

    private final ServletContext context;

    public OrderService(ServletContext context) {
        this.context = context;
    }

    public void processOrder(Order order, HttpSession session) {
        if (order == null) {
            throw new IllegalArgumentException("Oggetto Order non può essere null");
        }

        // Validazione campi essenziali
        validateOrder(order);

        // Salva l'ordine nel database
        OrderDAO orderDAO = new OrderDAO();
        boolean orderSaved = orderDAO.doSave(order);

        if (!orderSaved) {
            throw new RuntimeException("Errore durante il salvataggio dell'ordine");
        }

        // Pulisce il carrello
        clearUserCart(order.getUserId(), session);
    }

    private void clearUserCart(int userId, HttpSession session) {
        session.removeAttribute("cart");
        // Logica aggiuntiva per rimuovere gli articoli dal carrello se necessario
    }
    private void validateOrder(Order order) {
        if (order.getOrderId() <= 0) {
            throw new IllegalArgumentException("OrderId deve essere positivo");
        }
        if (order.getUserId() <= 0) {
            throw new IllegalArgumentException("UserId deve essere positivo");
        }
        if (order.getBillingAddressId() <= 0) {
            throw new IllegalArgumentException("BillingAddressId deve essere positivo");
        }
        if (order.getShippingAddressId() <= 0) {
            throw new IllegalArgumentException("ShippingAddressId deve essere positivo");
        }
        if (order.getTotalAmount() <= 0) {
            throw new IllegalArgumentException("TotalAmount deve essere positivo");
        }
        if (order.getOrderDate() == null) {
            throw new IllegalArgumentException("OrderDate non può essere null");
        }
        if (order.getOrderTime() == null) {
            throw new IllegalArgumentException("OrderTime non può essere null");
        }
        if (order.getStatus() == null || order.getStatus().trim().isEmpty()) {
            throw new IllegalArgumentException("Status non può essere null o vuoto");
        }
    }


}
