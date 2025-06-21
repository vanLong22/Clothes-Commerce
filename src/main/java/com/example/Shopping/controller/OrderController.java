package com.example.Shopping.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.Shopping.model.Order;
import com.example.Shopping.model.OrderDetail;
import com.example.Shopping.model.Payment;
import com.example.Shopping.model.Product;
import com.example.Shopping.model.Address;
import com.example.Shopping.service.ProductService;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.OrderDetailService;
import com.example.Shopping.service.AddressService;
import com.example.Shopping.service.PaymentService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

@Controller
public class OrderController {

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/thanhtoan")
    public String showPaymentPage(
            @RequestParam("productId") int productId,
            @RequestParam("quantity") int quantity,
            @RequestParam("color") String color,
            @RequestParam("size") String size,
            @RequestParam("userId") int userId,
            Model model) {
        List<Product> product = productService.getProductById(productId);
        List<Address> address = addressService.getAddressesByUserId(userId);

        if (product == null || product.isEmpty()) {
            return "error";
        }
        model.addAttribute("product", product);
        model.addAttribute("quantity", quantity);
        model.addAttribute("color", color);
        model.addAttribute("size", size);
        model.addAttribute("address", address);

        return "thanhtoan";
    }

    @PostMapping("/donhang")
    @ResponseBody
    public int createOrder(@RequestBody Order order) {
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	        String currentDate = formatter.format(new Date());
	        
	        order.setCreatedAt(currentDate);
    	
        return orderService.addOrder(order);
    }

    @PostMapping("/donhang/chitiet")
    @ResponseBody
    public int createOrderDetail(@RequestBody OrderDetail orderDetail) {
        if (orderDetail.getCreateAt() == null) {
            orderDetail.setCreateAt(new java.sql.Date(System.currentTimeMillis()));
        }
        return orderDetailService.addOrderDetail(orderDetail);
    }

    @PostMapping("/donhang/capnhatsoluong")
    @ResponseBody
    public int updateProductQuantity(@RequestBody Map<String, Integer> data) {
        int productId = data.get("productId");
        int quantity = data.get("quantity");
        return productService.updateQuantity(productId, quantity);
    }

    
    @PostMapping("/thongtinthanhtoan")
    @ResponseBody
    public int processPayment(@RequestBody Payment payment) {
        if (payment.getCreateAt() == null) {
            payment.setCreateAt(new java.sql.Date(System.currentTimeMillis()));
        }
        return paymentService.addPayment(payment);
    }
    
//    @PostMapping("/thongtinthanhtoan")
//    @ResponseBody
//    public int processPayment(@RequestBody Payment payment) {
//        // Define the original format of createAt (adjust this to match your input)
//        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        // Define the VNPAY format
//        SimpleDateFormat vnpayFormat = new SimpleDateFormat("yyyyMMddHHmmss");
//        vnpayFormat.setTimeZone(TimeZone.getTimeZone("Etc/GMT+7"));
//
//        try {
//            // Parse the createAt string into a Date object
//            Date createAtDate = originalFormat.parse(payment.getCreateAt());
//            // Format the Date into the VNPAY format
//            String vnpayFormattedDate = vnpayFormat.format(createAtDate);
//            // Update the Payment object with the formatted string
//            payment.setCreateAt(vnpayFormattedDate);
//        } catch (ParseException e) {
//            // Handle the case where createAt cannot be parsed
//            throw new IllegalArgumentException("Invalid date format for createAt: " + payment.getCreateAt(), e);
//        }
//
//        // Save the updated Payment object and return the result
//        return paymentService.addPayment(payment);
//    }

    @GetMapping("/xacnhanthanhtoan")
    public String confirmPayment(
            @RequestParam("orderId") int orderId,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "amount", required = false) String amount,
            @RequestParam(value = "bankCode", required = false) String bankCode,
            @RequestParam(value = "transactionNo", required = false) String transactionNo,
            @RequestParam(value = "message", required = false) String message,
            @RequestParam(value = "addressId", required = false) String addressId,
            Model model) {
    	
    	System.out.println("Address Id được gửi từ OrderController: " + addressId);
    	System.out.println("Order Id được gửi từ OrderController: " + orderId);
    	System.out.println("Số giao dịch là " + transactionNo);
    	
    	paymentService.updateTransactionNo(orderId, transactionNo); 
    	Address address = addressService.getAddressById(Integer.parseInt(addressId));
        Order order = orderService.getOrderById(orderId);
        List<OrderDetail> orderDetails = orderDetailService.getOrderDetailsByOrderIds(List.of(orderId));
        Payment infoOrder = paymentService.getPaymentByOrderId(orderId);
		
        model.addAttribute("address", address);
		model.addAttribute("infoOrder", infoOrder);
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("status", status);
        model.addAttribute("amount", amount);
        model.addAttribute("bankCode", bankCode);
        model.addAttribute("transactionNo", transactionNo);
        model.addAttribute("message", message);
        return "xacnhanthanhtoan";
    }
    
    
//    @GetMapping("/donhang/trangthai")
//    public ResponseEntity<?> cancelOrder(@RequestParam("orderId") int orderId) {
//        
//    	
//    }


    
//    
//    @PostMapping("/vnpay/refund")
//    public String refundVnpay(
//            @RequestParam("trantype") String vnp_TransactionType,
//            @RequestParam("order_id") String vnp_TxnRef,
//            @RequestParam("amount") int amount,
//            @RequestParam("trans_date") String vnp_TransactionDate,
//            @RequestParam("user") String vnp_CreateBy,
//            HttpServletRequest request) throws IOException {
//
//        // Tạo các tham số cho yêu cầu hoàn tiền
//        String vnp_RequestId = Config.getRandomNumber(8);
//        String vnp_Version = "2.1.0";
//        String vnp_Command = "refund";
//        String vnp_TmnCode = Config.vnp_TmnCode;
//        long vnp_Amount = amount * 100L; // Chuyển sang đơn vị nhỏ nhất (VND x 100)
//        String vnp_OrderInfo = "Hoan tien GD OrderId:" + vnp_TxnRef;
//        String vnp_TransactionNo = ""; // Giả sử không có giá trị này
//        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
//        String vnp_CreateDate = formatter.format(cld.getTime());
//        String vnp_IpAddr = Config.getIpAddress(request);
//
//        // Tạo đối tượng JSON chứa tham số
//        JsonObject vnp_Params = new JsonObject();
//        vnp_Params.addProperty("vnp_RequestId", vnp_RequestId);
//        vnp_Params.addProperty("vnp_Version", vnp_Version);
//        vnp_Params.addProperty("vnp_Command", vnp_Command);
//        vnp_Params.addProperty("vnp_TmnCode", vnp_TmnCode);
//        vnp_Params.addProperty("vnp_TransactionType", vnp_TransactionType);
//        vnp_Params.addProperty("vnp_TxnRef", vnp_TxnRef);
//        vnp_Params.addProperty("vnp_Amount", String.valueOf(vnp_Amount));
//        vnp_Params.addProperty("vnp_OrderInfo", vnp_OrderInfo);
//
//        // Nếu có vnp_TransactionNo, thêm vào JSON
//        if (vnp_TransactionNo != null && !vnp_TransactionNo.isEmpty()) {
//            vnp_Params.addProperty("vnp_TransactionNo", vnp_TransactionNo);
//        }
//
//        vnp_Params.addProperty("vnp_TransactionDate", vnp_TransactionDate);
//        vnp_Params.addProperty("vnp_CreateBy", vnp_CreateBy);
//        vnp_Params.addProperty("vnp_CreateDate", vnp_CreateDate);
//        vnp_Params.addProperty("vnp_IpAddr", vnp_IpAddr);
//
//        // Tạo chuỗi hash data để tính secure hash
//        String hash_Data = String.join("|", vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode,
//                vnp_TransactionType, vnp_TxnRef, String.valueOf(vnp_Amount), vnp_TransactionNo,
//                vnp_TransactionDate, vnp_CreateBy, vnp_CreateDate, vnp_IpAddr, vnp_OrderInfo);
//
//        // Tính mã bảo mật bằng HMAC SHA512
//        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hash_Data);
//        vnp_Params.addProperty("vnp_SecureHash", vnp_SecureHash);
//
//        // Gửi yêu cầu POST đến API của VNPAY
//        URL url = new URL(Config.vnp_ApiUrl);
//        HttpURLConnection con = (HttpURLConnection) url.openConnection();
//        con.setRequestMethod("POST");
//        con.setRequestProperty("Content-Type", "application/json");
//        con.setDoOutput(true);
//
//        // Ghi dữ liệu JSON vào request
//        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
//        wr.writeBytes(vnp_Params.toString());
//        wr.flush();
//        wr.close();
//
//        // Nhận phản hồi từ VNPAY
//        int responseCode = con.getResponseCode();
//        System.out.println("Response Code: " + responseCode);
//
//        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
//        String output;
//        StringBuffer response = new StringBuffer();
//        while ((output = in.readLine()) != null) {
//            response.append(output);
//        }
//        in.close();
//
//        // In phản hồi để debug
//        System.out.println("Response from VNPAY: " + response.toString());
//
//        // Trả về phản hồi từ VNPAY dưới dạng chuỗi
//        return response.toString();
//    }
}