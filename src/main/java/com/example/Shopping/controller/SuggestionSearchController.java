package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.Shopping.model.Product;
import com.example.Shopping.dao.ProductDAO;

import java.util.List;

/*
@Controller
@RequestMapping("/")
public class SuggestionSearchController {

	@Autowired
	private ProductDAO productDAO;

	// Trang chủ
	@GetMapping("/suggestions")
	public String trangChu(Model model) {
		List<Product> products = productDAO.getAllProducts();
		model.addAttribute("products", products);
		return "trangchu";
	}

	// API gợi ý tìm kiếm
	@GetMapping("/api/products/search")
	@ResponseBody
	public List<Product> searchProducts(@RequestParam("q") String query) {
		return productDAO.findByNameContainingIgnoreCase(query);
	}
}
*/