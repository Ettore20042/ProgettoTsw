package model.DAO;

import model.Bean.CartItem;
import model.Bean.Order;
import model.Bean.OrderItem;
import model.Bean.Product;
import model.ConnPool;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Currency;
import java.util.List;

public class OrderDAO {


    public List<Order> doRetrieveByUserId(int userId) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM orders WHERE UserID=?");
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Order> orders = new ArrayList<>();
            while (resultSet.next()) {
                Order o = new Order();
                o.setOrderId(resultSet.getInt("OrderID"));
                o.setStatus(resultSet.getString("Status"));
                o.setOrderDate(resultSet.getDate("OrderDate").toLocalDate());
                o.setOrderTime(resultSet.getTime("OrderTime").toLocalTime());
                o.setBillingAddressId(resultSet.getInt("BillingAddressID"));
                o.setShippingAddressId(resultSet.getInt("ShippingAddressID"));
                o.setTotalAmount(resultSet.getFloat("TotalAmount"));
                orders.add(o);
            }
            return orders;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }


    public List<Order> doRetrieveLastNOrdersByUserId(int userId) {
        try(Connection connection = ConnPool.getConnection()){
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM orders WHERE UserID=? ORDER BY OrderDate DESC, OrderTime DESC LIMIT 3");
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Order> orders = new ArrayList<>();
            while (resultSet.next()){
                Order o = new Order();
                o.setOrderId(resultSet.getInt("OrderID"));
                o.setStatus(resultSet.getString("Status"));
                o.setOrderDate(resultSet.getDate("OrderDate").toLocalDate());
                o.setOrderTime(resultSet.getTime("OrderTime").toLocalTime());
                o.setBillingAddressId(resultSet.getInt("BillingAddressID"));
                o.setShippingAddressId(resultSet.getInt("ShippingAddressID"));
                o.setTotalAmount(resultSet.getFloat("TotalAmount"));
                orders.add(o);
            }
            return orders;
        }catch (SQLException ex){
            throw new RuntimeException(ex);
        }
    }

    /**
     * Salva un nuovo ordine nel database
     * @param order L'ordine da salvare
     * @return true se il salvataggio ha successo, false altrimenti
     */
    public int doSave(Order order) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO orders (UserID, ShippingAddressID, BillingAddressID, TotalAmount, OrderDate, OrderTime, Status) VALUES (?, ?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getShippingAddressId());
            preparedStatement.setInt(3, order.getBillingAddressId());
            preparedStatement.setFloat(4, order.getTotalAmount());
            preparedStatement.setDate(5, Date.valueOf(order.getOrderDate()));
            preparedStatement.setTime(6, Time.valueOf(order.getOrderTime()));
            preparedStatement.setString(7, order.getStatus());
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return -1; // Indica che il salvataggio non è riuscito
    }


    public List<OrderItem> saveOrderItems(List<CartItem> cartItem, int orderId){
        List<OrderItem> orderItems = new ArrayList<>();
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO order_item (ProductID, OrderID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)");
            for (CartItem item : cartItem) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setProductId(item.getProductId());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setUnitPrice(item.getPrice());

                preparedStatement.setInt(1, item.getProductId());
                preparedStatement.setInt(2, orderId);
                preparedStatement.setInt(3, item.getQuantity());
                preparedStatement.setFloat(4, item.getPrice());

                preparedStatement.executeUpdate();
                orderItems.add(orderItem);
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return orderItems;
    }
}
