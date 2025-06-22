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

	public BrandService(ServletContext context) {
		refreshBrandCache(context);
	}


	public static void checkBrandCache(ServletContext context) {
		Long lastUpdate = (Long) context.getAttribute("brandCacheTimestamp");
		if (lastUpdate == null || System.currentTimeMillis() - lastUpdate > CACHE_EXPIRATION_MS) { // 1 ora
			refreshBrandCache(context);
		}
	}

	/**
	 * Metodo statico e pubblico per caricare o ricaricare la cache dei brand.
	 * Può essere chiamato dall'init() o da qualsiasi altra servlet quando necessario.
	 * @param context Il ServletContext in cui memorizzare i dati.
	 */
	private static void refreshBrandCache(ServletContext context) {
		BrandDAO brandDAO = new BrandDAO();
		List<Brand> allCategories = brandDAO.doRetrieveAll();

		Map<Integer, Brand> brandMap = allCategories.stream()
				.collect(Collectors.toMap(Brand::getBrandId, Function.identity()));

		context.setAttribute("brandCacheMap", brandMap);
		context.setAttribute("brandCacheTimestamp", System.currentTimeMillis());
	}

	public static List<Product> addBrandToProductBean(List<Product> productList, ServletContext context) {
		if (productList == null || productList.isEmpty()) {
			return productList; // Restituisce la lista vuota se non ci sono prodotti
		}

		Map<Integer, Brand> brandCacheMap = (Map<Integer, Brand>) context.getAttribute("brandCacheMap");
		for (Product product : productList) {
			product.setBrand(brandCacheMap.get(product.getBrandId()));
		}
		return productList;
	}
}
