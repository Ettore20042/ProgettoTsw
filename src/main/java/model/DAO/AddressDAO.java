package model.DAO;

import model.Bean.Address;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddressDAO {
    public void doSave(Address address) {
        try (Connection connection = ConnPool.getConnection()) {
            String sql = "INSERT INTO indirizzo (Provincia, Paese, Cap, NumeroCivico, Via, Città) VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, address.getProvince());
                preparedStatement.setString(2, address.getCountry());
                preparedStatement.setString(3, address.getPostalCode());
                preparedStatement.setString(4, address.getNumber());
                preparedStatement.setString(5, address.getStreet());
                preparedStatement.setString(6, address.getCity());
                preparedStatement.executeUpdate();

                // Recupero ID generato
                try (var resultSet = preparedStatement.getGeneratedKeys()) {
                    if (resultSet.next()) {
                        address.setIdAddress(resultSet.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Errore durante il salvataggio dell'indirizzo", e);
        }
    }
}
