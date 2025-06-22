package model.Bean;

public class Product {
    private int productId;
    private String productName;
    private float price;
    private String color;
    private String material;
    private int quantity;
    private String description;
    private int brandId;
    private int categoryId;
    private double salePrice;
    private Brand brand;

  public Product(int idProduct, int idCategory, int idBrand, String description, int stock, String material, String colour, float price, String nameProduct,double salePrice) {
      this.productId = idProduct;
      this.categoryId = idCategory;
      this.brandId = idBrand;
      this.description = description;
      this.quantity = stock;
      this.material = material;
      this.color = colour;
      this.price = price;
      this.productName = nameProduct;
      this.salePrice = salePrice;
  }
  public Product(){

  }
    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }
    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}



