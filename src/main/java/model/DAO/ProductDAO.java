package model.DAO;

import model.Bean.Brand;
import model.Bean.Product;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<Product> doRetrieveFirstNProducts(int n) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM product LIMIT ?");
            preparedStatement.setInt(1, n);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }

    }

    public Product doRetrieveById(int id) {
        try (Connection con = ConnPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE ProductID=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getFloat("Price"));
                p.setColor(rs.getString("Color"));
                p.setMaterial(rs.getString("Material"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setDescription(rs.getString("Description"));
                p.setSalePrice(rs.getFloat("salePrice"));
                p.setBrandId(rs.getInt("BrandID"));
                p.setCategoryId(rs.getInt("CategoryID"));
                return p;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Product> doRetrieveByBrandId(int id) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM product WHERE BrandID=?");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public List<Product> doRetrieveByCategoryId(int id) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * " +
                    "FROM product " +
                    "WHERE CategoryID = ? OR CategoryID IN (SELECT CategoryID FROM category WHERE ParentCategory = ?)");
            preparedStatement.setInt(1, id);
            preparedStatement.setInt(2, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public List<Product> doRetrieveBySalePrice() {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT * FROM product WHERE SalePrice > 0");

            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }


    public List<Product> doRetrieveAll() {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM product");
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public List<String> searchProductsByName(String name) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT ProductName FROM product WHERE ProductName LIKE ?");
            preparedStatement.setString(1, name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            List<String> productNames = new ArrayList<>();
            while (resultSet.next()) {
                productNames.add(resultSet.getString("ProductName"));
            }
            return productNames;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }


    public List<Product> findByNameLike(String name) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM product WHERE ProductName LIKE ?");
            preparedStatement.setString(1, "%" + name + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> products = new ArrayList<>();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }
            return products;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    public List<Product> getFilteredProducts(Integer category, Boolean isOffersPage, String[] brands, String[] colors, String[] materials, Float minPrice, Float maxPrice) {
        List<Product> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM product WHERE 1=1");

        List<Object> parameters = new ArrayList<>();

        // Filtro per categoria (corretto con AND)
        if (category != null) {
            query.append(" AND (CategoryID = ? OR CategoryID IN (SELECT CategoryID FROM category WHERE ParentCategory = ?))");
            parameters.add(category);
            parameters.add(category);
        }
        if (isOffersPage != null && isOffersPage) {
            query.append(" AND SalePrice > 0");
        }

        // Filtro per brand (usando IN per array)
        if (brands != null && brands.length > 0) {
            query.append(" AND BrandID IN (");
            addQueryParamFromList(brands, query, parameters);
        }

        // Filtro per colore (usando IN per array)
        if (colors != null && colors.length > 0) {
            query.append(" AND Color IN (");
            addQueryParamFromList(colors, query, parameters);
        }

        // Filtro per materiale (usando IN per array)
        if (materials != null && materials.length > 0) {
            query.append(" AND Material IN (");
            addQueryParamFromList(materials, query, parameters);
        }
        if (minPrice != null) {
            query.append(" AND Price >= ?");
            parameters.add(minPrice);
        }
        if (maxPrice != null) {
            query.append(" AND Price <= ?");
            parameters.add(maxPrice);
        }

        try (Connection connection = ConnPool.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query.toString())) {

            int index = 1;
            for (Object param : parameters) {
                preparedStatement.setObject(index++, param);
            }


            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setDescription(resultSet.getString("Description"));
                product.setPrice(resultSet.getFloat("Price"));
                product.setColor(resultSet.getString("Color"));
                product.setMaterial(resultSet.getString("Material"));
                product.setQuantity(resultSet.getInt("Quantity"));
                product.setSalePrice(resultSet.getFloat("SalePrice"));
                product.setBrandId(resultSet.getInt("BrandID"));
                product.setCategoryId(resultSet.getInt("CategoryID"));
                products.add(product);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    private void addQueryParamFromList(String[] items, StringBuilder query, List<Object> parameters) {
        for (int i = 0; i < items.length; i++) {
            query.append("?");
            if (i < items.length - 1) {
                query.append(",");
            }
            parameters.add(items[i]);
        }
        query.append(")");
    }

    public int addProduct(Product product) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO product (ProductName, Price, SalePrice, Description, CategoryID, Quantity, BrandID, Color) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setFloat(2, product.getPrice());
            preparedStatement.setDouble(3, product.getSalePrice());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setInt(5, product.getCategoryId());
            preparedStatement.setInt(6, product.getQuantity());
            preparedStatement.setInt(7, product.getBrandId());
            preparedStatement.setString(8, product.getColor());

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
    public boolean deleteProduct(int productId) {
        try (Connection connection = ConnPool.getConnection()) {
            System.out.println("Attempting to delete product with ID: " + productId);

            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM product WHERE ProductID = ?");
            preparedStatement.setInt(1, productId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean updateProduct(Product product) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE product SET ProductName=?, Price=?, SalePrice=?, Description=?, CategoryID=?, Quantity=?, BrandID=?, Color=? WHERE ProductID=?");
            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setFloat(2, product.getPrice());
            preparedStatement.setDouble(3, product.getSalePrice());
            preparedStatement.setString(4, product.getDescription());
            preparedStatement.setInt(5, product.getCategoryId());
            preparedStatement.setInt(6, product.getQuantity());
            preparedStatement.setInt(7, product.getBrandId());
            preparedStatement.setString(8, product.getColor());
            preparedStatement.setInt(9, product.getProductId());
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
    }

    /**
     * Recupera la lista di tutti i colori disponibili
     * @return Lista di colori unici
     */
    public List<String> getAllColors() {
        List<String> colors = new ArrayList<>();
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT DISTINCT Color FROM product WHERE Color IS NOT NULL AND Color != '' ORDER BY Color"
            );
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                colors.add(resultSet.getString("Color"));
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return colors;
    }

    /**
     * Recupera la lista di tutti i materiali disponibili
     * @return Lista di materiali unici
     */
    public List<String> getAllMaterials() {
        List<String> materials = new ArrayList<>();
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT DISTINCT Material FROM product WHERE Material IS NOT NULL AND Material != '' ORDER BY Material"
            );
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                materials.add(resultSet.getString("Material"));
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return materials;
    }

    /**
     * Recupera il prezzo massimo di tutti i prodotti
     * @return Prezzo massimo
     */
    public Float getMaxPrice() {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT MAX(Price) as maxPrice FROM product"
            );
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getFloat("maxPrice");
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return 0.0f;
    }

    public Float getMaxPrice(int categoryId) {
        try (Connection connection = ConnPool.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT MAX(Price) as maxPrice FROM product WHERE CategoryID = ?"
            );
            preparedStatement.setInt(1, categoryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getFloat("maxPrice");
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return 0.0f;
    }
}
