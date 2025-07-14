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
    public Address doSave(Address address) {
        try (Connection connection = ConnPool.getConnection()) {
            String sql = "INSERT INTO address (Province, Country, ZipCode, StreetNumber, Street, City) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, address.getProvince());
                preparedStatement.setString(2, address.getCountry());
                preparedStatement.setString(3, address.getZipCode());
                preparedStatement.setString(4, address.getStreetNumber());
                preparedStatement.setString(5, address.getStreet());
                preparedStatement.setString(6, address.getCity());

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        address.setAddressId(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log dettagliato dell'errore
            throw new RuntimeException("Errore durante il salvataggio dell'indirizzo: " + e.getMessage(), e);
        }
        return address;
}


    public boolean deleteAddress(String addressId, String addressType) {
        try (Connection connection = ConnPool.getConnection()) {
            String sql = "DELETE FROM user_address WHERE AddressID = ? AND address_type = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, addressId);
                preparedStatement.setString(2, addressType);
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    // Se l'indirizzo è stato rimosso da user_address, procediamo a rimuoverlo da address
                    sql = "DELETE FROM address WHERE AddressID = ?";
                    try (PreparedStatement deleteAddressStmt = connection.prepareStatement(sql)) {
                        deleteAddressStmt.setString(1, addressId);
                        deleteAddressStmt.executeUpdate();
                    }
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log dettagliato dell'errore
            throw new RuntimeException("Errore durante l'eliminazione dell'indirizzo: " + e.getMessage(), e);
        }
        return false;

    }
}
