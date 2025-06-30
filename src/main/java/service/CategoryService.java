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
	private static final long CACHE_EXPIRATION_MS = 60 * 60 * 12 * 1000; /* definisce per quanto tempo la cache è considerata valida (in questo caso 12 ore) */
	private final ServletContext context; /* memorizziamo dati che devono essere accessibili da diverse parti del codice */

	public CategoryService(ServletContext context) {
		this.context = context;
		/* quando viene creato per la prima volta, viene immediatamente refreshato */
		refreshCategoryCache();
	}


	/* verifica se la cache è scaduta, e se sì, la aggiorna */
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

		/* la chiave della mappa è l'id della categoria mentre il valore è l'oggetto Category, ottenuto grazie a Function.identity() */
		Map<Integer, Category> categoryMap = allCategories.stream()
				.collect(Collectors.toMap(Category::getCategoryId, Function.identity()));

		/* salva la mappa e un timestamp(ora attuale) nel ServletContext. Il timestamp servirà per sapere quando la cache avrà bisogno di essere refreshata*/
		this.context.setAttribute("categoryCacheMap", categoryMap);
		this.context.setAttribute("categoryCacheTimestamp", System.currentTimeMillis());
	}

	/* ricostruisce il percorso di una categoria */
	public List<Category> buildBreadcrumbFromMap(Map<Integer, Category> categoryMap, int leafCategoryId) { /* prende in input la mappa della cache e l'ID della categoria foglia (la più specifica) */
		List<Category> breadcrumb = new ArrayList<>();
		if (categoryMap == null) return breadcrumb;

		/* parte dalla categoria foglia*/
		Integer currentId = leafCategoryId;
		while (currentId != null && currentId != 0) {
			/* usa la mappa per trovare l'oggetto Category corrispondente all'ID corrente*/
			Category cat = categoryMap.get(currentId);
			if (cat != null) {
				/* aggiunge la categoria alla lista e imposta currentId all'ID del genitore per risalire l'albero gerarchico*/
				breadcrumb.add(cat);
				currentId = cat.getParentCategory();
			} else {
				break;
			}
		}
		/* la lista viene restituita nell'ordine corretto*/
		Collections.reverse(breadcrumb);
		return breadcrumb;
	}

	public List<Category> getAllCategories() {
		return CategoryDAO.doRetrieveAll();
	}

	public List<Category> searchCategories(String query) {
		return CategoryDAO.findByNameLike(query);
	}

	public List<String> getSearchSuggestions(String query) {
		return CategoryDAO.searchCategoriesByName(query);
	}

    public Category getCategoryById(int categoryId) {
		checkCategoryCache(); // Assicura che la cache sia aggiornata
		Map<Integer, Category> categoryMap = (Map<Integer, Category>) context.getAttribute("categoryCacheMap");
		if (categoryMap != null) {
			return categoryMap.get(categoryId);
		}
		return null; // Se la categoria non è trovata nella cache
    }


	public Category updateCategory(int categoryId, String trim, String path) {
		CategoryDAO categoryDAO = new CategoryDAO();
		Category category = categoryDAO.doRetrieveById(categoryId);
		if (category != null) {
			category.setCategoryName(trim);
			category.setCategoryPath(path);
			if (categoryDAO.doUpdate(category)) {
				refreshCategoryCache(); // Ricarica la cache dopo l'aggiornamento
				return category;
			}
		}
		return null; // Se l'aggiornamento fallisce o la categoria non esiste
	}


	public Category addCategory(String categoryName, String categoryPath) {
		try {
			CategoryDAO categoryDAO = new CategoryDAO();
			Category newCategory = categoryDAO.doSave(categoryName, categoryPath);

			if (newCategory != null && newCategory.getCategoryId() > 0) {
				refreshCategoryCache(); // Ricarica la cache dopo l'aggiunta
				return newCategory;
			}
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean deleteCategory(int categoryId) {
		CategoryDAO categoryDAO = new CategoryDAO();
		Category category = categoryDAO.doRetrieveById(categoryId);
		if (category != null) {
			if (categoryDAO.doDelete(categoryId)) {
				refreshCategoryCache(); // Ricarica la cache dopo la cancellazione
				return true;
			}
		}
		return false; // Se la cancellazione fallisce o la categoria non esiste
	}
}
