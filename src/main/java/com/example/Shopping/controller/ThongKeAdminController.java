package com.example.Shopping.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.Shopping.model.Order;
import com.example.Shopping.service.OrderDetailService;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.PaymentService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/admin")
public class ThongKeAdminController {

    @Autowired
    private OrderService orderService;
    
    @Autowired
    private OrderDetailService orderDetailService;
    
    @Autowired
    private PaymentService paymentService;


    
    @GetMapping("/thongke")
    public String hienThiThongKe(Model model) throws JsonProcessingException {
    	BigDecimal totalRevenue = orderService.getTotalRevenue();
        model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : BigDecimal.ZERO);

        // 2. Tổng đơn hàng trong tháng
        int totalOrders = orderService.getTotalOrdersInMonth();
        model.addAttribute("totalOrders", totalOrders);

        // 3. Khách hàng mới trong tháng
        /*
        int newCustomers = userDAO.getNewCustomersInMonth();
        model.addAttribute("newCustomers", newCustomers);
		*/   

        // 4. Tỷ lệ hoàn thành
        int deliveredOrders = orderService.getCompletedInvoices();
        int totalOrdersAll = orderService.getTotalInvoices();
        double completionRate = (totalOrdersAll > 0) ? (double) deliveredOrders / totalOrdersAll * 100 : 0;
        model.addAttribute("completionRate", completionRate);

        
        // 5. Doanh thu theo tháng
        List<Map<String, Object>> monthlyRevenue = orderService.getMonthlyRevenue();
        model.addAttribute("monthlyRevenue", monthlyRevenue);

        // 6. Phân phối trạng thái đơn hàng
        List<Map<String, Object>> orderStatusDistribution = orderService.getOrderStatusDistribution();
        model.addAttribute("orderStatusDistribution", orderStatusDistribution);

        // 7. Top sản phẩm bán chạy
        List<Map<String, Object>> topProducts = orderDetailService.getTopSellingProducts(5);
        model.addAttribute("topProducts", topProducts);
        
        ObjectMapper mapper = new ObjectMapper();
        
        // Chuyển đổi dữ liệu sang JSON
        String monthlyRevenueJson = mapper.writeValueAsString(monthlyRevenue);
        model.addAttribute("monthlyRevenueJson", monthlyRevenueJson);
        
        // Tương tự cho các dữ liệu khác
        String orderStatusDistributionJson = mapper.writeValueAsString(orderStatusDistribution);
        model.addAttribute("orderStatusDistributionJson", orderStatusDistributionJson);
        
        String topProductsJson = mapper.writeValueAsString(topProducts);
        model.addAttribute("topProductsJson", topProductsJson);

        
        
        // 8. Đơn hàng gần đây
        List<Order> recentOrders = orderService.getRecentOrders(5);
        model.addAttribute("recentOrders", recentOrders);
    	
    	return "admin/thongke";
    }
    
}