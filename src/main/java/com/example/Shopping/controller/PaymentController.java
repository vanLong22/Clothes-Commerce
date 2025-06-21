package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.Shopping.configuration.Config;
import com.example.Shopping.dto.PaymentResDTO;
import com.example.Shopping.model.Order;
import com.example.Shopping.model.Payment;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.PaymentService;
import com.google.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

@RestController
@RequestMapping("/api/payment")
public class PaymentController {
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
    private OrderService orderService;
	
    @GetMapping("/create_payment")
    public ResponseEntity<?> createPayment(@RequestParam("amount") long amount, @RequestParam("orderId") int orderId, @RequestParam("addressId") int addressId) {
        //String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = "127.0.0.1"; // Giả định IP  
        String vnp_TmnCode = Config.vnp_TmnCode;
        amount = amount * 100; 
        String bankCode = "NCB";
        String language = "vn";
        String orderType = "other";

        System.out.println("Address Id được gửi từ paymentController crate_payment: " + addressId);
        
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", Config.vnp_Version);   
        vnp_Params.put("vnp_Command", Config.vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_BankCode", bankCode);
        vnp_Params.put("vnp_Locale", language);
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_TxnRef", String.valueOf(orderId));
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + orderId + " - Dia chi: " + addressId);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        try {
            while (itr.hasNext()) {
                String fieldName = itr.next();
                String fieldValue = vnp_Params.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString())).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new PaymentResDTO("Error", "Failed to encode parameters", null));
        }

        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

        PaymentResDTO paymentResDTO = new PaymentResDTO();
        paymentResDTO.setStatus("Ok");
        paymentResDTO.setMessage("Successfully");
        paymentResDTO.setURL(paymentUrl);

        return ResponseEntity.status(HttpStatus.OK).body(paymentResDTO);
    }

    @GetMapping("/payment_infor")
    public String transaction(@RequestParam Map<String, String> params, HttpServletResponse response) throws IOException {
        // Lấy các tham số trả về từ VNPAY
        String vnp_SecureHash = params.get("vnp_SecureHash");
        String vnp_TxnRef = params.get("vnp_TxnRef");
        System.out.println("Id đơn hàng là: " + vnp_TxnRef);
        String vnp_Amount = params.get("vnp_Amount");
        String vnp_BankCode = params.get("vnp_BankCode");
        String vnp_ResponseCode = params.get("vnp_ResponseCode");
        String vnp_TransactionNo = params.get("vnp_TransactionNo");

        params.remove("vnp_SecureHash");

        // Kiểm tra chữ ký bảo mật
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        for (String fieldName : fieldNames) {
            String fieldValue = params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (fieldNames.indexOf(fieldName) < fieldNames.size() - 1) {
                    hashData.append('&');
                }
            }
        }

        String calculatedHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
        if (!calculatedHash.equals(vnp_SecureHash)) {
            // Chuyển hướng đến trang lỗi nếu chữ ký không hợp lệ
            response.sendRedirect("/Shopping/xacnhanthanhtoan?orderId=" + vnp_TxnRef + "&status=failed&message=Invalid secure hash");
            return null;
        }

        String vnp_OrderInfo = params.get("vnp_OrderInfo"); 
        String addressId = null;  

        if (vnp_OrderInfo != null && vnp_OrderInfo.contains(" - Dia chi: ")) {
            String[] parts = vnp_OrderInfo.split(" - Dia chi: ");
            if (parts.length > 1) {
                addressId = parts[1].trim(); // Lấy phần addressId và loại bỏ khoảng trắng
            }
        }
        System.out.println("Address Id được gửi từ paymentController: " + addressId);
        
        // Xử lý giao dịch
        if ("00".equals(vnp_ResponseCode)) {
            int orderId = Integer.parseInt(vnp_TxnRef);
            
            paymentService.updatePaymentStatus(orderId, "Paid");

            // Chuyển hướng đến trang xác nhận với thông tin giao dịch
            String redirectUrl = String.format(
                    "/Shopping/xacnhanthanhtoan?orderId=%s&status=success&amount=%s&bankCode=%s&transactionNo=%s&addressId=%s",
                    vnp_TxnRef, Long.parseLong(vnp_Amount) / 100, vnp_BankCode, vnp_TransactionNo, addressId);
            response.sendRedirect(redirectUrl);
        } else {
            int orderId = Integer.parseInt(vnp_TxnRef);
            paymentService.updatePaymentStatus(orderId, "Failed");

            // Chuyển hướng đến trang xác nhận với thông báo thất bại
            response.sendRedirect("/Shopping/xacnhanthanhtoan?orderId=" + vnp_TxnRef + "&status=failed&message=Payment failed with code " + vnp_ResponseCode);
        }

        return null;
    }
    
    
    @GetMapping("/refund")
    public ResponseEntity<?> refund(
            @RequestParam("orderId") int orderId,
            @RequestParam("transDate") String transDate,
            @RequestParam("amount") long amount,
            @RequestParam(value = "transType", defaultValue = "02") String transType, // 02: Hoàn tiền toàn phần
            @RequestParam(value = "user", defaultValue = "admin") String user,
            HttpServletRequest request) throws Exception {

    	// Lấy thông tin về hóa đơn đơn hàng
    	Payment payment = paymentService.getPaymentByOrderId(orderId); 
    	
        // Kiểm tra đơn hàng
        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new PaymentResDTO("Error", "Order not found", null));
        }

        // Kiểm tra trạng thái thanh toán
        String paymentStatus = payment.getStatus();
        if (!"Paid".equals(paymentStatus)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new PaymentResDTO("Error", "Order has not been paid or payment status is invalid", null));
        }

        // Chuẩn bị tham số cho yêu cầu hoàn tiền
        String vnp_RequestId = Config.getRandomNumber(8);
        String vnp_Version = "2.1.0";
        String vnp_Command = "refund";
        String vnp_TmnCode = Config.vnp_TmnCode;
        String vnp_TransactionType = transType;
        String vnp_TxnRef = String.valueOf(orderId); 
        amount = amount * 100; 
        String vnp_Amount = String.valueOf(amount);
        String vnp_OrderInfo = "Hoan tien don hang OrderId:" + vnp_TxnRef;
        String vnp_TransactionNo = payment.getTransactionNo(); 
        String vnp_TransactionDate = transDate;
        String vnp_CreateBy = user;

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());

        String vnp_IpAddr = "127.0.0.1";

        // Tạo JsonObject chứa các tham số
        JsonObject vnp_Params = new JsonObject();
        vnp_Params.addProperty("vnp_RequestId", vnp_RequestId);
        vnp_Params.addProperty("vnp_Version", vnp_Version);
        vnp_Params.addProperty("vnp_Command", vnp_Command);
        vnp_Params.addProperty("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.addProperty("vnp_TransactionType", vnp_TransactionType);
        vnp_Params.addProperty("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.addProperty("vnp_Amount", vnp_Amount);
        vnp_Params.addProperty("vnp_OrderInfo", vnp_OrderInfo);

        if (vnp_TransactionNo != null && !vnp_TransactionNo.isEmpty()) {
            vnp_Params.addProperty("vnp_TransactionNo", vnp_TransactionNo);
        } else {
            vnp_Params.addProperty("vnp_TransactionNo", "");
        }

        vnp_Params.addProperty("vnp_TransactionDate", vnp_TransactionDate);
        vnp_Params.addProperty("vnp_CreateBy", vnp_CreateBy);
        vnp_Params.addProperty("vnp_CreateDate", vnp_CreateDate);
        vnp_Params.addProperty("vnp_IpAddr", vnp_IpAddr);

        // Tạo chuỗi hash để tính vnp_SecureHash
        String hash_Data = String.join("|", vnp_RequestId, vnp_Version, vnp_Command, vnp_TmnCode,
                vnp_TransactionType, vnp_TxnRef, vnp_Amount, vnp_TransactionNo, vnp_TransactionDate,
                vnp_CreateBy, vnp_CreateDate, vnp_IpAddr, vnp_OrderInfo);

        String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hash_Data);
        vnp_Params.addProperty("vnp_SecureHash", vnp_SecureHash);

        // Gửi yêu cầu hoàn tiền tới VNPAY
        URL url = new URL(Config.vnp_ApiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(vnp_Params.toString());
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String output;
        StringBuffer response = new StringBuffer();
        while ((output = in.readLine()) != null) {
            response.append(output);
        }
        in.close();

        // Log kết quả
        System.out.println("Sending 'POST' request to URL: " + url);
        System.out.println("Post Data: " + vnp_Params);
        System.out.println("Response Code: " + responseCode);
        System.out.println("Response: " + response.toString());

        // Kiểm tra phản hồi từ VNPAY
        JsonObject responseJson = Config.parseJsonResponse(response.toString());
        String responseCodeFromVNPay = responseJson.get("vnp_ResponseCode").getAsString();

        if ("00".equals(responseCodeFromVNPay)) {
            // Hoàn tiền thành công, cập nhật trạng thái đơn hàng và thanh toán
            orderService.updateOrderStatus(orderId, "Cancelled");
            paymentService.updatePaymentStatus(orderId, "Refunded");
            return ResponseEntity.status(HttpStatus.OK)
                    .body(new PaymentResDTO("Ok", "Refund successful", response.toString()));
        } else {
            // Hoàn tiền thất bại
            String message = responseJson.has("vnp_Message") ? responseJson.get("vnp_Message").getAsString() : "Refund failed";
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new PaymentResDTO("Error", message, response.toString()));
        }
    }
//
//    private String getClientIp(HttpServletRequest request) {
//        String remoteAddr = request.getHeader("X-Forwarded-For");
//        if (remoteAddr != null && !remoteAddr.isEmpty()) {
//            return remoteAddr.split(",")[0];
//        }
//        remoteAddr = request.getHeader("X-Real-IP");
//        if (remoteAddr != null && !remoteAddr.isEmpty()) {
//            return remoteAddr;
//        }
//        return request.getRemoteAddr();
//    }
}