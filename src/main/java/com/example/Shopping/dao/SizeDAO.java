package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import com.example.Shopping.model.Size;
import org.springframework.stereotype.Repository;

@Repository
public class SizeDAO {
    private final JdbcTemplate jdbcTemplate;

    public SizeDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Size> sizeRowMapper() {
        return (rs, rowNum) -> new Size(
            rs.getInt(1),
            rs.getInt(2),
            rs.getString(3)
        );
    }

    public List<Size> getAllSizes() {
        String sql = "SELECT * FROM size";
        return jdbcTemplate.query(sql, sizeRowMapper());
    }

    public List<Size> getSizeById(int id) {
        String sql = "SELECT * FROM size WHERE productId = ?";
        System.out.println("Id sản phẩm là: " + id);
        return jdbcTemplate.query(sql, sizeRowMapper(), id);
    }

    public int addSize(Size size) {
        String sql = "INSERT INTO size (name) VALUES (?)";
        return jdbcTemplate.update(sql, size.getName());
    }

    public int updateSize(Size size) {
        String sql = "UPDATE size SET name = ? WHERE productId = ?";
        return jdbcTemplate.update(sql, size.getName(), size.getId());
    }

    public int deleteSize(int id) {
        String sql = "DELETE FROM size WHERE productId = ?";
        return jdbcTemplate.update(sql, id);
    }
}
