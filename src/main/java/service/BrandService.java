package service;

import jakarta.servlet.ServletContext;
import model.Bean.Brand;
import model.Bean.Product;
import model.DAO.BrandDAO;

import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class BrandService {
	private static final long CACHE_EXPIRATION_MS = 60 * 60 * 12 * 1000;
	private final ServletContext context;

	public BrandService(ServletContext context) {
		this.context = context;
	}

	public void checkBrandCache() {
		Long lastUpdate = (Long) context.getAttribute("brandCacheTimestamp");
		if (lastUpdate == null || System.currentTimeMillis() - lastUpdate > CACHE_EXPIRATION_MS) { // 1 ora
			refreshBrandCache();
		}
	}

	private void refreshBrandCache() {
		BrandDAO brandDAO = new BrandDAO();
		List<Brand> allBrands = brandDAO.doRetrieveAll();

		Map<Integer, Brand> brandMap = allBrands.stream()
				.collect(Collectors.toMap(Brand::getBrandId, Function.identity()));

		context.setAttribute("brandCacheMap", brandMap);
		context.setAttribute("brandCacheTimestamp", System.currentTimeMillis());
	}

	public List<Product> addBrandToProductBean(List<Product> productList) {
		if (productList == null || productList.isEmpty()) {
			return productList; // Restituisce la lista vuota se non ci sono prodotti
		}

		Map<Integer, Brand> brandCacheMap = (Map<Integer, Brand>) context.getAttribute("brandCacheMap");
		for (Product product : productList) {
			product.setBrand(brandCacheMap.get(product.getBrandId()));
		}
		return productList;
	}

	public List<Brand> getAllBrands() {
		BrandDAO brandDAO = new BrandDAO();
		return brandDAO.doRetrieveAll();
	}
}
