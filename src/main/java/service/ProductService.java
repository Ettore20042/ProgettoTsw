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
            brandService.addBrandToProductBean(List.of(product));
        }
        return product;
    }

    /**
     * Recupera una lista di prodotti filtrata e arricchita con le informazioni sul brand.
     * @param categoryId L'ID della categoria.
     * @param brandId L'ID del brand.
     * @param color Il colore.
     * @param material Il materiale.
     * @param minPrice Il prezzo minimo.
     * @param maxPrice Il prezzo massimo.
     * @return Una lista di prodotti che soddisfano i criteri di filtro.
     */
    public List<Product> getFilteredProducts(String categoryId, String brandId, String color, String material, Float minPrice, Float maxPrice) {
        List<Product> productList = productDAO.doRetrieveByFilter(categoryId, brandId, color, material, minPrice, maxPrice);
        brandService.addBrandToProductBean(productList);
        return productList;
    }

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
}
