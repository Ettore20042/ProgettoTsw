package model.DAO;

import model.Bean.Product;
import model.Bean.User;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    public void doSaveUser(User user) {
        try(Connection conn = ConnPool.getConnection()) {
            String sql = "INSERT INTO useraccount (FirstName,LastName,Admin,Phone,Email,Password) VALUES (?, ?,?, ?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setBoolean(3, user.isAdmin());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getPassword());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
    }
}
public User doLogin(String email, String password) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM useraccount WHERE Email = ? AND Password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet resultSet = ps.executeQuery();
            resultSet.next();
            User user = new User();
            user.setUserId(resultSet.getInt("UserID"));
            user.setFirstName(resultSet.getString("FirstName"));
            user.setLastName(resultSet.getString("LastName"));
            user.setPhone(resultSet.getString("Phone"));
            user.setAdmin(resultSet.getBoolean("Admin"));
            user.setEmail(resultSet.getString("Email"));
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public boolean isEmailAlreadyUsed(String email) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM useraccount WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet resultSet = ps.executeQuery();
            return resultSet.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
