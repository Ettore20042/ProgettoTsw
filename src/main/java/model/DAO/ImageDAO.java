package model.DAO;

import model.Bean.Image;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class ImageDAO {
    public List<Image> doRetrieveById(int id) {
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
                image.setImagePath(rs.getString("ImagePath"));
                images.add(image);
            }
         return images;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}