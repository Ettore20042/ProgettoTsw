package service;

import jakarta.servlet.ServletContext;
import model.Bean.CartItem;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.Bean.Product;
import model.DAO.OrderDAO;
import model.DAO.OrderItemDAO;
import model.DAO.ProductDAO;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class OrderService {

    private final OrderDAO orderDAO;
    private final ProductDAO productDAO;
    private final OrderItemDAO orderItemDAO;

    public OrderService(ServletContext context) {
        this.orderDAO = new OrderDAO();
        this.productDAO = new ProductDAO();
        this.orderItemDAO = new OrderItemDAO();
    }

    // ===== METODI PER IL CHECKOUT =====

    /**
     * Calcola il totale del carrello
     * Spostato da CheckoutServlet.java
     */
    public double calculateCartTotal(List<CartItem> cartItems) {
        double total = 0.0;
        for(CartItem item : cartItems) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }

    /**
     * Calcola il totale per un singolo prodotto
     * Spostato da CheckoutServlet.java
     */
    public double calculateProductTotal(double price, int quantity) {
        return price * quantity;
    }

    /**
     * Crea un oggetto Order per il checkout
     * Spostato da ProcessOrderServlet.java
     */
    public Order createOrderFromCheckout(int userId, int shippingAddressId, int billingAddressId,
                                        float totalAmount) {
        java.time.LocalDateTime orderDateTime = java.time.LocalDateTime.now();
        String status = calculateOrderStatus(orderDateTime);

        Order order = new Order();
        order.setUserId(userId);
        order.setShippingAddressId(shippingAddressId);
        order.setBillingAddressId(billingAddressId);
        order.setTotalAmount(totalAmount);
        order.setOrderDate(LocalDate.now());
        order.setOrderTime(orderDateTime.toLocalTime());
        order.setStatus(status);

        return order;
    }

    /**
     * Calcola lo status dell'ordine in base alla data
     * Spostato da ProcessOrderServlet.java
     */
    public String calculateOrderStatus(LocalDateTime orderDateTime) {
        long minutesElapsed = java.time.temporal.ChronoUnit.MINUTES.between(orderDateTime, java.time.LocalDateTime.now());

        if (minutesElapsed < 3) {
            return "In elaborazione";
        } else if (minutesElapsed < 6) {
            return "Spedito";
        } else if (minutesElapsed < 9) {
            return "In consegna";
        } else {
            return "Consegnato";
        }
    }

    public List<Order> setOrdersStatus(List<Order> orders) {
        for (Order order : orders) {
            if (!order.getStatus().equals("Consegnato")) {
                LocalDateTime orderDateTime = LocalDateTime.of(order.getOrderDate(), order.getOrderTime());
                order.setStatus(calculateOrderStatus(orderDateTime));
            }
        }
        return orders;
    }

    // ===== METODI PER ELABORAZIONE ORDINI =====

    /**
     * Processa un ordine completo
     * Modificato per eliminare dipendenza da HttpSession
     */
    public void processOrder(Order order, List<CartItem> cartItems) {
        if (order == null) {
            throw new IllegalArgumentException("Oggetto Order non può essere null");
        }

        // Salva l'ordine nel database
        order.setOrderId(orderDAO.doSave(order));
        if (order.getOrderId() <= 0) {
            throw new RuntimeException("Errore durante il salvataggio dell'ordine");
        }

        order.setOrderItems(saveItemsInOrder(order.getOrderId(), cartItems));
        for (OrderItem item : order.getOrderItems()) {
            if(productDAO.getProductStock(item.getProductId()) < item.getQuantity()) {
                throw new RuntimeException("Quantità richiesta per il prodotto " + item.getProductId() + " non disponibile in magazzino");
            }
            withdrawItemFromStock(item.getProductId(), item.getQuantity());
        }

        validateOrder(order);
    }

    /**
     * Salva gli items dell'ordine
     * Modificato per accettare List<CartItem> invece di HttpSession
     */
    public List<OrderItem> saveItemsInOrder(int orderId, List<CartItem> cartItems) {
        for (CartItem item : cartItems) {
            System.out.println(item.getProductName() + " " + item.getQuantity());
        }
        return orderDAO.saveOrderItems(cartItems, orderId);
    }

    // ===== METODI PER RECUPERO ORDINI =====

    /**
     * Recupera gli ordini recenti di un utente
     * Spostato da OrderServlet.java doGet()
     */
    public List<Order> getUserRecentOrders(int userId) {
        try {
            List<Order> recentOrders = orderDAO.doRetrieveLastNOrdersByUserId(userId);

            for(Order order : recentOrders){
                List<OrderItem> items = orderItemDAO.doRetrieveByOrderID(order.getOrderId());
                order.setOrderItems(items);
            }

            return recentOrders;
        } catch(Exception e){
            e.printStackTrace();
            throw new RuntimeException("Si è verificato un errore nel recupero dei dati");
        }
    }

    /**
     * Recupera tutti gli ordini di un utente con dettagli
     * Spostato da OrderServlet.java doPost()
     */
    public List<Order> getUserAllOrdersWithDetails(int userId) {
        try {
            List<Order> orderList = orderDAO.doRetrieveByUserId(userId);

            for(Order order : orderList) {
                List<OrderItem> items = orderItemDAO.doRetrieveByOrderID(order.getOrderId());
                order.setOrderItems(items);
            }

            return orderList;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Errore durante il recupero degli ordini");
        }
    }

    /**
     * Ottiene i prodotti da una lista di ordini
     * Spostato da OrderServlet.java (metodo statico)
     */
    public List<Product> getProductsFromOrderList(List<Order> orderList) throws SQLException {
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
        List<Product> products = productDAO.doRetrieveByProductIds(new ArrayList<>(productIds));
        return products;
    }

    // ===== METODI PRIVATI DI SUPPORTO =====

    private void withdrawItemFromStock(int productId, int quantity) {
        System.out.println("Ritiro " + quantity + " unità del prodotto con ID: " + productId);
        productDAO.withdrawFromStock(productId, quantity);
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
