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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.Shopping.model.Category;
import com.example.Shopping.service.CategoryService;

@Controller
@RequestMapping("/admin")
public class DanhMucSanPhamAdminController {

    @Autowired
    private CategoryService categoryService;
    
 
    
    @GetMapping("/danhmucsanpham")
    public String hienThiDanhMucSanPham(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "search", required = false) String search,
            Model model) {
        
        // Calculate pagination parameters
        int totalCategories = categoryService.getTotalCategories(search);
        int totalPages = (int) Math.ceil((double) totalCategories / size);
        page = Math.max(1, Math.min(page, totalPages)); // Ensure page is within valid range
        
        // Get paginated and filtered categories
        List<Category> categories = categoryService.getCategoriesPaginated(page, size, search);
        
        // Add attributes to model
        model.addAttribute("categories", categories);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalProducts", categoryService.getProductCountByCategory(0));
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("search", search);
        
        return "admin/danhmucsanpham";
    }
    
    @PostMapping("/capnhatdanhmuc")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> capNhatDanhMuc(@RequestParam("id") int id,
			@RequestParam("categoryName") String categoryName,
			@RequestParam(value = "description", required = false) String description,
			@RequestParam("categoryType") String categoryType) {
    	
    	Map<String, Object> response = new HashMap<>();

		try {
			Category category = new Category();
			category.setId(id);
			category.setName(categoryName);
			
			if (categoryType != null) {
	            if (categoryType.equals("male")) {
	                category.setParentId(100);
	            } else if (categoryType.equals("female")) {
	                category.setParentId(200);
	            } else {
	                response.put("success", false);
	                response.put("message", "Loại danh mục không hợp lệ");
	                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
	            }
	        } else {
	            category.setParentId(100); // Ví dụ: mặc định là Đồ nam
	        }
			
			category.setDescription(description);

			categoryService.updateCategory(category);

			response.put("success", true);
			response.put("message", "Cập nhật danh mục thành công");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Lỗi khi cập nhật danh mục: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
    }
    
    @PostMapping("/xoadanhmuc")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> xoaDanhMuc(@RequestParam("id") int id) {
		Map<String, Object> response = new HashMap<>();

		try {
			categoryService.deleteCategory(id);
			response.put("success", true);
			response.put("message", "Xóa danh mục thành công");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Lỗi khi xóa sản phẩm: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
    
    
}