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
}
