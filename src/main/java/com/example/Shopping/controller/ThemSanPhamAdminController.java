package com.example.Shopping.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.Shopping.model.Category;
import com.example.Shopping.model.Product;
import com.example.Shopping.service.CategoryService;
import com.example.Shopping.service.ProductService;

import jakarta.servlet.ServletContext;

@Controller
@RequestMapping("/admin")
public class ThemSanPhamAdminController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ServletContext servletContext;

    @GetMapping("/themsanpham")
    public String hienThiTrangThemSanPham(Model model) {
        List<Category> allCategory = categoryService.getAllCategories();
        model.addAttribute("allCategory", allCategory);
        
        return "admin/themsanpham";
    }

    @PostMapping("/themsanpham")
    public ResponseEntity<Map<String, Object>> themSanPham(
            @RequestParam("danh_muc") int categoryId,
            @RequestParam("ten_san_pham") String name,
            @RequestParam("ten_thuong_hieu") String brand,
            @RequestParam("gia_san_pham") double price,
            @RequestParam("so_luong") int quantity,
            @RequestParam("mo_ta") String description,
            @RequestParam("anh_dai_dien") MultipartFile image) {
    	
    	Map<String, Object> response = new HashMap<>();  

        try {
        	System.out.println("Dữ liệu nhận được:");
            System.out.println("Danh mục ID: " + categoryId);
            System.out.println("Tên sản phẩm: " + name);
            System.out.println("Tên thương hiệu: " + brand);
            System.out.println("Giá sản phẩm: " + price);
            System.out.println("Số lượng: " + quantity);
            System.out.println("Mô tả: " + description);
            System.out.println("Tệp ảnh: " + (image != null ? image.getOriginalFilename() : "Không có ảnh"));
            
            // Xử lý file ảnh
            String imagePath = null;
            if (!image.isEmpty()) {
                String fileName = image.getOriginalFilename();
                // Loại bỏ khoảng trắng và ký tự không hợp lệ trong tên file
                fileName = fileName.replaceAll("[^a-zA-Z0-9.-]", "_");
                
                // Lấy đường dẫn thực tế trong runtime
                String uploadDir = servletContext.getRealPath("/assets/img_product/");
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs(); // Tạo thư mục nếu chưa tồn tại
                }
                
                Path path = Paths.get(uploadDir + File.separator + fileName); 
                Files.write(path, image.getBytes());
                imagePath = "/assets/img_product/" + fileName;
            }

            // Tạo đối tượng Product
            Product product = new Product(0, name, description, imagePath, quantity, String.valueOf(price), brand, categoryId);

            // Gọi ProductService để thêm sản phẩm
            productService.addProduct(product);

            response.put("success", true);
			response.put("message", "Thêm sản phẩm thành công");
			return ResponseEntity.ok(response);
        } catch (Exception e) {
        	response.put("success", false);
			response.put("message", "Lỗi khi thêm sản phẩm: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}