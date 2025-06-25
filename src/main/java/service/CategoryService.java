package service;

import jakarta.servlet.ServletContext;
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
	private final ServletContext context;

	public CategoryService(ServletContext context) {
		this.context = context;
		refreshCategoryCache();
	}


	public void checkCategoryCache() {
		Long lastUpdate = (Long) this.context.getAttribute("categoryCacheTimestamp");
		if (lastUpdate == null || System.currentTimeMillis() - lastUpdate > CACHE_EXPIRATION_MS) { // 1 ora
			refreshCategoryCache();
		}
	}

	/**
	 * Metodo privato per caricare o ricaricare la cache delle categorie.
	 */
	private void refreshCategoryCache() {
		CategoryDAO categoryDAO = new CategoryDAO();
		List<Category> allCategories = categoryDAO.doRetrieveAll();

		Map<Integer, Category> categoryMap = allCategories.stream()
				.collect(Collectors.toMap(Category::getCategoryId, Function.identity()));

		this.context.setAttribute("categoryCacheMap", categoryMap);
		this.context.setAttribute("categoryCacheTimestamp", System.currentTimeMillis());
	}

	public List<Category> buildBreadcrumbFromMap(Map<Integer, Category> categoryMap, int leafCategoryId) {
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
