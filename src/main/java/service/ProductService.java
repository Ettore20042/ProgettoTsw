package service;

import jakarta.servlet.ServletContext;
import model.Bean.Image;
import model.Bean.Product;
import model.DAO.ProductDAO;

import java.util.List;

public class ProductService {
    private final ProductDAO productDAO;
    private final ImageService imageService;
    private final BrandService brandService;
    private final ServletContext context;

    public ProductService(ServletContext context) {
        this.productDAO = new ProductDAO();
        this.imageService = new ImageService(context);
        this.brandService = new BrandService(context);
        this.context = context;
    }

    public int addProduct(Product product) {
        return productDAO.addProduct(product);
    }

    /**
     * Recupera un prodotto completo di tutte le sue informazioni, inclusi brand e immagini.
     * @param productId L'ID del prodotto da recuperare.
     * @return Un oggetto Product completo, o null se il prodotto non viene trovato.
     */
    public Product getFullProductDetails(int productId) {
        Product product = productDAO.doRetrieveById(productId);
        if (product != null) {
            List<Image> images = imageService.getImagesByProductId(productId);
            product.setImages(images);
            /* recupera informazioni sul brand e le associa all'oggetto */
            brandService.addBrandToProductBean(List.of(product));
        }
        return product;
    }

    /**
     * Recupera una lista di prodotti filtrata e arricchita con le informazioni sul brand.
     * @param categoryId L'ID della categoria.
     * @param brandsId L'ID del brand.
     * @param colors Il colore.
     * @param materials Il materiale.
     * @param minPrice Il prezzo minimo.
     * @param maxPrice Il prezzo massimo.
     * @return Una lista di prodotti che soddisfano i criteri di filtro.
     */
    public List<Product> getFilteredProducts(Integer categoryId, String[] brandsId, String[] colors, String[] materials, Float minPrice, Float maxPrice) {
        List<Product> productList = productDAO.getFilteredProducts(categoryId, brandsId, colors, materials, minPrice, maxPrice);
        brandService.addBrandToProductBean(productList);
        return productList;
    }

    /**
     * Recupera una lista di prodotti associati a un determinato brand.
     *
     * @param brandId L'ID del brand per cui recuperare i prodotti.
     * @return Una lista di oggetti Product associati al brand specificato.
     *         La lista include informazioni arricchite sul brand.
     */
    public List<Product> getProductsByBrand(int brandId) {
        List<Product> productList = productDAO.doRetrieveByBrandId(brandId);
        brandService.addBrandToProductBean(productList);
        return productList;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> productList = productDAO.doRetrieveByCategoryId(categoryId);
        brandService.addBrandToProductBean(productList);
        return productList;
    }

    public List<Product> getProductsOnSale() {
        List<Product> productList = productDAO.doRetrieveBySalePrice();
        brandService.addBrandToProductBean(productList);
        return productList;
    }

    public List<Product> getFirstNProducts(int n) {
        List<Product> productList = productDAO.doRetrieveFirstNProducts(n);
        brandService.addBrandToProductBean(productList);
        return productList;
    }

    public List<String> getSearchSuggestions(String query) {
        return productDAO.searchProductsByName(query);
    }

    public List<Product> searchProducts(String query) {
        List<Product> productList = productDAO.findByNameLike(query);
        brandService.addBrandToProductBean(productList);
        return productList;
    }

    public List<Product> getAllProducts() {
        List<Product> productList = productDAO.doRetrieveAll();
        brandService.addBrandToProductBean(productList);
        return productList;
    }
    public boolean removeProduct(int productId) {
        return productDAO.deleteProduct(productId);
    }
    public Product getProductById(int productId) {
        return productDAO.doRetrieveById(productId);
    }
    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    public List<String> getBrandSuggestions(String query) {
        return brandService.getBrandSuggestions(query);
    }

    /**
     * Recupera tutti i colori disponibili per i filtri
     * @return Lista di colori unici
     */
    public List<String> getAllColors() {
        return productDAO.getAllColors();
    }

    /**
     * Recupera tutti i materiali disponibili per i filtri
     * @return Lista di materiali unici
     */
    public List<String> getAllMaterials() {
        return productDAO.getAllMaterials();
    }

    /**
     * Recupera il prezzo massimo per i filtri
     * @return Prezzo massimo
     */
    public Float getMaxPrice() {
        return productDAO.getMaxPrice();
    }

    /**
     * Recupera il prezzo massimo per una determinata categoria.
     *
     * @param categoryId L'ID della categoria per cui recuperare il prezzo massimo.
     * @return Il prezzo massimo come valore Float.
     */
    public Float getMaxPrice(int categoryId) {
        return productDAO.getMaxPrice(categoryId);
    }
}
