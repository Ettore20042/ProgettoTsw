package model.DAO;

import model.Bean.OrderItem;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {
    public List<OrderItem> doRetrieveByOrderID(int orderID) {
        try(Connection connection = ConnPool.getConnection()){
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM order_item WHERE orderID=?");
            preparedStatement.setInt(1, orderID);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<OrderItem> orderItems = new ArrayList<>();
            while (resultSet.next()){
                OrderItem orderItem = new OrderItem();
                orderItem.setProductId(resultSet.getInt("ProductID"));
                orderItem.setOrderId(resultSet.getInt("OrderID"));
                orderItem.setQuantity(resultSet.getInt("Quantity"));
                orderItem.setUnitPrice(Float.parseFloat(resultSet.getString("UnitPrice")));
                orderItems.add(orderItem);
            }
            return orderItems;
        }catch (SQLException ex){
            throw new RuntimeException(ex);
        }
    }
}
