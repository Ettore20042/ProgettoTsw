package model.Bean;

public class Include {
    private int idProduct;
    private int idOrder;
    private int Quantity;
    private float Price;

    public Include(int idProduct, float price, int quantity, int idOrder) {
        this.idProduct = idProduct;
        Price = price;
        Quantity = quantity;
        this.idOrder = idOrder;
    }
    public Include() {
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float price) {
        Price = price;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int quantity) {
        Quantity = quantity;
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }
}
