package com.example.Shopping.service;

import com.example.Shopping.dao.OrderDAO;
import com.example.Shopping.model.Order;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class OrderService {
    private final OrderDAO orderDAO;

    public OrderService(OrderDAO orderDAO) {
        this.orderDAO = orderDAO;
    }
    
    public int totalOrder() {
        return orderDAO.totalOrder();
    }

    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    public int addOrder(Order order) {
        return orderDAO.addOrder(order);
    }

    public int updateOrder(Order order) {
        return orderDAO.updateOrder(order);
    }

    public int deleteOrder(int id) {
        return orderDAO.deleteOrder(id);
    }
    
    public List<Order> getAllOrdersByUserId(int userId) {
        return orderDAO.getAllOrdersByUserId(userId);
    }
    
    public void updateOrderStatus(int orderId, String status) {
    	orderDAO.updateOrderStatus(orderId, status);
    }
    
    
    
    
    public int getTotalInvoices() {
    	return orderDAO.getTotalInvoices();
    }
    
    public int getCompletedInvoices() {
    	return orderDAO.getCompletedInvoices();
    }
    
    public int getProcessingInvoices() {
    	return orderDAO.getProcessingInvoices();
    }
    
    public BigDecimal getTotalRevenue() {
    	return orderDAO.getTotalRevenue();
    }
    
    public List<Order> getAllOrdersWithDetails(){
    	return orderDAO.getAllOrdersWithDetails();
    }
    
    public List<Order> getOrders(String search, int page, int size) {
         return orderDAO.getOrders(search, page, size);
    }

    public int getTotalOrders(String search) {
        return orderDAO.getTotalOrders(search);
    }
    
    public int getTotalOrdersInMonth() {
    	return orderDAO.getTotalOrdersInMonth();
    }
    
    public List<Map<String, Object>> getMonthlyRevenue() {
    	return orderDAO.getMonthlyRevenue();
    }
    
    public List<Map<String, Object>> getOrderStatusDistribution() {
        return orderDAO.getOrderStatusDistribution();
    }

    // Danh sách 5 đơn hàng gần đây
    public List<Order> getRecentOrders(int limit) {
        return orderDAO.getRecentOrders(limit);
    }
    
}
