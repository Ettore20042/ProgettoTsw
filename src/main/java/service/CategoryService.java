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
}
