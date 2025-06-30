package model.DAO;

import model.Bean.Brand;
import model.Bean.Category;
import model.Bean.Image;
import model.ConnPool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {
	public Brand doRetrieveById(int id) {
		try(Connection conn= ConnPool.getConnection()) {
			String sql = "SELECT * FROM brand WHERE BrandID = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			Brand brand = new Brand();
			while (rs.next()) {
				brand.setBrandId(rs.getInt("BrandID"));
				brand.setBrandName(rs.getString("BrandName"));
				brand.setLogoPath(rs.getString("LogoPath"));
			}
			return brand;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<Brand> doRetrieveAll() {
		List<Brand> brands = new ArrayList<>();

		try (Connection conn = ConnPool.getConnection();
			 PreparedStatement ps = conn.prepareStatement("SELECT * FROM brand");
			 ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Brand brand = new Brand();
				brand.setBrandId(rs.getInt("BrandID"));
				brand.setBrandName(rs.getString("BrandName"));
				brand.setLogoPath(rs.getString("LogoPath"));
				brands.add(brand);
			}

		} catch (SQLException e) {
			System.err.println("BrandDAO ERROR in doRetrieveAll: " + e.getMessage());
			e.printStackTrace();
		}

		return brands;
	}
	public  List<Brand> doRetrieveByName(String name) {
		List<Brand> brands = new ArrayList<>();
		try (Connection conn = ConnPool.getConnection();
			 PreparedStatement ps = conn.prepareStatement("SELECT * FROM brand WHERE BrandName LIKE ?")) {
			ps.setString(1, "%" + name + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Brand brand = new Brand();
				brand.setBrandId(rs.getInt("BrandID"));
				brand.setBrandName(rs.getString("BrandName"));
				brand.setLogoPath(rs.getString("LogoPath"));
				brands.add(brand);
			}
		} catch (SQLException e) {
			System.err.println("BrandDAO ERROR in doRetrieveByName: " + e.getMessage());
			e.printStackTrace();
		}
		return brands;
	}
	public Brand doSave(Brand brand) {
		String sql = "INSERT INTO brand (BrandName, LogoPath) VALUES (?, ?)";
		try (Connection conn = ConnPool.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, brand.getBrandName());
			ps.setString(2, brand.getLogoPath());

			int affectedRows = ps.executeUpdate();
			if (affectedRows > 0) {
				try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						brand.setBrandId(generatedKeys.getInt(1));
						return brand;
					}
				}
			}
		} catch (SQLException e) {
			System.err.println("BrandDAO ERROR in doSave: " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public boolean doDelete(int brandId) {
		String sql = "DELETE FROM brand WHERE BrandID = ?";
		try (Connection conn = ConnPool.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, brandId);
			int affectedRows = ps.executeUpdate();
			System.out.println("BrandDAO: doDelete - righe eliminate: " + affectedRows);
			return affectedRows > 0;
		} catch (SQLException e) {
			System.err.println("BrandDAO ERROR in doDelete: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}

	public Brand doUpdate(Brand brand) {
		String sql = "UPDATE brand SET BrandName = ?, LogoPath = ? WHERE BrandID = ?";
		try (Connection conn = ConnPool.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, brand.getBrandName());
			ps.setString(2, brand.getLogoPath());
			ps.setInt(3, brand.getBrandId());

			int affectedRows = ps.executeUpdate();
			if (affectedRows > 0) {
				System.out.println("BrandDAO: doUpdate - brand aggiornato: " + brand.getBrandId());
				return brand;
			}
		} catch (SQLException e) {
			System.err.println("BrandDAO ERROR in doUpdate: " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
