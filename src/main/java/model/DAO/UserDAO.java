package model.DAO;

import model.Bean.User;
import model.ConnPool;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public User doSaveUser(String firstName, String lastName, String phoneNumber, String password, String email) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "INSERT INTO user_account (FirstName, LastName, Phone, Password, Email) VALUES (?, ?, ?, ?, ?)";

            // Chiedi di restituire la chiave generata (es. user_id)
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, phoneNumber);
            ps.setString(4, password);
            ps.setString(5, email);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int generatedId = rs.getInt(1); // o rs.getLong(1) se l'ID è LONG
                    return doRetrieveById(generatedId); // questo metodo deve esistere nel DAO
                }
            }
            return null;
        } catch (SQLException e) {
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

    public List<User> findByEmailLike(String email) {
        try (Connection con = ConnPool.getConnection()) {
            String sql = "SELECT * FROM user_account WHERE Email LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + email + "%");
            ResultSet rs = ps.executeQuery();
            List<User> users = new ArrayList<>();
            while(rs.next()){
                User p = new User();
                p.setUserId(rs.getInt("UserID"));
                p.setFirstName(rs.getString("FirstName"));
                p.setLastName(rs.getString("LastName"));
                p.setEmail(rs.getString("Email"));
                p.setPassword(rs.getString("Password"));
                p.setAdmin(rs.getBoolean("Admin"));
                p.setPhoneNumber(rs.getString("Phone"));
                users.add(p);
            }
            return users;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public List<User> findByNameLike(String name) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM user_account WHERE FirstName LIKE ?");
            preparedStatement.setString(1, "%" + name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            List<User> users = new ArrayList<>();
            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("UserID"));
                user.setFirstName(resultSet.getString("FirstName"));
                user.setLastName(resultSet.getString("LastName"));
                user.setEmail(resultSet.getString("Email"));
                user.setPassword(resultSet.getString("Password"));
                user.setAdmin(resultSet.getBoolean("Admin"));
                user.setPhoneNumber(resultSet.getString("Phone"));
                users.add(user);
            }
            return users;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
    public User doRetrieveById(int userId) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM user_account WHERE UserID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
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
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public boolean doUpdateAdminStatus(User user) {
        try(Connection conn = ConnPool.getConnection()) {
            // Aggiorna solo lo status admin invece di tutti i campi
            String sql = "UPDATE user_account SET Admin = ? WHERE UserID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, user.isAdmin());
            ps.setInt(2, user.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
