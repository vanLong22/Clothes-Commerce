package com.example.Shopping.service;

import com.example.Shopping.dao.OrderDetailDAO;
import com.example.Shopping.model.OrderDetail;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class OrderDetailService {
    private final OrderDetailDAO orderDetailDAO;

    public OrderDetailService(OrderDetailDAO orderDetailDAO) {
        this.orderDetailDAO = orderDetailDAO;
    }

    public List<OrderDetail> getAllOrderDetails() {
        return orderDetailDAO.getAllOrderDetails();
    }

    public OrderDetail getOrderDetailById(int id) {
        return orderDetailDAO.getOrderDetailById(id);
    }

    public int addOrderDetail(OrderDetail orderDetail) {
        return orderDetailDAO.addOrderDetail(orderDetail);
    }

    public int updateOrderDetail(OrderDetail orderDetail) {
        return orderDetailDAO.updateOrderDetail(orderDetail);
    }

    public int deleteOrderDetail(int id) {
        return orderDetailDAO.deleteOrderDetail(id);
    }

    public List<OrderDetail> getOrderDetailsByOrderIds(List<Integer> orderIds) {
        return orderDetailDAO.getOrderDetailsByOrderIds(orderIds);
    }
    
    
    
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        return orderDetailDAO.getOrderDetailsByOrderId(orderId);
    }
    
    public int deleteOrderDetailByOrderId(int id) {
    	return orderDetailDAO.deleteOrderDetailByOrderId(id);
    }
    
    public List<Map<String, Object>> getTopSellingProducts(int limit) {
    	return orderDetailDAO.getTopSellingProducts(limit);
    }
}