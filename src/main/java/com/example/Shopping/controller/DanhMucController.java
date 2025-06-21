package com.example.Shopping.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Shopping.dao.ProductDAO;
import com.example.Shopping.model.Product;

@Controller
public class DanhMucController {
    
    private final ProductDAO productDAO;

    public DanhMucController(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @GetMapping("/danhmuc")
    public String showCategoryPage(
            @RequestParam(value = "category", required = false, defaultValue = "1") String category,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "price", required = false, defaultValue = "1000000") double maxPrice,
            @RequestParam(value = "sizes", required = false, defaultValue = "") String sizesStr,
            @RequestParam(value = "colors", required = false, defaultValue = "") String colorsStr,
            Model model) {
        try {
            int pageSize = 3; // Số sản phẩm trên mỗi trang
            List<String> sizes = sizesStr.isEmpty() ? new ArrayList<>() : Arrays.asList(sizesStr.split(","));
            List<String> colors = colorsStr.isEmpty() ? new ArrayList<>() : Arrays.asList(colorsStr.split(","));

            // Lấy danh sách sản phẩm đã lọc
            List<Product> filteredProducts = productDAO.filterProducts(category, maxPrice, sizes, colors);
            System.out.println("Danh sách sản phẩm sau khi lọc:");
            for (Product product : filteredProducts) {
                System.out.println(product.getName());
            }

            int totalProducts = filteredProducts.size();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            // Lấy danh sách sản phẩm theo trang
            int fromIndex = (page - 1) * pageSize;
            int toIndex = Math.min(fromIndex + pageSize, totalProducts);
            List<Product> productsOnPage = (totalProducts > 0) ? filteredProducts.subList(fromIndex, toIndex) : List.of();

            // Thêm dữ liệu vào model
            model.addAttribute("allProducts", productsOnPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("currentPage", page);
            model.addAttribute("category", category);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("sizes", sizesStr);
            model.addAttribute("colors", colorsStr);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Đã xảy ra lỗi khi lọc sản phẩm.");
        }

        return "danhmuc";
    }
}