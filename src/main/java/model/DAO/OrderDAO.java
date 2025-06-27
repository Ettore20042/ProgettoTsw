package model.DAO;

import com.oracle.wls.shaded.org.apache.xpath.operations.Or;
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
                o.setOrderDate(LocalDate.parse(resultSet.getString("OrderDate")));
                o.setOrderTime(LocalTime.from(LocalDate.parse(resultSet.getString("OrderTime"))));
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

    public List<Order> doRetrieveLastOrders(int userId) {
        try(Connection connection = ConnPool.getConnection()){
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT o.OrderId, o.Status, o.OrderDate, oi.ProductID " +
                    "FROM orders o JOIN order_item oi ON o.OrderID = oi.OrderID " +
                    "WHERE o.OrderID IN (SELECT OrderID FROM orders WHERE UserID = ? ORDER BY OrderDate DESC LIMIT 4) " +
                    "ORDER BY o.OrderDate DESC, o.OrderID");
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();

            List<Order> orders = new ArrayList<>();
            Order currentOrder = null;
            List<OrderItem> currentItems = null;
            int lastOrderId = -1;

            while (rs.next()) {
                int orderId = rs.getInt("OrderID");

                if (orderId != lastOrderId) {
                    currentOrder = new Order();
                    currentOrder.setOrderId(orderId);
                    currentOrder.setStatus(rs.getString("Status"));
                    currentOrder.setOrderDate(LocalDate.parse(rs.getString("OrderDate")));

                    currentItems = new ArrayList<>();
                    currentOrder.setOrderItems(currentItems);

                    orders.add(currentOrder);
                    lastOrderId = orderId;
                }

                OrderItem item = new OrderItem();
                item.setProductId(rs.getInt("ProductID"));
                item.setOrderId(orderId);
                if (currentItems != null) {
                    currentItems.add(item);
                }
            }
            return orders;
        }catch (SQLException ex) {
            throw new RuntimeException(ex);
        }

    }
}
