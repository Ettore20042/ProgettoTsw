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
}

