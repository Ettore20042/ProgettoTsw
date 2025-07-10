package service;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import model.Bean.CartItem;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.DAO.OrderDAO;
import model.DAO.ProductDAO;

import java.util.List;

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


        // Salva l'ordine nel database
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        order.setOrderId(orderDAO.doSave(order));
        if (order.getOrderId() <= 0) {
            throw new RuntimeException("Errore durante il salvataggio dell'ordine");
        }
        order.setOrderItems(saveItemsInOrder(order.getOrderId(), session));
        for (OrderItem item : order.getOrderItems()) {
            if(productDAO.getProductStock(item.getProductId()) < item.getQuantity()) {
                throw new RuntimeException("Quantità richiesta per il prodotto " + item.getProductId() + " non disponibile in magazzino");
            }
            withdrawItemFromStock(item.getProductId(), item.getQuantity());
        }


        validateOrder(order);
        /*if (!orderSaved) {
            throw new RuntimeException("Errore durante il salvataggio dell'ordine");
        }*/

        // Pulisce il carrello
        clearUserCart( session);
    }

    private void withdrawItemFromStock(int productId, int quantity) {
            System.out.println("Ritiro " + quantity + " unità del prodotto con ID: " + productId);
            ProductDAO productDAO = new ProductDAO();
            productDAO.withdrawFromStock(productId, quantity);
    }

    private void clearUserCart( HttpSession session) {
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
    public List<OrderItem> saveItemsInOrder(int orderId, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        for (CartItem item : cart) {
            System.out.println(item.getProductName() + " " + item.getQuantity());
        }
        OrderDAO orderDAO = new OrderDAO();
        return orderDAO.saveOrderItems(cart, orderId);
    }

}
