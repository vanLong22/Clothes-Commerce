package com.example.Shopping.model;

public class Category {
    private int id;
    private String name;
    private int parentId;
    private String description;
    private int productCount;

    public Category() {
    }

    public Category(int id, String name, int parentId, String description) {
        this.id = id;
        this.name = name;
        this.parentId = parentId;
        this.description = description;
    }

    public Category(int id, String name, int parentId, String description, int productCount) {
        this.id = id;
        this.name = name;
        this.parentId = parentId;
        this.description = description;
        this.productCount = productCount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }
}