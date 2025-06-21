package com.example.Shopping.service;

import com.example.Shopping.dao.PaymentDAO;
import com.example.Shopping.model.Payment;
import org.springframework.stereotype.Service;
import java.util.List;
import org.json.JSONObject;


@Service
public class PaymentService {
    private final PaymentDAO paymentDAO;

    public PaymentService(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }

    public List<Payment> getAllPayments() {
        return paymentDAO.getAllPayments();
    }

    public Payment getPaymentById(int id) {
        return paymentDAO.getPaymentById(id);
    }
    
    public Payment getPaymentByOrderId(int orderId) {
        return paymentDAO.getPaymentByOrderId(orderId);
    }

    public int addPayment(Payment payment) {
        return paymentDAO.addPayment(payment);
    }

    public boolean updatePayment(Payment payment) {
        return paymentDAO.updatePayment(payment) > 0;
    }

    public boolean deletePayment(int id) {
        return paymentDAO.deletePayment(id) > 0;
    }
    
    public  JSONObject getTransactionDetails(String orderId) {
        // Gọi API VietQR (giả lập)
        // Ví dụ: Gửi yêu cầu GET/POST đến https://api.vietqr.io/transaction?orderId={orderId}
        // Trả về JSON: {"amount": 1000000, "orderId": "abc123", "status": "completed"}
        // Thay bằng logic thực tế
        JSONObject transaction = new JSONObject();
        transaction.put("amount", 3000);
        transaction.put("orderId", orderId);
        return transaction;
    }
    
    public void updatePaymentStatus(int orderId, String status) {
    	paymentDAO.updatePaymentStatus(orderId, status);
    }
    
    public void updateTransactionNo(int orderId, String transNo) {
    	paymentDAO.updateTransactionNo(orderId, transNo);
    }
    
    public int deletePaymentByOrderId(int id) {
    	return paymentDAO.deletePaymentByOrderId(id);
    }
}
