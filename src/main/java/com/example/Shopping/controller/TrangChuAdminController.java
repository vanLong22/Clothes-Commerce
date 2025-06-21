package com.example.Shopping.controller;


import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.Shopping.model.Order;
import com.example.Shopping.model.Product;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.ProductService;
import com.example.Shopping.service.UserService;

import org.springframework.ui.Model;

@Controller
@RequestMapping("/admin")
public class TrangChuAdminController {

	@Autowired
    private ProductService productService;
	
	@Autowired
    private UserService userService;
	
	@Autowired
    private OrderService orderService;
	
    @GetMapping("/trangchu")
    public String showPageAdmin(Model model) {
    	
    	int totalProduct = productService.totalProduct();
    	int totalUser = userService.totalUser();
    	int totalOrder = orderService.totalOrder();
    	BigDecimal totalRevenue = orderService.getTotalRevenue();
    	List<Product> allProducts = productService.getAllProducts();
    	List<Order> allOrders = orderService.getAllOrders();
    	
    	model.addAttribute("totalPrice", 1000000);
        model.addAttribute("totalProduct", totalProduct);
        model.addAttribute("totalUser", totalUser);
        model.addAttribute("totalOrder", totalOrder); 
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("allProducts", allProducts);
        model.addAttribute("allOrders", allOrders);
        
        return "admin/trangchu"; 
    }
}