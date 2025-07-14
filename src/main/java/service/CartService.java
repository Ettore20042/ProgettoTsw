package service;

import jakarta.servlet.ServletContext;
import model.Bean.CartItem;
import model.Bean.Product;
import model.DAO.ProductDAO;

import java.util.ArrayList;
import java.util.List;

/**
 * Service che gestisce le operazioni del carrello
 */
public class CartService {

    private final ProductDAO productDAO;

    public CartService(ServletContext context) {
        this.productDAO = new ProductDAO();
    }

    /**
     * Aggiunge un prodotto al carrello o aggiorna la quantità
     * Spostato da CartServlet.java doPost()
     */
    public List<CartItem> addOrUpdateCartItem(List<CartItem> cart, int productId, int quantity, boolean isUpdate) {
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;

        // Cerca se il prodotto è già nel carrello
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                if (isUpdate) {
                    item.setQuantity(quantity); // aggiornamento diretto
                } else {
                    item.setQuantity(item.getQuantity() + quantity); // aggiunta
                }
                found = true;
                break;
            }
        }

        // Se non trovato, crea nuovo CartItem
        if (!found) {
            Product product = productDAO.doRetrieveById(productId);
            if (product == null) {
                return null; // Prodotto non trovato
            }
            CartItem newItem = new CartItem(product.getProductId(), product.getProductName(), product.getPrice(), quantity);
            cart.add(newItem);
        }

        return cart;
    }

    /**
     * Rimuove un prodotto dal carrello
     * Spostato da CartUpdateServlet.java doPost() action="remove"
     */
    public List<CartItem> removeFromCart(List<CartItem> cart, int productId) {
        if (cart == null) {
            return new ArrayList<>();
        }

        for (int i = 0; i < cart.size(); i++) {
            if (cart.get(i).getProductId() == productId) {
                cart.remove(i);
                break;
            }
        }

        return cart;
    }

    /**
     * Calcola il numero totale di items nel carrello
     */
    public int calculateTotalItems(List<CartItem> cart) {
        if (cart == null) return 0;
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }

    /**
     * Trova la quantità precedente di un prodotto nel carrello
     * Usato per la risposta JSON di CartServlet
     */
    public int getLastQuantity(List<CartItem> cart, int productId) {
        if (cart == null) return 0;

        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                return item.getQuantity();
            }
        }
        return 0;
    }
}
