package model.Bean;

public class Product {
    private int idProduct;
    private String nameProduct;
    private float price;
    private String colour;
    private String material;
    private int stock;
    private String description;
    private int idBrand;
    private int idCategory;

    public Product(int idProduct, int idCategory, int idBrand, String description, int stock, String material, String colour, float price, String nameProduct) {
        this.idProduct = idProduct;
        this.idCategory = idCategory;
        this.idBrand = idBrand;
        this.description = description;
        this.stock = stock;
        this.material = material;
        this.colour = colour;
        this.price = price;
        this.nameProduct = nameProduct;
    }
    public Product() {
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(int idCategory) {
        this.idCategory = idCategory;
    }

    public int getIdBrand() {
        return idBrand;
    }

    public void setIdBrand(int idBrand) {
        this.idBrand = idBrand;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }
}
