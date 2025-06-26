package model.DAO;

import model.Bean.Image;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class ImageDAO {
    public List<Image> doRetrieveAllByProduct(int id) {
        try(Connection conn= ConnPool.getConnection()) {
            String sql = "SELECT * FROM image WHERE ProductID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            List<Image> images = new ArrayList<>();
            while (rs.next()) {
                Image image = new Image();
                image.setImageId(rs.getInt("ImageID"));
                image.setProductId(rs.getInt("ProductID"));
                image.setImageDescription(rs.getString("ImageDescription"));
                image.setDisplayOrder(rs.getInt("DisplayOrder"));
                image.setImagePath("/" + rs.getString("ImagePath"));
                images.add(image);
            }
         return images;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Image doRetrieveFirstByProduct(int id) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM image WHERE ProductID = ? ORDER BY DisplayOrder LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Image image = new Image();
                image.setImageId(rs.getInt("ImageID"));
                image.setProductId(rs.getInt("ProductID"));
                image.setImageDescription(rs.getString("ImageDescription"));
                image.setDisplayOrder(rs.getInt("DisplayOrder"));
                image.setImagePath("/" + rs.getString("ImagePath"));
                return image;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean addImage(int productId, String imagePath, String imageDescription, int displayOrder) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "INSERT INTO image (ProductID, ImagePath, ImageDescription, DisplayOrder) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.setString(2, imagePath);
            ps.setString(3, imageDescription);
            ps.setInt(4, displayOrder);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Restituisce true se almeno una riga è stata inserita
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}