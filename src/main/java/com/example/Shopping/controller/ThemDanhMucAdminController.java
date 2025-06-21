package com.example.Shopping.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.Shopping.model.Category;
import com.example.Shopping.service.CategoryService;


@Controller
@RequestMapping("/admin")
public class ThemDanhMucAdminController {

    @Autowired
    private CategoryService categoryService;


    @GetMapping("/themdanhmuc")
    public String hienThiTrangThemSanPham(Model model) {
        List<Category> allCategory = categoryService.getAllCategories();
        model.addAttribute("allCategory", allCategory);
        
        return "admin/themdanhmuc";
    }
    
    @PostMapping("/themdanhmuc")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> themDanhMuc(@RequestBody Category category) {
    	Map<String, Object> response = new HashMap<>();  

        try {        	
            categoryService.addCategory(category);
            
            response.put("success", true);
			response.put("message", "Thêm danh mục thành công");
			return ResponseEntity.ok(response);
        } catch (Exception e) {
        	response.put("success", false);
			response.put("message", "Lỗi khi thêm danh mục: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    /*
    @PostMapping("/themdanhmuc")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> themDanhMuc(
            @RequestParam("tenDanhMuc") String tenDanhMuc,
            @RequestParam("chonDanhMuc") String chonDanhMuc,
            @RequestParam("nhapDanhMuc") String moTa,
            @RequestParam("chonHinhAnh") MultipartFile hinhAnh,
            Model model) {
    	
    	Map<String, Object> response = new HashMap<>();
    	
        try {
            Category category = new Category();
            category.setName(tenDanhMuc);
            if(chonDanhMuc.equals("Đồ nam")) {
            	category.setParentId(100);
            }else {
            	category.setParentId(200);
            }
            category.setDescription(moTa);

            categoryService.addCategory(category);

            response.put("success", true);
			response.put("message", "Thêm danh mục thành công");
			return ResponseEntity.ok(response);
        }catch (Exception e) {
			response.put("success", false);
			response.put("message", "Lỗi khi thêm danh mục: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
    }
    */
    
}