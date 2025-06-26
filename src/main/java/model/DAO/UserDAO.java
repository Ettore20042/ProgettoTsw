package model.DAO;

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
            String sql = "INSERT INTO user_account (FirstName, LastName, Email, Password, IsAdmin, PhoneNumber) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setBoolean(5, user.isAdmin());
            ps.setString(6, user.getPhoneNumber());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public User doLogin(String email, String plainPassword) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM user_account WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                String storedHash = resultSet.getString("Password");

                if (BCrypt.checkpw(plainPassword, storedHash)) {
                    User user = new User();
                    user.setUserId(resultSet.getInt("UserID"));
                    user.setFirstName(resultSet.getString("FirstName"));
                    user.setLastName(resultSet.getString("LastName"));
                    user.setPhoneNumber(resultSet.getString("Phone"));
                    user.setAdmin(resultSet.getBoolean("Admin"));
                    user.setEmail(resultSet.getString("Email"));
                    return user;
                } else {
                    return null;
                }
            } else {
                return null;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean isEmailAlreadyUsed(String email) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM user_account WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet resultSet = ps.executeQuery();
            return resultSet.next();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<User> doRetrieveAll() {
        List<User> users = new ArrayList<>();
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM user_account";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("UserID"));
                user.setFirstName(resultSet.getString("FirstName"));
                user.setLastName(resultSet.getString("LastName"));
                user.setPhoneNumber(resultSet.getString("Phone"));
                user.setAdmin(resultSet.getBoolean("Admin"));
                user.setEmail(resultSet.getString("Email"));
                user.setPassword(resultSet.getString("Password"));
                users.add(user);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "UPDATE user_account SET Password = ? WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public User doRetrieveByEmail(String email) {
        try (Connection con = ConnPool.getConnection()) {
            String sql = "SELECT * FROM user_account WHERE Email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User p = new User();
                p.setUserId(rs.getInt("UserID"));
                p.setFirstName(rs.getString("FirstName"));
                p.setLastName(rs.getString("LastName"));
                p.setEmail(rs.getString("Email"));
                p.setPassword(rs.getString("Password"));
                p.setAdmin(rs.getBoolean("Admin"));
                p.setPhoneNumber(rs.getString("PhoneNumber"));
                return p;
            }
            return null;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
