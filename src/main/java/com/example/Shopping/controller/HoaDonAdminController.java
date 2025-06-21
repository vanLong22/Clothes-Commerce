package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.Shopping.model.Order;
import com.example.Shopping.model.OrderDetail;
import com.example.Shopping.model.Payment;
import com.example.Shopping.service.OrderDetailService;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.PaymentService;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class HoaDonAdminController {

    @Autowired
    private OrderService orderService;
    
    @Autowired
    private OrderDetailService orderDetailService;
    
    @Autowired
    private PaymentService paymentService;

    @GetMapping("/hoadon")
    public String hienThiDanhSachHoaDon(
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "2") int size,
            Model model) {
        try {
            // Fetch orders based on search and pagination
            List<Order> orders = orderService.getOrders(search, page, size);
            int totalOrders = orderService.getTotalOrders(search);
            int totalPages = (int) Math.ceil((double) totalOrders / size);

            for (Order order : orders) {
                List<OrderDetail> orderDetails = orderDetailService.getOrderDetailsByOrderId(order.getId());
                order.setOrderDetails(orderDetails); // Giả sử Order có phương thức setOrderDetails
            }
            
            int totalInvoices = orderService.getTotalInvoices();
            int completedInvoices = orderService.getCompletedInvoices();
            int processingInvoices = orderService.getProcessingInvoices();
            BigDecimal totalRevenue = orderService.getTotalRevenue();

            // Add to model
            model.addAttribute("orders", orders);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("search", search);
            model.addAttribute("totalInvoices", totalInvoices);
            model.addAttribute("completedInvoices", completedInvoices);
            model.addAttribute("processingInvoices", processingInvoices);
            model.addAttribute("totalRevenue", totalRevenue);

            return "admin/hoadon";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải danh sách hóa đơn: " + e.getMessage());
            return "admin/hoadon";
        }
    }

    @GetMapping("/hoadon/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getOrderDetails(@PathVariable int id) {
        try {
            Order order = orderService.getOrderById(id);
            if (order == null) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            
            List<OrderDetail> orderDetails = orderDetailService.getOrderDetailsByOrderId(id);
            Payment payment = paymentService.getPaymentByOrderId(id);

            Map<String, Object> data = new HashMap<>();
            data.put("order", order);
            data.put("orderDetails", orderDetails);
            data.put("payment", payment);

            return new ResponseEntity<>(data, HttpStatus.OK);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Lỗi khi lấy chi tiết hóa đơn: " + e.getMessage());
            return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/hoadon/update")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateOrderStatus(
            @RequestParam int id, 
            @RequestParam String status) {
        Map<String, Object> response = new HashMap<>();
        try {
            // Validate status
            if (!isValidStatus(status)) {
                response.put("error", "Trạng thái không hợp lệ");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            }

            Order order = orderService.getOrderById(id);
            if (order == null) {
                response.put("error", "Không tìm thấy hóa đơn");
                return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
            }

            orderService.updateOrderStatus(id, status);
            
            response.put("message", "Cập nhật trạng thái thành công");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("error", "Lỗi khi cập nhật trạng thái: " + e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/hoadon/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteOrder(@RequestParam int id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Order order = orderService.getOrderById(id);
            if (order == null) {
                response.put("error", "Không tìm thấy hóa đơn");
                return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
            }

            orderService.deleteOrder(id);
            orderDetailService.deleteOrderDetailByOrderId(id);
            paymentService.deletePaymentByOrderId(id);
            
            response.put("message", "Xóa hóa đơn thành công");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("error", "Lỗi khi xóa hóa đơn: " + e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private boolean isValidStatus(String status) {
        return status != null && (
            status.equals("pending") ||
            status.equals("processing") ||
            status.equals("delivered") ||
            status.equals("cancelled")
        );
    }
}