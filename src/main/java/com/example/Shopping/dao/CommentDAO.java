package com.example.Shopping.dao;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Color;
import com.example.Shopping.model.Comment;

@Repository
public class CommentDAO {
	private final JdbcTemplate jdbcTemplate;

    public CommentDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Comment> commentRowMapper() {
        return (rs, rowNum) -> new Comment(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getString(4),
            rs.getDate(5),
            rs.getString(6)
        );
    }
    
    public List<Comment> getAllColors() {
        String sql = "SELECT * FROM comment";
        return jdbcTemplate.query(sql, commentRowMapper());
    }
    
    public List<Comment> getCommentByProductId(int id) {
        String sql = "SELECT cm.*, us.username AS username "
        			+ "FROM comment cm " 
        			+ "LEFT JOIN user us ON cm.userId = us.id "
        			+ "WHERE productId = ?";
        
        System.out.println("Id sản phẩm là: " + id);
        return jdbcTemplate.query(sql, commentRowMapper(), id);
    }
    
    public int addComment(Comment cm) {
        String sql = "INSERT INTO comment (productId, userId, content, createAt) VALUES (?, ?, ?, ?)";
        return jdbcTemplate.update(sql, cm.getProductId(), cm.getUserId(), cm.getContent(), cm.getCreateAt());
    }
}
