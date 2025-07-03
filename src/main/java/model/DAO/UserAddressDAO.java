package model.DAO;

import model.Bean.Address;
import model.Bean.UserAddress;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserAddressDAO {

    public List<UserAddress> findByUserId(int userId) {
        List<UserAddress> userAddresses = new ArrayList<>();
        String sql = "SELECT a.*, ua.address_type, ua.is_primary, ua.address_nickname " +
                     "FROM user_address ua " +
                     "JOIN Address a ON ua.AddressID = a.AddressID " +
                     "WHERE ua.UserID = ?";

        try (Connection conn = ConnPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // 1. Crea l'oggetto Address
                Address address = new Address();
                address.setAddressId(rs.getInt("AddressID"));
                address.setStreet(rs.getString("Street"));
                address.setStreetNumber(rs.getString("StreetNumber"));
                address.setCity(rs.getString("City"));
                address.setProvince(rs.getString("Province"));
                address.setZipCode(rs.getString("ZipCode"));
                address.setCountry(rs.getString("Country"));

                // 2. Crea l'oggetto UserAddress
                UserAddress userAddress = new UserAddress();
                userAddress.setAddressType(rs.getString("address_type"));
                userAddress.setPrimary(rs.getBoolean("is_primary"));
                userAddress.setAddressNickname(rs.getString("address_nickname"));

                // 3. Collega i due oggetti
                userAddress.setAddress(address);

                userAddresses.add(userAddress);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return userAddresses;
    }


    public UserAddress doSave(UserAddress userAddress) {
        String sql = "INSERT INTO user_address (UserID, AddressID, address_type, is_primary, address_nickname) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConnPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userAddress.getUserId());
            ps.setInt(2, userAddress.getAddress().getAddressId());
            ps.setString(3, userAddress.getAddressType());
            ps.setBoolean(4, userAddress.isPrimary());
            ps.setString(5, userAddress.getAddressNickname());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return userAddress; // Ritorna l'oggetto salvato
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null; // Se non è stato salvato nulla

    }
}

