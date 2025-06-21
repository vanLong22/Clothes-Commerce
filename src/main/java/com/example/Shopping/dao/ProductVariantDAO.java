package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.ProductVariant;

@Repository
public class ProductVariantDAO {
    private final JdbcTemplate jdbcTemplate;

    public ProductVariantDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<ProductVariant> productVariantRowMapper() {
        return (rs, rowNum) -> new ProductVariant(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getInt(4),
            rs.getBigDecimal(5),
            rs.getInt(6)
        );
    }

    public List<ProductVariant> getAllProductVariants() {
        String sql = "SELECT * FROM productVariant";
        return jdbcTemplate.query(sql, productVariantRowMapper());
    }

    public ProductVariant getProductVariantById(int id) {
        String sql = "SELECT * FROM productVariant WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, productVariantRowMapper(), id);
    }

    public int addProductVariant(ProductVariant productVariant) {
        String sql = "INSERT INTO productVariant (productId, colorId, sizeId, price, stockQuantity) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, productVariant.getProductId(), productVariant.getColorId(), productVariant.getSizeId(), productVariant.getPrice(), productVariant.getStockQuantity());
    }

    public int updateProductVariant(ProductVariant productVariant) {
        String sql = "UPDATE productVariant SET productId = ?, colorId = ?, sizeId = ?, price = ?, stockQuantity = ? WHERE id = ?";
        return jdbcTemplate.update(sql, productVariant.getProductId(), productVariant.getColorId(), productVariant.getSizeId(), productVariant.getPrice(), productVariant.getStockQuantity(), productVariant.getId());
    }

    public int deleteProductVariant(int id) {
        String sql = "DELETE FROM productVariant WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}
