package com.example.Shopping.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.Shopping.dao.ColorDAO;
import com.example.Shopping.dao.ProductDAO;
import com.example.Shopping.dao.SizeDAO;
import com.example.Shopping.model.Address;
import com.example.Shopping.model.Color;
import com.example.Shopping.model.Order;
import com.example.Shopping.model.OrderDetail;
import com.example.Shopping.model.Product;
import com.example.Shopping.model.Size;
import com.example.Shopping.model.User;
import com.example.Shopping.service.AddressService;
import com.example.Shopping.service.OrderDetailService;
import com.example.Shopping.service.OrderService;
import com.example.Shopping.service.ProductService;
import com.example.Shopping.service.UserService;


@Controller
@RequestMapping("/thongtincanhan")
public class ThongTinCaNhanController {
    
	private final UserService userService;
	private final OrderService orderService;
    private final AddressService addressService;
    private final OrderDetailService orderDetailService;
    
    public ThongTinCaNhanController(UserService userService, OrderService orderService, AddressService addressService,
			OrderDetailService orderDetailService) {
		super();
		this.userService = userService;
		this.orderService = orderService;
		this.addressService = addressService;
		this.orderDetailService = orderDetailService;
	}

    
    @GetMapping({"", "/thongtincanhan"})
    public String showCategoryPage(@RequestParam("userId") int userId, Model model) {
    	System.out.println("Id người dùng là: ++++ " + userId );
    	User user = userService.getUserById(userId);
    	List<Address> address = addressService.getAddressesByUserId(userId);
    	
    	List<Order> orders = orderService.getAllOrdersByUserId(userId);

        List<Integer> orderIds = new ArrayList<>();
        for (Order order : orders) {
            orderIds.add(order.getId());
        }

        List<OrderDetail> orderDetails = orderDetailService.getOrderDetailsByOrderIds(orderIds);
        for (OrderDetail detail : orderDetails) {
            System.out.println("Thông tin chi tiết sản phẩm trong controller");
            System.out.println("Thông tin chi tiết đơn hàng:");
            System.out.println("ID: " + detail.getId());
            System.out.println("Order ID: " + detail.getOrderId());
            System.out.println("Product ID: " + detail.getProductId());
            System.out.println("Product Name: " + detail.getProductName());
            System.out.println("Quantity: " + detail.getQuantity());
            System.out.println("Color: " + detail.getColor());
            System.out.println("Size: " + detail.getSize());
        }

        model.addAttribute("user", user);
        model.addAttribute("address", address);
        model.addAttribute("orders", orders);
        model.addAttribute("orderDetails", orderDetails);

        return "thongtincanhan"; // Trả về tên view JSP
    }
/*    
    @PostMapping("/capnhat")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editUser(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();
        try {
            if (Integer.valueOf(user.getId()) == null) {
                response.put("success", false);
                response.put("message", "ID người dùng không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }
            if (user.getPassword() == null || user.getPassword().isEmpty()) {
                User existingUser = userService.getUserById(user.getId());
                user.setPassword(existingUser.getPassword());
            } else {
                user.setPassword(userService.encodePassword(user.getPassword()));
            }
            userService.updateUser(user);
            response.put("success", true);
            response.put("message", "Cập nhật người dùng thành công!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
*/
     
    
    @PostMapping("/capnhat")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editUser(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();
        try {
        	System.out.println("du lieuj duoc gui toi thongtincanhan Controller");
        	/*
            // Validate input
            if (Integer.valueOf(user.getId()) == null) {
                response.put("success", false);
                response.put("message", "ID người dùng không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Validate email format
            if (!user.getEmail().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                response.put("success", false);
                response.put("message", "Email không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Validate phone format (10-11 số, bắt đầu bằng 0)
            if (!user.getPhone().matches("^0[0-9]{9,10}$")) {
                response.put("success", false);
                response.put("message", "Số điện thoại không hợp lệ");
                return ResponseEntity.badRequest().body(response);
            }
            */
            // Kiểm tra email đã tồn tại chưa (trừ email của user hiện tại)
            int existingUserWithEmail = userService.getUserByEmail(user.getEmail(), user.getId());
            if (existingUserWithEmail > 0) {
                response.put("success", false);
                response.put("message", "Email đã được sử dụng bởi tài khoản khác");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Kiểm tra số điện thoại đã tồn tại chưa (trừ của user hiện tại)
            int existingUserWithPhone = userService.getUserByPhone(user.getPhone(), user.getId());
            if (existingUserWithPhone > 0) {
                response.put("success", false);
                response.put("message", "Số điện thoại đã được sử dụng bởi tài khoản khác");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Lấy thông tin user hiện tại để giữ nguyên password nếu không thay đổi
            User existingUser = userService.getUserById(user.getId());
            user.setPassword(existingUser.getPassword());
            
            // Cập nhật thông tin user
            userService.updateUser(user);
            
            response.put("success", true);
            response.put("message", "Cập nhật thông tin thành công!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật thông tin: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    
}
