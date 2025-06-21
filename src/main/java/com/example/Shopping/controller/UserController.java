package com.example.Shopping.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.Shopping.model.User;
import com.example.Shopping.service.UserService;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpSession;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.SecretKey;

@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;   
    }

    // Các phương thức hiện có...
    @GetMapping
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    
    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable(required = false) Integer id) {
        if (id == null) {
            return ResponseEntity.badRequest().body("User ID không được để trống.");
        }
        return ResponseEntity.ok(userService.getUserById(id));
    }


    @PostMapping
    public String addUser(@RequestBody User user) {
        userService.addUser(user);
        return "User added successfully!";
    }

    @PutMapping("/{id}")
    public String updateUser(@PathVariable int id, @RequestBody User user) {
        user.setId(id);
        userService.updateUser(user);
        return "User updated successfully!";
    }

    @DeleteMapping("/{id}")
    public String deleteUser(@PathVariable int id) {
        userService.deleteUser(id);
        return "User deleted successfully!";
    }
    
    @GetMapping("/test")
    public String test() {
        return "Server is running!";
    }

    // Endpoint cho đăng ký
    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        try {
            boolean registered = userService.registerUser(user);
            if (registered) {
                return ResponseEntity.ok("{\"status\": \"success\", \"message\": \"Đăng ký thành công!\"}");
            } else {
                return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body("{\"status\": \"error\", \"message\": \"Username hoặc email đã tồn tại!\"}");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("{\"status\": \"error\", \"message\": \"Đã xảy ra lỗi khi đăng ký!\"}");
        }
    }
    
    
//    @PostMapping("/login")
//    public ResponseEntity<String> loginUser(@RequestBody User user, HttpSession session, HttpServletResponse response) {
//        try {
//            User authenticatedUser = userService.authenticateUser(user.getUsername(), user.getPassword());
//            if (authenticatedUser != null) {
//            	session.setAttribute("userId", authenticatedUser.getId());
//            	
//                // Tạo cookie lưu userId
//                Cookie userIdCookie = new Cookie("userId", String.valueOf(authenticatedUser.getId()));
//                userIdCookie.setMaxAge(30 * 24 * 60 * 60); // Thời hạn 30 ngày (tính bằng giây)
//                userIdCookie.setPath("/"); // Cookie khả dụng trên toàn bộ ứng dụng
//                response.addCookie(userIdCookie); // Thêm cookie vào phản hồi
//
//                System.out.println("ID người dùng là: " + authenticatedUser.getId());
//
//                return ResponseEntity.ok(
//                    "{\"status\": \"success\", \"message\": \"Đăng nhập thành công!\", " +
//                    "\"role\": \"" + authenticatedUser.getRole() + "\", " +
//                    "\"userId\": " + authenticatedUser.getId() + ", " +
//                    "\"username\": \"" + authenticatedUser.getUsername() + "\"}"
//                );
//            } else {
//                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
//                    .body("{\"status\": \"error\", \"message\": \"Tên đăng nhập hoặc mật khẩu không đúng!\"}");
//            }
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//                .body("{\"status\": \"error\", \"message\": \"Đã xảy ra lỗi khi đăng nhập!\"}");
//        }
//    }
    
//    @PostMapping("/verify-jwt")
//    public ResponseEntity<String> verifyJwt(@RequestBody Map<String, String> request, HttpSession session) {
//        try {
//            String jwt = request.get("jwt");
//            Claims claims = Jwts.parser()
//                .setSigningKey("yourSecretKey")
//                .build() // Thêm build() để tạo JwtParser
//                .parseClaimsJws(jwt)
//                .getBody();
//            int userId = Integer.parseInt(claims.getSubject());
//            String username = claims.get("username", String.class);
//            String role = claims.get("role", String.class);
//
//            // Tạo lại session
//            session.setAttribute("userId", userId);
//            session.setMaxInactiveInterval(30 * 24 * 60 * 60);
//
//            return ResponseEntity.ok(
//                "{\"status\": \"success\", \"userId\": " + userId + ", " +
//                "\"username\": \"" + username + "\", " +
//                "\"role\": \"" + role + "\"}"
//            );
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
//                .body("{\"status\": \"error\", \"message\": \"Invalid or expired JWT\"}");
//        }
//    }
    
    @GetMapping("/logout")
    public ResponseEntity<String> logout(HttpSession session) {
    	session.removeAttribute("userId");
        session.invalidate();

        return ResponseEntity.ok("{\"status\": \"success\", \"message\": \"Đã đăng xuất thành công!\"}");
    }

    
    @PostMapping("/changePassword")
    public ResponseEntity<String> changePassword(@RequestBody Map<String, String> request){
    	try {
    		String username = request.get("username");
            String currentPassword = request.get("passwordNow");
            String newPassword = request.get("passwordNew");
            String confirmPassword = request.get("confirmPassword");

            boolean changed = userService.changePassword(username, currentPassword, newPassword, confirmPassword);
            if (changed) {
                return ResponseEntity.ok("{\"status\": \"success\", \"message\": \"Đổi mật khẩu thành công!\"}");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("{\"status\": \"error\", \"message\": \"Mật khẩu hiện tại không đúng, mật khẩu mới không khớp hoặc không hợp lệ!\"}");
            }
    		
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("{\"status\": \"error\", \"message\": \"Đã xảy ra lỗi khi đổi mật khẩu!\"}");
        }
    }
    
    // Secret key để ký JWT (Nên lưu trong file cấu hình hoặc biến môi trường)
    private static final String SECRET_KEY = "8f7e6d5c4b3a2f1e0d9c8b7a6f5e4d3c2b1a0f9e8d7c6b5a4f3e2d1c0b9a8f7";


    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> loginUser(@RequestBody User user, HttpSession session) {
        try {
        	System.out.println("Ngườu dug đã gửi yêu cầu tới" + user.getUsername() + user.getPassword());
            // Xác thực người dùng
            User authenticatedUser = userService.authenticateUser(user.getUsername(), user.getPassword());
            if (authenticatedUser != null) {
                session.setAttribute("userId", authenticatedUser.getId());

                // Tạo JWT
                String token = generateJwtToken(String.valueOf(authenticatedUser.getId()), authenticatedUser.getRole());
                System.out.println("Token được tạo là: " + token);	
                
                // Tạo phản hồi JSON
                Map<String, Object> response = new HashMap<>();
                response.put("status", "success");
                response.put("message", "Đăng nhập thành công!");   
                response.put("role", authenticatedUser.getRole());
                response.put("userId", authenticatedUser.getId());
                response.put("username", authenticatedUser.getUsername());
                response.put("token", token); // Thêm token vào phản hồi

                System.out.println("ID người dùng là: " + authenticatedUser.getId());

                return ResponseEntity.ok(response);
            } else {
                Map<String, Object> errorResponse = new HashMap<>();   
                errorResponse.put("status", "error");
                errorResponse.put("message", "Tên đăng nhập hoặc mật khẩu không đúng!");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
            }
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Đã xảy ra lỗi khi đăng nhập!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // Hàm tạo JWT
    private String generateJwtToken(String userId, String role) {
        // Chuyển SECRET_KEY thành SecretKey
        SecretKey key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
        
        return Jwts.builder()
                .setSubject(userId)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 30 * 24 * 60 * 60 * 1000L)) // Hết hạn sau 30 ngày
                .signWith(key) // Sử dụng SecretKey thay vì SignatureAlgorithm   
                .compact();
    }
    
    @PostMapping("/verifyToken")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> verifyToken(@RequestBody Map<String, String> request) {
        String token = request.get("token");
        try {
            Claims claims = Jwts.parserBuilder()
                .setSigningKey(Keys.hmacShaKeyFor(SECRET_KEY.getBytes()))
                .build()
                .parseClaimsJws(token)
                .getBody();
            
            int userId = Integer.parseInt(claims.getSubject());
            User user = userService.getUserById(userId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("status", "success");
            response.put("userId", user.getId());
            response.put("username", user.getUsername());
            response.put("role", user.getRole());
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Token không hợp lệ hoặc đã hết hạn");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        }
    }
}