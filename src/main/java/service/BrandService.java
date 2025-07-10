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
		checkBrandCache(); // Inizializza la cache al momento della creazione del servizio
	}


	/* aggiorna la cache */
	public void checkBrandCache() {
		Long lastUpdate = (Long) context.getAttribute("brandCacheTimestamp");
		if (lastUpdate == null || System.currentTimeMillis() - lastUpdate > CACHE_EXPIRATION_MS) { // 1 ora
			refreshBrandCache();
		}
	}

	private void refreshBrandCache() {
		BrandDAO brandDAO = new BrandDAO();
		List<Brand> allBrands = brandDAO.doRetrieveAll();

		/* usa la mappa per memorizzare i brand, la chiave è l'id del brand, il valore è l'oggetto Brand */
		Map<Integer, Brand> brandMap = allBrands.stream()
				.collect(Collectors.toMap(Brand::getBrandId, Function.identity()));

		/* salva la mappa e l'ora corrente di aggiornamento della cache nel ServletContext */
		context.setAttribute("brandCacheMap", brandMap);
		context.setAttribute("brandCacheTimestamp", System.currentTimeMillis());
	}

	/* arricchisce la lista di oggetti Product con i dati completi del loro brand */
	public List<Product> addBrandToProductBean(List<Product> productList) {
		if (productList == null || productList.isEmpty()) {
			return productList; // Restituisce la lista vuota se non ci sono prodotti
		}

		/* recupera la mappa dei brand dalla cache del ServletContext*/
		Map<Integer, Brand> brandCacheMap = (Map<Integer, Brand>) context.getAttribute("brandCacheMap");
		for (Product product : productList) { /* per ogni prodotto, prende l'id del suo brand e usa questo id per cercare l'oggetto Brand corrispondente nella mappa */
			product.setBrand(brandCacheMap.get(product.getBrandId()));
		}
		return productList;
	}

	public List<Brand> getAllBrands() {
		BrandDAO brandDAO = new BrandDAO();
		List<Brand> brands = brandDAO.doRetrieveAll();
		return brands;
	}
	public List<Brand> searchBrands(String name) {
		BrandDAO brandDAO = new BrandDAO();
		return brandDAO.doRetrieveByName(name);
	}

	public Brand addBrand(String name, String logoPath) {
		BrandDAO brandDAO = new BrandDAO();
		Brand brand = new Brand();
		brand.setBrandName(name);
		brand.setLogoPath(logoPath);

		Brand savedBrand = brandDAO.doSave(brand);
		if (savedBrand != null) {
			// Refresh cache after adding new brand
			refreshBrandCache();
			return savedBrand;
		}
		return null;
	}

	public boolean deleteBrand(int brandId) {
		BrandDAO brandDAO = new BrandDAO();
		boolean deleted = brandDAO.doDelete(brandId);
		if (deleted) {
			// Refresh cache after deleting brand
			refreshBrandCache();
		}
		return deleted;
	}

	public Brand getBrandById(int brandId) {
		BrandDAO brandDAO = new BrandDAO();
		return brandDAO.doRetrieveById(brandId);
	}

	public Brand updateBrand(int brandId, String name, String logoPath) {
		BrandDAO brandDAO = new BrandDAO();
		Brand brand = new Brand();
		brand.setBrandId(brandId);
		brand.setBrandName(name);
		brand.setLogoPath(logoPath);

		Brand updatedBrand = brandDAO.doUpdate(brand);
		if (updatedBrand != null) {
			// Refresh cache after updating brand
			refreshBrandCache();
			return updatedBrand;
		}
		return null;
	}

	public List<String> getBrandSuggestions(String query) {
		checkBrandCache(); // Assicurati che la cache sia aggiornata
		Map<Integer, Brand> brandCacheMap = (Map<Integer, Brand>) context.getAttribute("brandCacheMap");

		if (brandCacheMap == null || brandCacheMap.isEmpty()) {
			return List.of(); // Restituisce una lista vuota se la cache è vuota
		}

		return brandCacheMap.values().stream()
				.filter(brand -> brand.getBrandName().toLowerCase().contains(query.toLowerCase()))
				.map(Brand::getBrandName)
				.collect(Collectors.toList());
	}
}
