package model.DAO;

import model.Bean.Product;
import model.Bean.User;
import model.ConnPool;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public void doSaveUser(User user) {
        try (Connection conn = ConnPool.getConnection()) {
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

    public User doLogin(String email, String plainPassword) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM useraccount WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                String storedHash = resultSet.getString("Password");

                // Verifica la password usando BCrypt
                if (BCrypt.checkpw(plainPassword, storedHash)) {
                    User user = new User();
                    user.setUserId(resultSet.getInt("UserID"));
                    user.setFirstName(resultSet.getString("FirstName"));
                    user.setLastName(resultSet.getString("LastName"));
                    user.setPhone(resultSet.getString("Phone"));
                    user.setAdmin(resultSet.getBoolean("Admin"));
                    user.setEmail(resultSet.getString("Email"));
                    return user;
                } else {
                    // Password errata
                    return null;
                }
            } else {
                // Nessun utente trovato
                return null;
            }
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

    public List<User> doRetrieveAll() {
        List<User> users = new ArrayList<>();
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM useraccount";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("UserID"));
                user.setFirstName(resultSet.getString("FirstName"));
                user.setLastName(resultSet.getString("LastName"));
                user.setPhone(resultSet.getString("Phone"));
                user.setAdmin(resultSet.getBoolean("Admin"));
                user.setEmail(resultSet.getString("Email"));
                user.setPassword(resultSet.getString("Password"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {
        try (Connection conn = ConnPool.getConnection()) {

            String sql = "UPDATE useraccount SET Password = ? WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;

        }
    }
}
