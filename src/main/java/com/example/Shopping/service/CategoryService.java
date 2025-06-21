package com.example.Shopping.service;

import com.example.Shopping.dao.CategoryDAO;
import com.example.Shopping.model.Category;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CategoryService {
    private final CategoryDAO categoryDAO;

    public CategoryService(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public Category getCategoryById(int id) {
        return categoryDAO.getCategoryById(id);
    }

    public void addCategory(Category category) {
        categoryDAO.addCategory(category);
    }

    public void updateCategory(Category category) {
        categoryDAO.updateCategory(category);
    }

    public void deleteCategory(int id) {
        categoryDAO.deleteCategory(id);
    }
    
    public int getProductCountByCategory(int categoryId) {
    	return categoryDAO.getProductCountByCategory(categoryId);
    }
    
    public List<Category> getCategoriesPaginated(int page, int size, String search) {
        // Calculate offset
        int offset = (page - 1) * size;
        return categoryDAO.getCategoriesPaginated(offset, size, search);
    }

    public int getTotalCategories(String search) {
        return categoryDAO.getTotalCategories(search);   
    }
}