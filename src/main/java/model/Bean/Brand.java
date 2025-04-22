package model.Bean;

public class Brand {
    private int brandId;
    private String logoPath;
    private String brandName;

    public Brand() {

    }
    public Brand(int idBrand, String nameBrand, String pathLogo) {
        this.brandId = idBrand;
        this.brandName = nameBrand;
        this.logoPath = pathLogo;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }
}

