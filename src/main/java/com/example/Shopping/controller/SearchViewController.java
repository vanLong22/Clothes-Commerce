package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Shopping.model.Product;
import com.example.Shopping.service.ProductService;

import java.util.Collections;
import java.util.List;

@Controller
public class SearchViewController {

    @Autowired
    private final ProductService productService;

    public SearchViewController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/timkiem")
    public String showSearchResults(
            @RequestParam(value = "q", required = false) String query,
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        int pageSize = 12; // Số sản phẩm trên mỗi trang

        List<Product> allProducts = (query != null && !query.isEmpty()) 
            ? productService.findByNameContainingIgnoreCase(query) 
            : Collections.emptyList();

        if (allProducts == null || allProducts.isEmpty()) {
            System.out.println("⚠ Không có sản phẩm nào!");
            model.addAttribute("products", Collections.emptyList());
            model.addAttribute("totalPages", 1);
            model.addAttribute("currentPage", 1);
            model.addAttribute("query", query);
            return "timkiem";
        }

        int totalProducts = allProducts.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // Lấy danh sách sản phẩm theo trang
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalProducts);
        List<Product> productsOnPage = allProducts.subList(fromIndex, toIndex);

        model.addAttribute("products", productsOnPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("query", query);

        return "timkiem";
    }
}
