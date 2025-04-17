package model.Bean;

public class Image {
    private int idImage;
    private String pathImage;
    private int imageOrder;
    private String DescriptionImage;
    private int idProduct;

    public Image(int idImage, int idProduct, String descriptionImage, int imageOrder, String pathImage) {
        this.idImage = idImage;
        this.idProduct = idProduct;
        DescriptionImage = descriptionImage;
        this.imageOrder = imageOrder;
        this.pathImage = pathImage;
    }
    public Image() {
    }

    public int getIdImage() {
        return idImage;
    }

    public void setIdImage(int idImage) {
        this.idImage = idImage;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public String getDescriptionImage() {
        return DescriptionImage;
    }

    public void setDescriptionImage(String descriptionImage) {
        DescriptionImage = descriptionImage;
    }

    public int getImageOrder() {
        return imageOrder;
    }

    public void setImageOrder(int imageOrder) {
        this.imageOrder = imageOrder;
    }

    public String getPathImage() {
        return pathImage;
    }

    public void setPathImage(String pathImage) {
        this.pathImage = pathImage;
    }
}
