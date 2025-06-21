package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Cart;

@Repository
public class CartDAO {
    private final JdbcTemplate jdbcTemplate;

    public CartDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    } 

    private RowMapper<Cart> cartRowMapper() {
        return (rs, rowNum) -> new Cart(
            rs.getInt("id"),
            rs.getInt("userId"),
            rs.getInt("productId"),
            rs.getInt("colorId"),
            rs.getInt("sizeId"),
            rs.getInt("variantId"),
            rs.getInt("quantity"),
            rs.getDate("createAt"),
            rs.getString("productImage"),
            rs.getString("productName"),
            rs.getInt("productQuantity"),
            rs.getInt("productPrice"),
            rs.getString("colorName"),
            rs.getString("sizeName")
        );
    }

    public List<Cart> getAllCarts() {
        String sql = """
            SELECT c.*, 
                   p.name AS productName, 
                   p.image AS productImage,
        		   p.quantity AS productQuantity,  
                   p.price AS productPrice,
                   clr.name AS colorName, 
                   sz.name AS sizeName 
            FROM cart c 
            LEFT JOIN product p ON c.productId = p.id 
            LEFT JOIN color clr ON c.colorId = clr.id 
            LEFT JOIN size sz ON c.sizeId = sz.id
        """;
        return jdbcTemplate.query(sql, cartRowMapper());
    }

    public List<Cart> getCartsByUserId(int userId) {
        String sql = """
            SELECT c.*, 
                   p.name AS productName, 
                   p.image AS productImage, 
                   p.quantity AS productQuantity,  
                   p.price AS productPrice, 
                   clr.name AS colorName, 
                   sz.name AS sizeName 
            FROM cart c 
            LEFT JOIN product p ON c.productId = p.id 
            LEFT JOIN color clr ON c.colorId = clr.id 
            LEFT JOIN size sz ON c.sizeId = sz.id 
            WHERE c.userId = ?
        """;
        return jdbcTemplate.query(sql, cartRowMapper(), userId);
    }

    public Cart getCartById(int id) {
        String sql = """
            SELECT c.*, 
                   p.name AS productName, 
                   p.image AS productImage, 
                   p.quantity AS productQuantity,  
                   p.price AS productPrice, 
                   clr.name AS colorName, 
                   sz.name AS sizeName 
            FROM cart c 
            LEFT JOIN product p ON c.productId = p.id 
            LEFT JOIN color clr ON c.colorId = clr.id 
            LEFT JOIN size sz ON c.sizeId = sz.id 
            WHERE c.id = ?
        """;
        
        System.out.println("Retrieved cart with ID: " + id);
        
        return jdbcTemplate.queryForObject(sql, cartRowMapper(), id);
    }

    public int addCart(Cart cart) {
        String sql = "INSERT INTO cart (userId, productId, colorId, sizeId, variantId, quantity, createAt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("Adding to cart: userId=" + cart.getUserId() +
                ", productId=" + cart.getProductId() +
                ", colorId=" + cart.getColorId() +
                ", sizeId=" + cart.getSizeId() +
                ", variantId=" + cart.getVariantId() +
                ", quantity=" + cart.getQuantity());
        
        int result = jdbcTemplate.update(sql, 
            cart.getUserId(), 
            cart.getProductId(), 
            cart.getColorId(), 
            cart.getSizeId(), 
            cart.getVariantId(), 
            cart.getQuantity(),
            cart.getCreateAt() != null ? cart.getCreateAt() : new java.sql.Date(System.currentTimeMillis())
        );

        if (result > 0) {
            System.out.println("✅ Sản phẩm đã được thêm vào giỏ hàng thành công.");
        } else {
            System.out.println("❌ Thêm sản phẩm vào giỏ hàng thất bại.");
        }

        return result;
    }

    public int updateCart(Cart cart) {
        String sql = "UPDATE cart SET userId = ?, productId = ?, colorId = ?, sizeId = ?, variantId = ?, quantity = ?, createAt = ? WHERE id = ?";
        int result = jdbcTemplate.update(sql, 
            cart.getUserId(), 
            cart.getProductId(), 
            cart.getColorId(), 
            cart.getSizeId(), 
            cart.getVariantId(), 
            cart.getQuantity(),
            cart.getCreateAt() != null ? cart.getCreateAt() : new java.sql.Date(System.currentTimeMillis()),
            cart.getId()
        );
        
        if (result > 0) {
            System.out.println("✅ Sản phẩm đã được thêm vào giỏ hàng thành công.");
        } else {
            System.out.println("❌ Thêm sản phẩm vào giỏ hàng thất bại.");
        }

        return result;
    }

    public int deleteCart(int id) {
        String sql = "DELETE FROM cart WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
}