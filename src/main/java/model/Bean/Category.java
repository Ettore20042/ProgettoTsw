package model.Bean;

public class Category {
    private int categoryId;
    private String categoryName;
    private String categoryPath;
    private Integer parentCategory;

    public Category() {

    }
    public Category(int categoryId, String categoryName, String categoryPath, Integer parentCategory) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryPath = categoryPath;
        this.parentCategory = parentCategory;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getParentCategory() {
        return parentCategory;
    }

    public void setParentCategory(Integer parentCategory) {
        this.parentCategory = parentCategory;
    }

    public String getCategoryPath() {
        return categoryPath;
    }

    public void setCategoryPath(String categoryPath) {
        this.categoryPath = categoryPath;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}


