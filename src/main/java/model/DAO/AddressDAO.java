package model.DAO;

import model.Bean.Address;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}}
