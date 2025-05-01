package model.Bean;

public class Image {
    private int imageId;
    private String imagePath;
    private Integer displayOrder;
    private String imageDescription;
    private int productId;

    public Image(int idImage, int idProduct, String descriptionImage, int imageOrder, String pathImage) {
        this.imageId = idImage;
        this.productId = idProduct;
        this.imageDescription = descriptionImage;
        this.displayOrder = imageOrder;
        this.imagePath = pathImage;
    }
    public Image() {
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getImageDescription() {
        return imageDescription;
    }

    public void setImageDescription(String imageDescription) {
        this.imageDescription = imageDescription;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
