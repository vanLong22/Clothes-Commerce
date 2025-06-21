//package com.example.Shopping.controller;
//
//
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.example.Shopping.model.Payment;
//import com.example.Shopping.service.PaymentService;
//
//
//@Controller
//public class XacNhanThanhToanController {
//	@Autowired
//    private PaymentService paymentService;
//	
//	@GetMapping("/xacnhanthanhtoan")
//    public String showAfterPaymentPage(@RequestParam("orderId") int orderId, Model model) {
//		Payment infoOrder = paymentService.getPaymentByOrderId(orderId);
//		
//		model.addAttribute("infoOrder", infoOrder);
//		
//        return "xacnhanthanhtoan";
//    }
//}
