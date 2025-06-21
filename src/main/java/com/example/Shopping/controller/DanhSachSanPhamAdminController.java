package com.example.Shopping.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.Shopping.model.Category;
import com.example.Shopping.model.Product;
import com.example.Shopping.service.CategoryService;
import com.example.Shopping.service.ProductService;

import jakarta.servlet.ServletContext;

@Controller
@RequestMapping("/admin")
public class DanhSachSanPhamAdminController {

	@Autowired
	private ProductService productService;

	@Autowired
	private CategoryService categoryService;
	
	@Autowired
    private ServletContext servletContext;

	@GetMapping("/danhsachsanpham")
	public String hienThiDanhSachSanPham(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size, @RequestParam(defaultValue = "") String search, Model model) {
		// tổng sản phẩm
		int totalProduct = productService.totalProduct();
		model.addAttribute("totalProduct", totalProduct);

		// tổng danh mục
		int totalCategory = productService.totalCategory();
		model.addAttribute("totalCategory", totalCategory);

		// lấy danh sách toàn bộ danh mục sản phẩm
		List<Category> categories = categoryService.getAllCategories();
		model.addAttribute("categories", categories);

		// Phân trang
		int offset = (page - 1) * size;
		List<Product> products;
		int totalProducts;

		if (!search.isEmpty()) {
			products = productService.findByNameContainingIgnoreCase(search, offset, size);
			totalProducts = productService.countByNameContainingIgnoreCase(search);
		} else {
			products = productService.getAllProducts(offset, size);
			totalProducts = productService.totalProduct();
		}

		int totalPages = (int) Math.ceil((double) totalProducts / size);

		model.addAttribute("products", products);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("totalItems", totalProducts);
		model.addAttribute("pageSize", size);
		model.addAttribute("search", search);

		return "admin/danhsachsanpham";
	}

	@PostMapping("/capnhatsanpham")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> capNhatSanPham(@RequestParam("id") int id,
			@RequestParam("name") String name,
			@RequestParam(value = "description", required = false) String description,
			@RequestParam("price") String price, @RequestParam("quantity") int quantity,
			@RequestParam(value = "brand", required = false) String brand, @RequestParam("categoryId") int categoryId,
			@RequestParam(value = "currentImage", required = false) String currentImage,
			@RequestParam(value = "image", required = false) MultipartFile imageFile) {

		Map<String, Object> response = new HashMap<>();   

		try {
			Product product = new Product();
			product.setId(id);
			product.setName(name);
			product.setDescription(description);

			// Xử lý giá (loại bỏ dấu phẩy, dấu chấm nếu có)
			String cleanPrice = price.replaceAll("[^0-9]", "");
			product.setPrice(cleanPrice);

			product.setQuantity(quantity);
			product.setBrand(brand);
			product.setCategoryId(categoryId);

			// Xử lý file ảnh
			String imagePath = null;
			if (!imageFile.isEmpty()) {
				String fileName = imageFile.getOriginalFilename();
				// Loại bỏ khoảng trắng và ký tự không hợp lệ trong tên file
				fileName = fileName.replaceAll("[^a-zA-Z0-9.-]", "_");

				// Lấy đường dẫn thực tế trong runtime
				String uploadDir = servletContext.getRealPath("/assets/img_product/");
				File uploadDirFile = new File(uploadDir);
				if (!uploadDirFile.exists()) {
					uploadDirFile.mkdirs(); // Tạo thư mục nếu chưa tồn tại
				}

				Path path = Paths.get(uploadDir + File.separator + fileName);
				Files.write(path, imageFile.getBytes());
				imagePath = "/assets/img_product/" + fileName;
				
				product.setImage(imagePath);
			}

			productService.updateProduct(product);

			response.put("success", true);
			response.put("message", "Cập nhật sản phẩm thành công");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@PostMapping("/xoasanpham")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> xoaSanPham(@RequestParam("id") int id) {
		Map<String, Object> response = new HashMap<>();

		try {
			productService.deleteProduct(id);
			response.put("success", true);
			response.put("message", "Xóa sản phẩm thành công");
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Lỗi khi xóa sản phẩm: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
	/*
	 * private String saveImage(MultipartFile imageFile) throws IOException { //
	 * Thực hiện lưu file ảnh vào thư mục trên server // Trả về đường dẫn tương đối
	 * String uploadDir = "uploads/products/"; String fileName =
	 * System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
	 * 
	 * Path uploadPath = Paths.get(uploadDir); if (!Files.exists(uploadPath)) {
	 * Files.createDirectories(uploadPath); }
	 * 
	 * try (InputStream inputStream = imageFile.getInputStream()) { Path filePath =
	 * uploadPath.resolve(fileName); Files.copy(inputStream, filePath,
	 * StandardCopyOption.REPLACE_EXISTING); }
	 * 
	 * return "/" + uploadDir + fileName; }
	 */
}