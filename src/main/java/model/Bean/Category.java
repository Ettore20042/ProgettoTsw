package model.Bean;

public class Category {
    private int IdCategory;
    private String NameCategory;
    private String PathCategory;
    private int IdParentCategory;

    public Category(int idCategory, int idParentCategory, String nameCategory, String pathCategory) {
        IdCategory = idCategory;
        IdParentCategory = idParentCategory;
        NameCategory = nameCategory;
        PathCategory = pathCategory;
    }


    public Category() {

    }

    public int getIdCategory() {
        return IdCategory;
    }

    public void setIdCategory(int idCategory) {
        IdCategory = idCategory;
    }

    public int getIdParentCategory() {
        return IdParentCategory;
    }

    public void setIdParentCategory(int idParentCategory) {
        IdParentCategory = idParentCategory;
    }

    public String getPathCategory() {
        return PathCategory;
    }

    public void setPathCategory(String pathCategory) {
        PathCategory = pathCategory;
    }

    public String getNameCategory() {
        return NameCategory;
    }

    public void setNameCategory(String nameCategory) {
        NameCategory = nameCategory;
    }
}
