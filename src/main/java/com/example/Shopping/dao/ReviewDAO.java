package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Review;

@Repository
public class ReviewDAO {
    private final JdbcTemplate jdbcTemplate;

    public ReviewDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Review> reviewRowMapper() {
        return (rs, rowNum) -> new Review(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getInt(4),
            rs.getString(5),
            rs.getDate(6)
        );
    }

    public List<Review> getAllReviews() {
        String sql = "SELECT * FROM review";
        return jdbcTemplate.query(sql, reviewRowMapper());
    }

    public Review getReviewById(int id) {
        String sql = "SELECT * FROM review WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, reviewRowMapper(), id);
    }

    public int addReview(Review review) {
        String sql = "INSERT INTO review (userId, productId, rating, comment, createAt) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, review.getUserId(), review.getProductId(), review.getRating(), review.getComment(), review.getCreateAt());
    }

    public int updateReview(Review review) {
        String sql = "UPDATE review SET userId = ?, productId = ?, rating = ?, comment = ?, createAt = ? WHERE id = ?";
        return jdbcTemplate.update(sql, review.getUserId(), review.getProductId(), review.getRating(), review.getComment(), review.getCreateAt(), review.getId());
    }

    public int deleteReview(int id) {
        String sql = "DELETE FROM review WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}