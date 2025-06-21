//package com.example.Shopping.controller;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import com.example.Shopping.model.Product;
//import com.example.Shopping.service.ProductService;
//
//import java.util.Collections;
//import java.util.List;
//
//@Controller
//public class TrangChuController {
//
//    private final ProductService productService;
//
//    // Inject ProductService thay vì ProductDAO
//    public TrangChuController(ProductService productService) {
//        this.productService = productService;
//    }
//
//    @GetMapping({"/", "/trangchu"})
//    public String showHomePage(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
//        try {
//            // Sử dụng service thay vì DAO trực tiếp
//            List<Product> allProducts = productService.getAllProducts();
//            int pageSize = 5; // Số sản phẩm trên mỗi trang
//
//            if (allProducts == null || allProducts.isEmpty()) {
//                System.out.println("⚠ Không có sản phẩm nào!");
//                model.addAttribute("allProducts", Collections.emptyList());
//                model.addAttribute("totalPages", 1);
//                model.addAttribute("currentPage", 1);
//                return "trangchu";
//            }
//
//            int totalProducts = (allProducts != null) ? allProducts.size() : 0;
//            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
//
//            // Lấy danh sách sản phẩm theo trang
//            int fromIndex = (page - 1) * pageSize;
//            int toIndex = Math.min(fromIndex + pageSize, totalProducts);
//            List<Product> productsOnPage = allProducts.subList(fromIndex, toIndex);
//
//            model.addAttribute("allProducts", productsOnPage);
//            model.addAttribute("totalPages", totalPages);
//            model.addAttribute("currentPage", page);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return "trangchu";
//    }
//}

package com.example.Shopping.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Shopping.model.Product;
import com.example.Shopping.service.ProductService;

import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;


import java.util.List;


@Controller
public class TrangChuController {

    private final ProductService productService;

    // Inject ProductService thay vì ProductDAO
    public TrangChuController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping({"/", "/trangchu"})
    public String showHomePage(@RequestParam(value = "page", defaultValue = "1") int page, 
                               Model model, HttpServletRequest request) {
        try {
            String token = request.getHeader("Authorization");
            if (token != null && token.startsWith("Bearer ")) {
            	try {
                    Claims claims = validateJwtToken(token);
                    String userId = claims.getSubject();
                    model.addAttribute("userId", userId);
                } catch (RuntimeException e) {
                    model.addAttribute("tokenError", "Không thể xác thực token: " + e.getMessage());
                    System.out.println("Lỗi token..............");
                }
            }

            // Logic hiện tại của TrangChuController
            List<Product> allProducts = productService.getAllProducts();
            int pageSize = 5;
            int totalProducts = allProducts.size();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);  

            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalProducts);
            List<Product> productsOnPage = allProducts.subList(fromIndex, toIndex);  
  
            model.addAttribute("allProducts", productsOnPage);
            model.addAttribute("totalPages", totalPages);   
            model.addAttribute("currentPage", page);

        } catch (Exception e) {   
            e.printStackTrace();
        }
        return "trangchu";
    }
    
    
    private static final String SECRET_KEY = "8f7e6d5c4b3a2f1e0d9c8b7a6f5e4d3c2b1a0f9e8d7c6b5a4f3e2d1c0b9a8f7"; 

    private Claims validateJwtToken(String token) {
        try {
            if (token == null || !token.startsWith("Bearer ")) {
                throw new IllegalArgumentException("Token không hợp lệ: Thiếu hoặc sai định dạng Bearer");
            }
            SecretKey key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes("UTF-8"));
            return Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token.replace("Bearer ", "").trim()) // Xóa khoảng trắng thừa
                    .getBody();
        } catch (Exception e) {
            throw new RuntimeException("Token không hợp lệ: " + e.getMessage());
        }
    }
}