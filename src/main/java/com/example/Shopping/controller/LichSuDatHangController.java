package com.example.Shopping.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.Shopping.model.Order;
import com.example.Shopping.model.OrderDetail;
import com.example.Shopping.service.OrderDetailService;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.ProductService;

@Controller
@RestController
@RequestMapping("/order") //@RequestMapping("/lichsudathang")
public class LichSuDatHangController {

    private final OrderService orderService;
    private final ProductService productService;
    private final OrderDetailService orderDetailService;
    
    public LichSuDatHangController(OrderService orderService, ProductService productService,
			OrderDetailService orderDetailService) {
		super();
		this.orderService = orderService;
		this.productService = productService;
		this.orderDetailService = orderDetailService;
	}

    @GetMapping
    public String getOrderHistory(@RequestParam("userId") int userId, Model model) {
        List<Order> orders = orderService.getAllOrdersByUserId(userId);
        System.out.println("Orders: " + orders); // Log để kiểm tra dữ liệu

        List<Integer> orderIds = new ArrayList<>();
        for (Order order : orders) {
            orderIds.add(order.getId());
        }

        List<OrderDetail> orderDetails = orderDetailService.getOrderDetailsByOrderIds(orderIds);
        System.out.println("Order Details: " + orderDetails); // Log để kiểm tra dữ liệu

        model.addAttribute("orders", orders);
        model.addAttribute("orderDetails", orderDetails);

        return "thongtincanhan"; // Trả về tên view JSP
    }
    
//    @PostMapping
//    public int createOrder(@RequestBody Order order) {
//    	if (order.getCreatedAt() == null) {
//    		order.setCreatedAt(new java.sql.Date(System.currentTimeMillis()));
//        }
//    	
//        return orderService.addOrder(order);
//    }

    @PostMapping("/detail")
    public int createOrderDetail(@RequestBody OrderDetail orderDetail) {
    	if (orderDetail.getCreateAt() == null) {
    		orderDetail.setCreateAt(new java.sql.Date(System.currentTimeMillis()));
        }
    	
        return orderDetailService.addOrderDetail(orderDetail);
    }

    @PostMapping("/updateQuantity")
    public int updateProductQuantity(@RequestBody Map<String, Integer> data) {
        int productId = data.get("productId");
        int quantity = data.get("quantity");
        return productService.updateQuantity(productId, quantity);
    }
}








