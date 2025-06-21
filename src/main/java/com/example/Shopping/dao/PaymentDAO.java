package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Payment;

@Repository
public class PaymentDAO {
    private final JdbcTemplate jdbcTemplate;

    public PaymentDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Payment> paymentRowMapperWithDiff() {
        return (rs, rowNum) -> new Payment(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getInt(4),
            rs.getString(5),
            rs.getString(6),
            rs.getString(7),
            rs.getDate(8),
            rs.getInt(9)
            
        );
    }
    
    private RowMapper<Payment> paymentRowMapper() {
        return (rs, rowNum) -> new Payment(
            rs.getInt(1),
            rs.getInt(2),
            rs.getInt(3),
            rs.getInt(4),
            rs.getString(5),
            rs.getString(6),
            rs.getString(7),
            rs.getDate(8)
            
        );
    }


    public void updateTransactionNo(int orderId, String transNo) {
    	try {
    	    String sql = "UPDATE payment SET transactionNo = ? WHERE orderId = ?";
    	    int rowsAffected = jdbcTemplate.update(sql, transNo, orderId);

    	    if (rowsAffected > 0) {
    	        System.out.println("✅ Cập nhật số giao dịch thanh toán thành công.");
    	    } else {
    	        System.out.println("❌ Không tìm thấy đơn hàng để cập nhật.");
    	    }
    	} catch (Exception e) {
    	    e.printStackTrace();
    	}

    }
    
    
    public List<Payment> getAllPayments() {
        String sql = "SELECT * FROM payment";
        return jdbcTemplate.query(sql, paymentRowMapper());
    }

    public Payment getPaymentById(int id) {
        String sql = "SELECT * FROM payment WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, paymentRowMapper(), id);
    }
    
    public Payment getPaymentByOrderId(int orderId) {
    	String sql = "SELECT pay.*, od.totalPrice as totalPrice FROM payment pay LEFT JOIN `order` od ON od.id = pay.orderId WHERE pay.orderId = ?";
    	return jdbcTemplate.queryForObject(sql, paymentRowMapperWithDiff(), orderId);
    }

    public int addPayment(Payment payment) {
        String sql = "INSERT INTO payment (userId, orderId, discountId, method, transactionNo, status, createAt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println("Adding payment: userId=" + payment.getUserId() +
                ", orderId=" + payment.getOrderId() +
                ", discount=" + payment.getDiscountId() +
                ", method=" + payment.getMethod() +
                ", transactionNo=" + payment.getTransactionNo() +
                ", status=" + payment.getStatus() +   
                ", createAt=" + payment.getCreateAt());
        
        int result = jdbcTemplate.update(sql,
            payment.getUserId(),
            payment.getOrderId(),
            payment.getDiscountId(),
            payment.getMethod(),
            payment.getTransactionNo(),
            payment.getStatus(),
            payment.getCreateAt()
        );

        if (result > 0) {
            System.out.println("✅ Thanh toán đã được thêm thành công.");
        } else {
            System.out.println("❌ Thêm thanh toán thất bại.");
        }

        return result;
    }

    public int updatePayment(Payment payment) {
        String sql = "UPDATE payment SET userId = ?, orderId = ?, discountId = ?, method = ?, status = ?, createAt = ? WHERE id = ?";
        return jdbcTemplate.update(sql, payment.getUserId(), payment.getOrderId(), payment.getDiscountId(), payment.getMethod(), payment.getStatus(), payment.getCreateAt(), payment.getId());
    }

    public int deletePayment(int id) {
        String sql = "DELETE FROM payment WHERE id = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    public int deletePaymentByOrderId(int id) {
        String sql = "DELETE FROM payment WHERE orderId = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    public void updatePaymentStatus(int orderId, String status) {
        String sql = "UPDATE payment SET status = ? WHERE orderId = ?";
        int rowsAffected = jdbcTemplate.update(sql, status, orderId);

        if (rowsAffected > 0) {
            System.out.println("✅ Cập nhật trạng thái thanh toán thành công.");
        } else {
            System.out.println("❌ Không tìm thấy đơn hàng để cập nhật.");
        }
    }
}
