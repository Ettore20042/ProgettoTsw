package service;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import model.Bean.Category;
import model.DAO.CategoryDAO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class CategoryService {
	private static final long CACHE_EXPIRATION_MS = 60 * 60 * 12 * 1000;

	public CategoryService(ServletContext context) {
		refreshCategoryCache(context);
	}


	public static void checkCategoryCache(ServletContext context) {
		Long lastUpdate = (Long) context.getAttribute("categoryCacheTimestamp");
		if (lastUpdate == null || System.currentTimeMillis() - lastUpdate > CACHE_EXPIRATION_MS) { // 1 ora
			refreshCategoryCache(context);
		}
	}

	/**
	 * Metodo statico e pubblico per caricare o ricaricare la cache delle categorie.
	 * Può essere chiamato dall'init() o da qualsiasi altra servlet quando necessario.
	 * @param context Il ServletContext in cui memorizzare i dati.
	 */
	private static void refreshCategoryCache(ServletContext context) {
		CategoryDAO categoryDAO = new CategoryDAO();
		List<Category> allCategories = categoryDAO.doRetrieveAll();

		Map<Integer, Category> categoryMap = allCategories.stream()
				.collect(Collectors.toMap(Category::getCategoryId, Function.identity()));

		context.setAttribute("categoryCacheMap", categoryMap);
		context.setAttribute("categoryCacheTimestamp", System.currentTimeMillis());
	}

	public static List<Category> buildBreadcrumbFromMap(Map<Integer, Category> categoryMap, int leafCategoryId) {
		List<Category> breadcrumb = new ArrayList<>();
		if (categoryMap == null) return breadcrumb;

		Integer currentId = leafCategoryId;
		while (currentId != null && currentId != 0) {
			Category cat = categoryMap.get(currentId);
			if (cat != null) {
				breadcrumb.add(cat);
				currentId = cat.getParentCategory();
			} else {
				break;
			}
		}
		Collections.reverse(breadcrumb);
		return breadcrumb;
	}
}
