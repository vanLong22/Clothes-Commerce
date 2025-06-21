package com.example.Shopping.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.Statement;
import com.example.Shopping.model.Order;


@Repository
public class OrderDAO {
    private final JdbcTemplate jdbcTemplate;

    public OrderDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Order> orderRowMapperWithDiff() {
        return (rs, rowNum) -> new Order(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getString(4),
            rs.getString(5),
            rs.getString(6),
            rs.getString(7),
            rs.getString(8),
            rs.getString(9)
        );
    }
    
    private RowMapper<Order> orderRowMapper() {
        return (rs, rowNum) -> new Order(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getString(4),
            rs.getString(5),
            rs.getString(6)
        );
    }   
    
    public int totalOrder() {
        String sql = "SELECT COUNT(*) FROM `order` WHERE status = 'pending'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public List<Order> getAllOrders() {
        String sql = "SELECT * FROM `order`";
        return jdbcTemplate.query(sql, orderRowMapper());
    }

    public Order getOrderById(int id) {
        String sql = "SELECT * FROM `order` WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, orderRowMapper(), id);
    }

    public int addOrder(Order order) {
        String sql = "INSERT INTO `order` (userId, addressId, totalPrice, status, createdAt) VALUES (?, ?, ?, ?, ?)";
        
        // Tạo KeyHolder để lưu trữ ID được tạo
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        // Thực hiện INSERT và lấy generated key
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getAddressId());
            ps.setString(3, order.getTotalPrice());
            ps.setString(4, order.getStatus());
            ps.setString(5, order.getCreatedAt());
            return ps;
        }, keyHolder);

        System.out.println("OrderId vừa được tạo là: " + keyHolder.getKey().intValue());
        return keyHolder.getKey().intValue();
    }

    public int updateOrder(Order order) {
        String sql = "UPDATE `order` SET userId = ?, addressId = ?, totalPrice = ?, status = ?, createdAt = ? WHERE id = ?";
        return jdbcTemplate.update(sql, order.getUserId(), order.getAddressId(), order.getTotalPrice(), order.getStatus(), order.getCreatedAt(), order.getId());
    }
    
    public int deleteOrder(int id) {
        String sql = "DELETE FROM `order` WHERE id = ?";
        return jdbcTemplate.update(sql, id);  
    }
    
    public List<Order> getAllOrdersByUserId(int userId) {
        String sql = "SELECT o.*, a.name AS addressName, a.phone AS addressPhone, a.addressLine " +
                     "FROM `order` o " +
                     "LEFT JOIN address a ON o.addressId = a.id " +
                     "WHERE o.userId = ?";

        List<Order> orders = jdbcTemplate.query(sql, new Object[]{userId}, orderRowMapperWithDiff());

        System.out.println("Danh sách đơn hàng cho userId = " + userId + ":");
        if (orders.isEmpty()) {
            System.out.println("Không có đơn hàng nào.");
        } else {
            for (Order order : orders) {
                System.out.println("Thông tin đơn hàng:");
                System.out.println("ID: " + order.getId());
                System.out.println("UserID: " + order.getUserId());
                System.out.println("Tổng tiền: " + order.getTotalPrice());
                System.out.println("Trạng thái: " + order.getStatus());
                System.out.println("Ngày tạo: " + order.getCreatedAt());
                System.out.println("Tên người nhận: " + order.getName());
                System.out.println("SĐT: " + order.getPhone());
                System.out.println("Địa chỉ: " + order.getAddressLine());
                System.out.println("---------------");
            }
        }

        return orders;
    }
    
    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE `order` SET status = ? WHERE id = ?";
        int rowsAffected = jdbcTemplate.update(sql, status, orderId);

        if (rowsAffected > 0) {
            System.out.println("✅ Cập nhật trạng thái đơn hàng thành công.");
        } else {
            System.out.println("❌ Không tìm thấy đơn hàng để cập nhật.");
        }
    }

    
    
    
    
    
    
    public int getTotalInvoices() {
        String sql = "SELECT COUNT(*) FROM `order`";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public int getCompletedInvoices() {
        String sql = "SELECT COUNT(*) FROM `order` WHERE status = 'delivered'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public int getProcessingInvoices() {
        String sql = "SELECT COUNT(*) FROM `order` WHERE status = 'processing'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT SUM(CAST(totalPrice AS DECIMAL(10,2))) FROM `order` WHERE status = 'delivered'";
        return jdbcTemplate.queryForObject(sql, BigDecimal.class);
    }

    public List<Order> getAllOrdersWithDetails() {
        String sql = "SELECT o.*, a.name AS addressName, a.phone AS addressPhone, a.addressLine " +
                     "FROM `order` o LEFT JOIN address a ON o.addressId = a.id";
        return jdbcTemplate.query(sql, orderRowMapperWithDiff());
    }
    
    
    
    
    public List<Order> getOrders(String search, int page, int size) {
        String sql = "SELECT o.*, a.name AS addressName, a.phone AS addressPhone, a.addressLine " +
                     "FROM `order` o LEFT JOIN address a ON o.addressId = a.id ";
        List<Object> params = new ArrayList<>();
        if (search != null && !search.isEmpty()) {
            sql += "WHERE o.id LIKE ? OR a.name LIKE ? OR a.phone LIKE ? ";
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        sql += "LIMIT ? OFFSET ?";
        params.add(size);
        params.add((page - 1) * size);
        return jdbcTemplate.query(sql, params.toArray(), orderRowMapperWithDiff());
    }

    public int getTotalOrders(String search) {
        String sql = "SELECT COUNT(*) FROM `order` o LEFT JOIN address a ON o.addressId = a.id ";
        List<Object> params = new ArrayList<>();
        if (search != null && !search.isEmpty()) {
            sql += "WHERE o.id LIKE ? OR a.name LIKE ? OR a.phone LIKE ? ";
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        return jdbcTemplate.queryForObject(sql, Integer.class, params.toArray());
    }
    
    // Tổng đơn hàng trong tháng hiện tại
    public int getTotalOrdersInMonth() {
        String sql = "SELECT COUNT(*) FROM `order` WHERE MONTH(createdAt) = MONTH(CURRENT_DATE()) AND YEAR(createdAt) = YEAR(CURRENT_DATE())";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // Doanh thu theo tháng trong năm hiện tại
    public List<Map<String, Object>> getMonthlyRevenue() {
        String sql = "SELECT MONTH(createdAt) AS month, SUM(CAST(totalPrice AS DECIMAL(10,2))) AS revenue " +
                     "FROM `order` WHERE YEAR(createdAt) = YEAR(CURRENT_DATE()) AND status = 'delivered' " +
                     "GROUP BY MONTH(createdAt)";
        return jdbcTemplate.queryForList(sql);
    }

    // Phân phối trạng thái đơn hàng
    public List<Map<String, Object>> getOrderStatusDistribution() {
        String sql = "SELECT status, COUNT(*) AS count FROM `order` GROUP BY status";
        return jdbcTemplate.queryForList(sql);
    }

    // Danh sách 5 đơn hàng gần đây
    public List<Order> getRecentOrders(int limit) {
        String sql = "SELECT o.*, a.name AS addressName, a.phone AS addressPhone, a.addressLine " +
                     "FROM `order` o LEFT JOIN address a ON o.addressId = a.id " +
                     "ORDER BY o.createdAt DESC LIMIT ?";
        return jdbcTemplate.query(sql, new Object[]{limit}, orderRowMapperWithDiff());
    }
}
