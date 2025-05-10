package model.DAO;

import model.Bean.User;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAO {
    public void doSaveUser(User user) {
        try(Connection conn = ConnPool.getConnection()) {
            String sql = "INSERT INTO useraccount (FirstName,LastName,Phone,Email,Password) VALUES (?, ?, ?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPassword());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
    }
}
    public Boolean doLogin(String email, String password) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM useraccount WHERE Email = ? AND Password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            return ps.executeQuery().next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
