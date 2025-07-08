package model.DAO;

import model.Bean.Order;
import model.Bean.OrderItem;
import model.Bean.Product;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
     * @param Order L'ordine da salvare
     * @return true se il salvataggio ha successo, false altrimenti
     */
    public Order doSave(String status,float totalAmount, int userId, int shippingAddressId, int billingAddressId) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO orders (UserID, ShippingAddressID, BillingAddressID, TotalAmount, OrderDate, OrderTime, Status) VALUES (?, ?, ?, ?, ?, ?, ?)");
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, shippingAddressId);
            preparedStatement.setInt(3, billingAddressId);
            preparedStatement.setFloat(4, totalAmount);
            preparedStatement.setDate(5, java.sql.Date.valueOf(LocalDate.now()));
            preparedStatement.setTime(6, java.sql.Time.valueOf(LocalTime.now()));
            preparedStatement.setString(7, status);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                Order order = new Order();
                order.setOrderId(preparedStatement.getGeneratedKeys().getInt(1));
                order.setStatus(status);
                order.setTotalAmount(totalAmount);
                order.setUserId(userId);
                order.setShippingAddressId(shippingAddressId);
                order.setBillingAddressId(billingAddressId);
                order.setOrderDate(LocalDate.now());
                order.setOrderTime(LocalTime.now());
                return order;

            } else {
                return null;
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }


    }
}
