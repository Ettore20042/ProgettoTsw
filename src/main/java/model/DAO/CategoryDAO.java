package model.DAO;

import model.Bean.Category;
import model.Bean.User;
import model.ConnPool;

import java.sql.*;
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

    public Category doRetrieveById(int categoryId) {
        try (Connection conn = ConnPool.getConnection()) {
            String sql = "SELECT * FROM category WHERE CategoryID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                category.setCategoryPath(rs.getString("CategoryPath"));
                category.setParentCategory(rs.getInt("ParentCategory"));
                return category;
            }
        } catch (SQLException e) {
            System.err.println("CategoryDAO ERROR in doRetrieveById: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Return null if no category found
    }

    public boolean doUpdate(Category category) {
        String sql = "UPDATE category SET CategoryName = ?, CategoryPath = ? WHERE CategoryID = ?";
        try (Connection conn = ConnPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getCategoryPath());
            ps.setInt(3, category.getCategoryId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("CategoryDAO ERROR in doUpdate: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public boolean doDelete(int categoryId) {
        String sql = "DELETE FROM category WHERE CategoryID = ?";
        try (Connection conn = ConnPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0; // Returns true if the delete was successful

        } catch (SQLException e) {
            System.err.println("CategoryDAO ERROR in doDelete: " + e.getMessage());
            e.printStackTrace();
            return false; // Return false if an error occurs
        }
    }


        public Category doSave(String categoryName, String categoryPath) {
            try (Connection conn = ConnPool.getConnection()) {
                String sql = "INSERT INTO category (CategoryName, CategoryPath) VALUES (?, ?)";

                // ✅ IMPORTANTE: Aggiungi Statement.RETURN_GENERATED_KEYS
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, categoryName);
                ps.setString(2, categoryPath);

                int affectedRows = ps.executeUpdate();

                if (affectedRows > 0) {
                    // ✅ Recupera l'ID generato
                    ResultSet generatedKeys = ps.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int categoryId = generatedKeys.getInt(1);

                        // ✅ Crea e restituisci la categoria con l'ID corretto
                        Category newCategory = new Category();
                        newCategory.setCategoryId(categoryId);
                        newCategory.setCategoryName(categoryName);
                        newCategory.setCategoryPath(categoryPath);
                        return newCategory;
                    }
                }

                return null;

            } catch (SQLException e) {
                e.printStackTrace();
                return null;
            }
        }

}
