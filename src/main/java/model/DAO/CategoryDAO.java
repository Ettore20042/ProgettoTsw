package model.DAO;

import model.Bean.Category;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> doRetrieveAll() {
        List<Category> categories = new ArrayList<>();

        try (Connection conn = ConnPool.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM category");
             ResultSet rs = ps.executeQuery()) {


            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setCategoryPath(rs.getString("CategoryPath"));

                // Handle potential NULL for parent_category
                int parentId = rs.getInt("ParentCategory");
                if (!rs.wasNull()) {
                    category.setParentCategory(parentId);
                }

                categories.add(category);
            }


        } catch (SQLException e) {
            System.err.println("CategoryDAO ERROR in doRetrieveAll: " + e.getMessage());
            e.printStackTrace();
        }

        return categories;
    }
}
