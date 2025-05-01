package model.DAO;

import model.Bean.Image;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ImageDAO {
    public Image doRetrievebyId(int id) {
        try(Connection conn= ConnPool.getConnection()) {
            String sql = "SELECT * FROM image WHERE ProductID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            Image image = new Image();
            if (rs.next()) {
                image.setImageId(rs.getInt("ImageID"));
                image.setProductId(rs.getInt("ProductID"));
                image.setImageDescription(rs.getString("ImageDescription"));
                image.setDisplayOrder(rs.getInt("DisplayOrder"));
                image.setImagePath(rs.getString("ImagePath"));
            }
         return image;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}