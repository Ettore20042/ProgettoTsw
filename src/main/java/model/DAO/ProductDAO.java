package model.DAO;

import model.Bean.Product;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<Product> doRetrieveFirstNProducts(int n) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT ProductID,ProductName,Description,Price FROM product LIMIT ?");
            preparedStatement.setInt(1, n);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }

    }

}