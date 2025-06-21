package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Category;


@Repository
public class CategoryDAO {
    private final JdbcTemplate jdbcTemplate;

    public CategoryDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Category> categoryRowMapper() {
        return (rs, rowNum) -> {
            Category category = new Category(
                rs.getInt(1),    // id
                rs.getString(2), // name
                rs.getInt(3),    // parentId
                rs.getString(4)  // description
            );
            // Gọi getProductCountByCategory để lấy productCount
            int productCount = getProductCountByCategory(category.getId());
            category.setProductCount(productCount);
            return category;
        };
    }


    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM category";
        return jdbcTemplate.query(sql, categoryRowMapper());
    }

    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM category WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, categoryRowMapper(), id);
    }

    public int addCategory(Category category) {
        String sql = "INSERT INTO category (name, parentId, description) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, category.getName(), category.getParentId(), category.getDescription());
    }

    public int updateCategory(Category category) {
        String sql = "UPDATE category SET name = ?, parentId = ?, description = ? WHERE id = ?";
        return jdbcTemplate.update(sql, category.getName(), category.getParentId(), category.getDescription(),  category.getId());
    }

    public int deleteCategory(int id) {
        String sql = "DELETE FROM category WHERE id = ?";  
        return jdbcTemplate.update(sql, id);
    }
    
    public int getProductCountByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM product WHERE categoryId = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, categoryId);
    }
    
    public List<Category> getCategoriesPaginated(int offset, int size, String search) {
        String sql = "SELECT * FROM category";
        if (search != null && !search.trim().isEmpty()) {
            sql += " WHERE name LIKE ?";
            sql += " LIMIT ? OFFSET ?";
            return jdbcTemplate.query(sql, categoryRowMapper(), "%" + search + "%", size, offset);
        }
        sql += " LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, categoryRowMapper(), size, offset);
    }

    public int getTotalCategories(String search) {
        String sql = "SELECT COUNT(*) FROM category";
        if (search != null && !search.trim().isEmpty()) {
            sql += " WHERE name LIKE ?";
            return jdbcTemplate.queryForObject(sql, Integer.class, "%" + search + "%");
        }
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
