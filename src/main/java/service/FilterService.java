package service;

import com.google.gson.Gson;
import com.mysql.cj.Session;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Bean.Brand;
import model.Bean.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FilterService {

	private ProductService productService;
	private BrandService brandService;
	private ServletContext context;

	public FilterService(ServletContext context) {
		productService = new ProductService(context);
		brandService = new BrandService(context);
		this.context = context;
		HttpSession session = (HttpSession) context.getAttribute("session");
	}

	public Map<String, Object> loadFilterData(Integer categoryId) {
		Float priceMax = 0f;

		// Assicurati che la cache dei brand sia aggiornata
		brandService.checkBrandCache();

		// Recupera tutti i dati per i filtri
		Map<Integer, Brand> brandCacheMap = (Map<Integer, model.Bean.Brand>)
				context.getAttribute("brandCacheMap");
		List<String> colorsList = productService.getAllColors();
		List<String> materialsList = productService.getAllMaterials();
		if (categoryId != null) {
			priceMax = productService.getMaxPrice(categoryId);
		} else {
			priceMax = productService.getMaxPrice();
		}

		// Crea un oggetto con tutti i dati dei filtri
		Map<String, Object> filterData = new HashMap<>();
		filterData.put("brands", brandCacheMap);
		filterData.put("colors", colorsList);
		filterData.put("materials", materialsList);
		filterData.put("priceMax", priceMax);

		return filterData;
	}

	public List<Product> getFilteredProducts(Integer categoryIdParam, Boolean isOffersPage, String[] brandIdParams,
	                                 String[] colorParams, String[] materialParams, Float minPrice, Float maxPrice) {
		return productService.getFilteredProducts(
				categoryIdParam, isOffersPage, brandIdParams, colorParams, materialParams, minPrice, maxPrice);

	}

}