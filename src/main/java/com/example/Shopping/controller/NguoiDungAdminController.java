package com.example.Shopping.controller;

import com.example.Shopping.model.User;
import com.example.Shopping.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class NguoiDungAdminController {

    @Autowired
    private UserService userService;

    @GetMapping("/nguoidung")
    public String hienThiDanhSachNguoiDung(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "") String search,
            Model model) {
    	
        int totalCustomers = userService.totalUserByRole("customer");
        int totalAdmins = userService.totalUserByRole("admin");
    	
        List<User> users = userService.getUsers(search, page, size);
        int totalUsers = userService.getTotalUsers(search);
        int totalPages = (int) Math.ceil((double) totalUsers / size);
        
        model.addAttribute("totalCustomers", totalCustomers);
        model.addAttribute("totalAdmins", totalAdmins);
        model.addAttribute("users", users);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("size", size);
        model.addAttribute("search", search);

        return "admin/nguoidung";
    }

    @PostMapping("/nguoidung/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addUser(@RequestBody User user) {
        Map<String, Object> response = new HashMap<>();
        try {
            // Kiểm tra dữ liệu đầu vào
            if (user.getUsername() == null || user.getUsername().isEmpty()) {
                response.put("success", false);
                response.put("message", "Tên người dùng không được để trống");
                return ResponseEntity.badRequest().body(response);
            }
            if (user.getEmail() == null || user.getEmail().isEmpty()) {
                response.put("success", false);
                response.put("message", "Email không được để trống");
                return ResponseEntity.badRequest().body(response);
            }
            if (user.getPassword() == null || user.getPassword().isEmpty()) {
                response.put("success", false);
                response.put("message", "Mật khẩu không được để trống");
                return ResponseEntity.badRequest().body(response);
            }

            user.setPassword(userService.encodePassword(user.getPassword()));
            userService.addUser(user);
            response.put("success", true);
            response.put("message", "Thêm người dùng thành công!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi thêm người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PostMapping("/nguoidung/edit")
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

    @PostMapping("/nguoidung/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteUser(@RequestParam int id) {
        Map<String, Object> response = new HashMap<>();
        try {
            userService.deleteUser(id);
            response.put("success", true);
            response.put("message", "Xóa người dùng thành công!");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi xóa người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
