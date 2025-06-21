package com.example.Shopping.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import com.example.Shopping.model.User;

@Repository    
public class UserDAO {
    private final JdbcTemplate jdbcTemplate;

    public UserDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
    
    public int totalUser() {
        String sql = "SELECT COUNT(*) FROM user";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    public int totalUserByRole(String role) {
        String sql = "SELECT COUNT(*) FROM user WHERE role = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, role);
    }
    
    public List<User> getAllUsers() {
        String sql = "SELECT * FROM user";
        return jdbcTemplate.query(sql, userRowMapper());
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM user WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, userRowMapper(), id);
    }
    
    public int getUserByEmail(String email, int id) {
        String sql = "SELECT COUNT(*) FROM user WHERE email = ? AND id <> ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, email, id);
    }
    
    public int getUserByPhone(String phone, int id) {
        String sql = "SELECT COUNT(*) FROM user WHERE phone = ? AND id <> ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, phone, id);
    }

    public int addUser(User user) {
        String sql = "INSERT INTO user (username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
        int result = jdbcTemplate.update(sql, 
            user.getUsername(), 
            user.getPassword(), 
            user.getEmail(), 
            user.getPhone() != null ? user.getPhone() : null, 
            user.getAddress() != null ? user.getAddress() : null, 
            user.getRole() != null ? user.getRole() : "user"  
        );

        if (result > 0) {
            System.out.println("Thêm người dùng thành công: " + user.getUsername());
        } else {
            System.out.println("Thêm người dùng thất bại: " + user.getUsername()); 
        }

        return result;
    }


    public int updateUser(User user) {
        // Danh sách tham số
        List<Object> params = new ArrayList<>();
        // Khởi tạo câu lệnh SQL
        String sql = "UPDATE user SET ";
        boolean first = true;

        if (user.getUsername() != null) {
            if (!first) sql += ", ";
            sql += "username = ?";
            params.add(user.getUsername());
            first = false;
        }
        if (user.getPassword() != null) {
            if (!first) sql += ", ";
            sql += "password = ?";
            params.add(user.getPassword());
            first = false;
        }
        if (user.getEmail() != null) {
            if (!first) sql += ", ";
            sql += "email = ?";
            params.add(user.getEmail());
            first = false;
        }
        if (user.getPhone() != null) {
            if (!first) sql += ", ";
            sql += "phone = ?";
            params.add(user.getPhone());
            first = false;
        }
        if (user.getAddress() != null) {
            if (!first) sql += ", ";
            sql += "address = ?";
            params.add(user.getAddress());
            first = false;
        }
        if (user.getRole() != null) {
            if (!first) sql += ", ";
            sql += "role = ?";
            params.add(user.getRole());
            first = false;
        }

        // Nếu không có trường nào để cập nhật, dừng
        if (first) {
            System.out.println("Không có trường nào để cập nhật cho user id: " + user.getId());
            return 0;
        }

        // Thêm điều kiện WHERE
        sql += " WHERE id = ?";
        params.add(user.getId());

        // Thực thi
        int result = jdbcTemplate.update(sql, params.toArray());

        if (result > 0) {
            System.out.println("Cập nhật người dùng thành công: " + user.getUsername());
        } else {
            System.out.println("Cập nhật người dùng thất bại: " + user.getUsername());
        }

        return result;
    }


    public int deleteUser(int id) {
        String sql = "DELETE FROM user WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }

    public RowMapper<User> userRowMapper() {
        return (rs, rowNum) -> new User(
            rs.getInt(1),
            rs.getString(2),
            rs.getString(3),
            rs.getString(4),
            rs.getString(5),
            rs.getString(6),
            rs.getString(7)
        );
    }
    
    
    public List<User> getUsers(String search, int limit, int offset) {
        String sql = "SELECT * FROM user WHERE username LIKE ? LIMIT ? OFFSET ?";
        String searchParam = "%" + (search != null ? search : "") + "%";
        return jdbcTemplate.query(sql, userRowMapper(), searchParam, limit, offset);
    }

    public int getTotalUsers(String search) {
        String sql = "SELECT COUNT(*) FROM user WHERE username LIKE ?";
        String searchParam = "%" + (search != null ? search : "") + "%";
        return jdbcTemplate.queryForObject(sql, Integer.class, searchParam);
    }
}