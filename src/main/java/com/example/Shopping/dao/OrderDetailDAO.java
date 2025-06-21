package com.example.Shopping.dao;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.OrderDetail;

@Repository
public class OrderDetailDAO {
    private final JdbcTemplate jdbcTemplate;

    public OrderDetailDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<OrderDetail> orderDetailRowMapper() {
        return (rs, rowNum) -> new OrderDetail(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getString(4),
            rs.getString(5),
            rs.getString(6),
            rs.getBigDecimal(7),
            rs.getDate(8),
            rs.getString(9),
            rs.getString(10)
        );
    }

    public List<OrderDetail> getAllOrderDetails() {
        String sql = "SELECT * FROM orderDetail";
        return jdbcTemplate.query(sql, orderDetailRowMapper());
    }

    public OrderDetail getOrderDetailById(int id) {
        String sql = "SELECT * FROM orderDetail WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, orderDetailRowMapper(), id); 
    }
    
    public int getAllByProductIdSold(int productId) {
        String sql = "SELECT Count(*) FROM orderDetail WHERE productId = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, productId); 
    }

    public int addOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO orderDetail (orderId, productId, quantity, color, size, unitPrice, createAt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, orderDetail.getOrderId(), orderDetail.getProductId(), orderDetail.getQuantity(), orderDetail.getColor(), orderDetail.getSize(), orderDetail.getUnitPrice(), orderDetail.getCreateAt());
    }

    public int updateOrderDetail(OrderDetail orderDetail) {
        String sql = "UPDATE orderDetail SET orderId = ?, productId = ?, quantity = ?, color = ?, size = ?, unitPrice = ?, creatAt = ? WHERE id = ?";
        return jdbcTemplate.update(sql, orderDetail.getOrderId(), orderDetail.getProductId(), orderDetail.getQuantity(), orderDetail.getColor(), orderDetail.getSize(), orderDetail.getUnitPrice(), orderDetail.getCreateAt(), orderDetail.getId());
    }

    public int deleteOrderDetail(int id) {
        String sql = "DELETE FROM orderDetail WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }

    public int deleteOrderDetailByOrderId(int id) {
        String sql = "DELETE FROM orderDetail WHERE orderId = ?";
        return jdbcTemplate.update(sql, id);
    }

    
    /*
    public List<OrderDetail> getOrderDetailsByOrderIds(List<Integer> orderIds) {
        if (orderIds.isEmpty()) {
            System.out.println("Danh sách orderIds rỗng, không truy vấn chi tiết đơn hàng.");
            return List.of();
        }
        
        String placeholders = String.join(",", orderIds.stream().map(id -> "?").toArray(String[]::new));
        String sql = "SELECT * FROM orderDetail WHERE orderId IN (" + placeholders + ")";
        List<OrderDetail> orderDetails = jdbcTemplate.query(sql, orderIds.toArray(), orderDetailRowMapper());
        
        // In dữ liệu trực tiếp
        System.out.println("Danh sách chi tiết đơn hàng cho orderIds = " + orderIds + ":");
        if (orderDetails.isEmpty()) {
            System.out.println("Không có chi tiết đơn hàng nào.");
        } else {
            for (OrderDetail detail : orderDetails) {
                System.out.println("Thông tin chi tiết đơn hàng.");
                System.out.println(detail.getId());
                System.out.println(detail.getOrderId());
                System.out.println(detail.getProductId());
                System.out.println(detail.getQuantity());
                System.out.println(detail.getColor());
            }
        }
        
        return orderDetails;
    }
    */
    
    public List<OrderDetail> getOrderDetailsByOrderIds(List<Integer> orderIds) {
        if (orderIds.isEmpty()) {
            System.out.println("Danh sách orderIds rỗng, không truy vấn chi tiết đơn hàng.");
            return List.of();
        }

        // Create placeholders for the IN clause
        String placeholders = String.join(",", orderIds.stream().map(id -> "?").toArray(String[]::new));

        // Updated SQL query with joins to retrieve product name, color name, and size name
        String sql = "SELECT od.*, p.name AS productName, p.image AS productImage " +
                     "FROM orderDetail od " +
                     "LEFT JOIN product p ON od.productId = p.id " +
                     "LEFT JOIN color c ON od.color = c.id " +
                     "LEFT JOIN size s ON od.size = s.id " +
                     "WHERE od.orderId IN (" + placeholders + ")";

        List<OrderDetail> orderDetails = jdbcTemplate.query(sql, orderIds.toArray(), orderDetailRowMapper());

        // Print the data
        System.out.println("Danh sách chi tiết đơn hàng cho orderIds = " + orderIds + ":");
        if (orderDetails.isEmpty()) {
            System.out.println("Không có chi tiết đơn hàng nào.");
        } else {
            for (OrderDetail detail : orderDetails) {
                System.out.println("Thông tin chi tiết đơn hàng:");
                System.out.println("ID: " + detail.getId());
                System.out.println("Order ID: " + detail.getOrderId());
                System.out.println("Product ID: " + detail.getProductId());
                System.out.println("Product Name: " + detail.getProductName());
                System.out.println("Quantity: " + detail.getQuantity());
                System.out.println("Color: " + detail.getColor());
                System.out.println("Size: " + detail.getSize());
            }
        }

        return orderDetails;
    }
    
 
    
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        return getOrderDetailsByOrderIds(List.of(orderId));
    }
    
    // Top 5 sản phẩm bán chạy
    public List<Map<String, Object>> getTopSellingProducts(int limit) {
        String sql = "SELECT p.name, SUM(od.quantity) AS totalQuantity \r\n"
        		+ "FROM orderDetail od JOIN product p ON od.productId = p.id \r\n"
        		+ "GROUP BY p.name \r\n"
        		+ "ORDER BY totalQuantity DESC \r\n"
        		+ "LIMIT ?";
        return jdbcTemplate.queryForList(sql, limit);
    }
}