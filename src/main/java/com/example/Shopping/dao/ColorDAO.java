package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Color;


@Repository
public class ColorDAO {
    private final JdbcTemplate jdbcTemplate;

    public ColorDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Color> colorRowMapper() {
        return (rs, rowNum) -> new Color(
            rs.getInt(1),
            rs.getInt(2),
            rs.getString(3)
        );
    }

    public List<Color> getAllColors() {
        String sql = "SELECT * FROM color";
        return jdbcTemplate.query(sql, colorRowMapper());
    }

    public List<Color> getColorById(int id) {
        String sql = "SELECT * FROM color WHERE productId = ?";
        System.out.println("Id sản phẩm là: " + id);
        return jdbcTemplate.query(sql, colorRowMapper(), id);
    }

    public int addColor(Color category) {
        String sql = "INSERT INTO color (name) VALUES (?)";
        return jdbcTemplate.update(sql, category.getName());
    }

    public int updateColor(Color category) {
        String sql = "UPDATE color SET name = ? WHERE productId = ?";
        return jdbcTemplate.update(sql, category.getName(), category.getId());
    }

    public int deleteColor(int id) {
        String sql = "DELETE FROM color WHERE productId = ?";
        return jdbcTemplate.update(sql, id);
    }
}
