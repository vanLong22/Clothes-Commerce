//package com.example.Shopping.controller;
//
//import java.sql.Date;
//import java.util.List;
//import java.util.Map;
//import java.net.http.HttpClient;
//import java.net.http.HttpRequest;
//import java.net.http.HttpResponse;
//import java.net.URI;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.example.Shopping.model.Address;
//import com.example.Shopping.model.Order;
//import com.example.Shopping.model.OrderDetail;
//import com.example.Shopping.model.Payment;
//import com.example.Shopping.model.Product;
//import com.example.Shopping.service.AddressService;
//import com.example.Shopping.service.OrderDetailService;
//import com.example.Shopping.service.OrderService;
//import com.example.Shopping.service.PaymentService;
//import com.example.Shopping.service.ProductService;
//
//import org.json.JSONObject;
//import org.json.JSONArray;
//
//@Controller
//public class ThanhToanController {
//
//    @Autowired
//    private ProductService productService;
//
//    @Autowired
//    private OrderService orderService;
//
//    @Autowired
//    private OrderDetailService orderDetailService;
//
//    @Autowired
//    private AddressService addressService;
//
//    @Autowired
//    private PaymentService paymentService;
//
//    private static final String VIETQR_API_URL = "https://api.vietqr.org/vqr/api/transactions/check-order";
//    private static final String VIETQR_AUTH_URL = "https://api.vietqr.org/vqr/api/auth/get-token"; // Xác nhận với VietQR
//    private static final String BANK_ACCOUNT = "20123418072004"; // Xác nhận với VietQR
//    private static final String CLIENT_ID = "95197b7b-8626-4c20-b14a-40df6bc97ca0";
//    private static final String API_KEY = "1e1999dd-0feb-44c8-90e1-0f8c76cd3347";
//    private static final String CHECKSUM_KEY = "586151983a08818cbde97e319f3fd3a19f466fa35e2276fc9eeaf780c59d8c5a";
//
//    private String TOKEN;
//    private long tokenExpiryTime;
//
//    // Lấy Bearer Token
//    private String getVietQRToken() throws Exception {
//        if (TOKEN == null || System.currentTimeMillis() > tokenExpiryTime) {
//            JSONObject authPayload = new JSONObject();
//            authPayload.put("clientId", CLIENT_ID);
//            authPayload.put("apiKey", API_KEY);
//
//            HttpClient client = HttpClient.newHttpClient();
//            HttpRequest request = HttpRequest.newBuilder()
//                    .uri(URI.create(VIETQR_AUTH_URL))
//                    .header("Content-Type", "application/json")
//                    .POST(HttpRequest.BodyPublishers.ofString(authPayload.toString()))
//                    .build();
//
//            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
//            System.out.println("VietQR Auth Response: Status=" + response.statusCode() + ", Body=" + response.body());
//
//            if (response.statusCode() != 200) {
//                throw new RuntimeException("Failed to get VietQR token. Status: " + response.statusCode() + ", Body: " + response.body());
//            }
//
//            JSONObject responseJson = new JSONObject(response.body());
//            // Kiểm tra cấu trúc phản hồi thực tế từ VietQR
//            // Nếu token nằm trong "data.token", sử dụng:
//            // JSONObject data = responseJson.getJSONObject("data");
//            // TOKEN = data.getString("token");
//            TOKEN = responseJson.getString("token"); // Giữ nguyên nếu token nằm trực tiếp
//            tokenExpiryTime = System.currentTimeMillis() + 300000; // 300 giây
//        }
//        return TOKEN;
//    }
//
//    // Display payment page
//    @GetMapping("/thanhtoan")
//    public String showPaymentPage(
//            @RequestParam("productId") int productId,
//            @RequestParam("quantity") int quantity,
//            @RequestParam("color") String color,
//            @RequestParam("size") String size,
//            @RequestParam("userId") int userId,
//            Model model) {
//        List<Product> product = productService.getProductById(productId);
//        List<Address> address = addressService.getAddressesByUserId(userId);
//
//        if (product == null || product.isEmpty()) {
//            return "error";
//        }
//        model.addAttribute("product", product);
//        model.addAttribute("quantity", quantity);
//        model.addAttribute("color", color);
//        model.addAttribute("size", size);
//        model.addAttribute("address", address);
//
//        return "thanhtoan";
//    }
//
//    // Create a new order
//    @PostMapping("/donhang")
//    @ResponseBody
//    public int createOrder(@RequestBody Order order) {
//        if (order.getCreatedAt() == null) {
//            order.setCreatedAt(new Date(System.currentTimeMillis()));
//        }
//        return orderService.addOrder(order);
//    }
//
//    // Create order detail
//    @PostMapping("/donhang/chitiet")
//    @ResponseBody
//    public int createOrderDetail(@RequestBody OrderDetail orderDetail) {
//        if (orderDetail.getCreateAt() == null) {
//            orderDetail.setCreateAt(new Date(System.currentTimeMillis()));
//        }
//        return orderDetailService.addOrderDetail(orderDetail);
//    }
//
//    // Update product quantity
//    @PostMapping("/donhang/capnhatsoluong")
//    @ResponseBody
//    public int updateProductQuantity(@RequestBody Map<String, Integer> data) {
//        int productId = data.get("productId");
//        int quantity = data.get("quantity");
//        return productService.updateQuantity(productId, quantity);
//    }
//
//    // Process payment
//    @PostMapping("/thongtinthanhtoan")
//    @ResponseBody
//    public int processPayment(@RequestBody Payment payment) {
//        if (payment.getCreateAt() == null) {
//            payment.setCreateAt(new Date(System.currentTimeMillis()));
//        }
//        return paymentService.addPayment(payment);
//    }
//
//    // Verify payment using VietQR API
//    @GetMapping("/verifyPayment")
//    @ResponseBody
//    public String verifyPayment(@RequestParam String orderId, @RequestParam String totalAmount) {
//        try {
//        	System.out.println("Tong tiên cần thanh toán là: " + totalAmount);
//        	double totalAmountDouble = Double.parseDouble(totalAmount);
//        	
//            // Lấy Bearer Token
//            String token = getVietQRToken();
//
//            // Tạo payload cho API  
//            JSONObject payload = new JSONObject();
//            payload.put("bankAccount", BANK_ACCOUNT);
//            payload.put("type", 0); // Check by orderId
//            payload.put("value", orderId);
//            payload.put("checkSum", CHECKSUM_KEY); // Sử dụng Checksum Key từ VietQR
// 
//            // Gửi yêu cầu đến VietQR API
//            HttpClient client = HttpClient.newHttpClient();
//            HttpRequest httpRequest = HttpRequest.newBuilder()
//                    .uri(URI.create(VIETQR_API_URL))
//                    .header("Content-Type", "application/json")
//                    .header("Authorization", "Bearer " + token)
//                    .POST(HttpRequest.BodyPublishers.ofString(payload.toString()))
//                    .build();
//
//            HttpResponse<String> apiResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());
//            JSONArray transactions = new JSONArray(apiResponse.body());
//
//            JSONObject result = new JSONObject();
//            if (transactions.length() > 0) {
//                JSONObject transaction = transactions.getJSONObject(0);
//                double transferredAmount = transaction.getDouble("amount");
//                System.out.println("Số tiền người dùng chuyển khoản: " + transferredAmount);
//                boolean isValid = transaction.getString("status").equals("SUCCESS")
//                        && transferredAmount == totalAmountDouble;
//
//                /*
//                if (isValid) {
//                    // Lưu đơn hàng nếu cần
//                    // orderService.saveOrder(orderId, totalAmount, "bank");
//                 }
//                 */
//
//                result.put("orderId", orderId);
//                result.put("isValid", isValid);
//                result.put("transferredAmount", transferredAmount);
//            } else {
//                result.put("orderId", orderId);
//                result.put("isValid", false);
//                result.put("transferredAmount", 0);
//            }
//
//            return result.toString();
//        } catch (Exception e) {
//            e.printStackTrace();
//            JSONObject result = new JSONObject();
//            result.put("orderId", orderId);
//            result.put("isValid", false);
//            result.put("transferredAmount", 0);
//            result.put("error", "Lỗi kiểm tra thanh toán");
//            return result.toString();
//        }
//    }
//}


/*
package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
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


import java.util.List;
import java.util.Map;

@Controller
public class ThanhToanController {

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
        if (order.getCreatedAt() == null) {
            order.setCreatedAt(new java.sql.Date(System.currentTimeMillis()));
        }
        
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
    	
    	System.out.println("Address Id được gửi từ ThanhToanController: " + addressId);
    	
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
}
*/

