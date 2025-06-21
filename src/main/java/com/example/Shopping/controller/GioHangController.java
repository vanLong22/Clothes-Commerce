package com.example.Shopping.controller;

import com.example.Shopping.model.Cart;
import com.example.Shopping.model.Color;
import com.example.Shopping.model.Size;
import com.example.Shopping.service.CartService;
import com.example.Shopping.service.ColorService;  
import com.example.Shopping.service.SizeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/giohang")
public class GioHangController {

    private final CartService cartService;
    private final ColorService colorService;     
    private final SizeService sizeService;  

    public GioHangController(CartService cartService, ColorService colorService, SizeService sizeService) {
        this.cartService = cartService;
        this.colorService = colorService;
        this.sizeService = sizeService; 
    }

    @GetMapping
    public String showCartPage(@RequestParam(value = "userId", required = false) Integer userId, Model model) {
        List<Cart> carts;
        if (userId != null) {
            carts = cartService.getCartsByUserId(userId);
        } else {
            carts = cartService.getAllCarts();
        }
        model.addAttribute("carts", carts);
        model.addAttribute("userId", userId);
        model.addAttribute("colors", colorService.getAllColors()); 
        model.addAttribute("sizes", sizeService.getAllSizes());   
        return "giohang";
    }
    
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteCart(@PathVariable("id") int id) {
        cartService.deleteCart(id);
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "Xóa sản phẩm thành công!");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/updateAjax")
    public ResponseEntity<Map<String, Object>> updateCartAjax(@RequestBody Map<String, Object> requestData) {
        try {
            String action = (String) requestData.get("action");
            Integer cartId = requestData.get("cartId") != null ? ((Number) requestData.get("cartId")).intValue() : null;
            if (cartId == null) {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("message", "Cart ID không hợp lệ!");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
            }

            Cart existingCart = cartService.getCartById(cartId);
            if (existingCart == null) {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("message", "Không tìm thấy sản phẩm trong giỏ hàng!");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
            }

            if ("remove".equals(action)) {
                cartService.deleteCart(cartId);
                List<Cart> carts = cartService.getCartsByUserId(existingCart.getUserId());
                int totalPrice = carts.stream()
                        .mapToInt(c -> c.getProductPrice() * c.getQuantity())
                        .sum();

                Map<String, Object> response = new HashMap<>();
                response.put("success", true);
                response.put("message", "Xóa sản phẩm khỏi giỏ hàng thành công!");
                response.put("totalPrice", totalPrice);
                return ResponseEntity.ok(response);
            } else if ("update".equals(action)) {
                Integer quantity = requestData.get("quantity") != null ? ((Number) requestData.get("quantity")).intValue() : null;
                Integer colorId = requestData.get("colorId") != null ? ((Number) requestData.get("colorId")).intValue() : null;
                Integer sizeId = requestData.get("sizeId") != null ? ((Number) requestData.get("sizeId")).intValue() : null;

                if (quantity == null || colorId == null || sizeId == null) {
                    Map<String, Object> errorResponse = new HashMap<>();
                    errorResponse.put("success", false);
                    errorResponse.put("message", "Dữ liệu đầu vào không hợp lệ!");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
                }

                existingCart.setQuantity(quantity);
                existingCart.setColorId(colorId);
                existingCart.setSizeId(sizeId);
                cartService.updateCart(existingCart);

                int itemTotal = existingCart.getProductPrice() * existingCart.getQuantity();
                List<Cart> carts = cartService.getCartsByUserId(existingCart.getUserId());
                int totalPrice = carts.stream()
                        .mapToInt(c -> c.getProductPrice() * c.getQuantity())
                        .sum();

                Map<String, Object> response = new HashMap<>();
                response.put("success", true);
                response.put("message", "Cập nhật giỏ hàng thành công!");
                response.put("itemTotal", itemTotal);
                response.put("totalPrice", totalPrice);
                response.put("cart", existingCart);
                return ResponseEntity.ok(response);
            } else {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("message", "Hành động không hợp lệ!");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
            }
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Đã xảy ra lỗi: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @PostMapping("/them")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody Cart cart) {
        try {
            if (cart.getCreateAt() == null) {
                cart.setCreateAt(new java.sql.Date(System.currentTimeMillis()));
            }
            cartService.addCart(cart);

            Map<String, Object> response = new HashMap<>();
            response.put("status", "success");
            response.put("message", "Thêm sản phẩm vào giỏ hàng thành công!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Đã xảy ra lỗi khi thêm sản phẩm vào giỏ hàng!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
}