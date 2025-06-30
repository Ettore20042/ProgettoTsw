package model.DAO;

import model.Bean.Category;
import model.Bean.User;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public static List<Category> doRetrieveAll() {
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

    public static List<Category> findByNameLike(String name) {
        try (Connection con = ConnPool.getConnection()) {
            String sql = "SELECT * FROM category WHERE CategoryName LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            List<Category> categories = new ArrayList<>();
            while(rs.next()){
                Category c = new Category();
                c.setCategoryId(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                c.setCategoryPath(rs.getString("CategoryPath"));
                c.setParentCategory(rs.getInt("ParentCategory"));
                categories.add(c);
            }
            return categories;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static List<String> searchCategoriesByName(String name) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT CategoryName FROM category WHERE CategoryName LIKE ?");
            preparedStatement.setString(1, name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            List<String> categoriesNames = new ArrayList<>();
            while (resultSet.next()) {
               categoriesNames.add(resultSet.getString("CategoryName"));
            }
            return categoriesNames;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }
}
