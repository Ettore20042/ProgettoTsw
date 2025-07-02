package model.DAO;

import model.Bean.Address;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {
    public void doSave(Address address) {
        try (Connection connection = ConnPool.getConnection()) {
            String sql = "INSERT INTO address(Province, Country, ZipCode, StreetNumber, Street, City) VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, address.getProvince());
                preparedStatement.setString(2, address.getCountry());
                preparedStatement.setString(3, address.getZipCode());
                preparedStatement.setString(4, address.getStreetNumber());
                preparedStatement.setString(5, address.getStreet());
                preparedStatement.setString(6, address.getCity());
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    // Recupero ID generato
                    try (ResultSet resultSet = preparedStatement.getGeneratedKeys()) {
                        if (resultSet.next()) {
                            address.setAddressId(resultSet.getInt(1));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log dettagliato dell'errore
            throw new RuntimeException("Errore durante il salvataggio dell'indirizzo: " + e.getMessage(), e);
        }
}

    public List<Address> doRetrieveByUserId(int userid) {
        try (Connection connection = ConnPool.getConnection()) {
            String sql = "SELECT * FROM address a, user_address ua WHERE UserID = ? AND a.AddressID = ua.AddressID";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, userid);
                ResultSet resultSet = preparedStatement.executeQuery();
                List<Address> addresses = new ArrayList<>();
                while (resultSet.next()) {
                    Address address = new Address();
                    address.setAddressId(resultSet.getInt("AddressID"));
                    address.setProvince(resultSet.getString("Province"));
                    address.setCountry(resultSet.getString("Country"));
                    address.setZipCode(resultSet.getString("ZipCode"));
                    address.setStreetNumber(resultSet.getString("StreetNumber"));
                    address.setStreet(resultSet.getString("Street"));
                    address.setCity(resultSet.getString("City"));
                    addresses.add(address);
                }
                return addresses;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log dettagliato dell'errore
            throw new RuntimeException("Errore durante il recupero degli indirizzi: " + e.getMessage(), e);
        }
    }
}
