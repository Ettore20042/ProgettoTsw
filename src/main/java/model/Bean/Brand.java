package model.Bean;

public class Brand {
    private int idBrand;
    private String PathLogo;
    private String NameBrand;

    public Brand(int idBrand, String nameBrand, String pathLogo) {
        this.idBrand = idBrand;
        NameBrand = nameBrand;
        PathLogo = pathLogo;
    }
    public Brand() {

    }
    public int getIdBrand() {
        return idBrand;
    }

    public void setIdBrand(int idBrand) {
        this.idBrand = idBrand;
    }

    public String getNameBrand() {
        return NameBrand;
    }

    public void setNameBrand(String nameBrand) {
        NameBrand = nameBrand;
    }

    public String getPathLogo() {
        return PathLogo;
    }

    public void setPathLogo(String pathLogo) {
        PathLogo = pathLogo;
    }
}