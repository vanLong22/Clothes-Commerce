package com.example.Shopping.dao;


import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Discount;

@Repository
public class DiscountDAO {
    private final JdbcTemplate jdbcTemplate;

    public DiscountDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Discount> discountRowMapper() {
        return (rs, rowNum) -> new Discount(
            rs.getInt(1),
            rs.getString(2),
            rs.getBigDecimal(3),
            rs.getDate(4)
        );
    }

    public List<Discount> getAllDiscounts() {
        String sql = "SELECT * FROM discount";
        return jdbcTemplate.query(sql, discountRowMapper());
    }

    public Discount getDiscountById(int id) {
        String sql = "SELECT * FROM discount WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, discountRowMapper(), id);
    }

    public int addDiscount(Discount discount) {
        String sql = "INSERT INTO discount (code, discountPercentage, expirationDate) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, discount.getCode(), discount.getDiscountPercentage(), discount.getExpirationDate());
    }

    public int updateDiscount(Discount discount) {
        String sql = "UPDATE discount SET code = ?, discountPercentage = ?, expirationDate = ? WHERE id = ?";
        return jdbcTemplate.update(sql, discount.getCode(), discount.getDiscountPercentage(), discount.getExpirationDate(), discount.getId());
    }

    public int deleteDiscount(int id) {
        String sql = "DELETE FROM discount WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}
