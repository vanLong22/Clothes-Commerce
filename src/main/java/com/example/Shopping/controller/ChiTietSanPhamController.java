package com.example.Shopping.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Shopping.dao.ColorDAO;
import com.example.Shopping.dao.CommentDAO;
import com.example.Shopping.dao.OrderDetailDAO;
import com.example.Shopping.dao.ProductDAO;
import com.example.Shopping.dao.SizeDAO;
import com.example.Shopping.model.Color;
import com.example.Shopping.model.Comment;
import com.example.Shopping.model.Product;
import com.example.Shopping.model.Size;


@Controller
public class ChiTietSanPhamController {
    
    private final ProductDAO productDAO;
    private final ColorDAO colorDAO;
    private final SizeDAO sizeDAO;
    private final CommentDAO commentDAO;
    private final OrderDetailDAO orderDetailDAO;
    
    
    public ChiTietSanPhamController(ProductDAO productDAO, ColorDAO colorDAO, SizeDAO sizeDAO, CommentDAO commentDAO, OrderDetailDAO orderDetailDAO) {
        this.productDAO = productDAO;
        this.colorDAO = colorDAO;
        this.sizeDAO = sizeDAO;
        this.commentDAO = commentDAO;
        this.orderDetailDAO = orderDetailDAO;
    }

    @GetMapping("/chitietsanpham")
    public String showCategoryPage(@RequestParam("id") String id, Model model) { 
        try {
        	int productId = Integer.parseInt(id);
        	 
        	List<Color> colorByProductId = colorDAO.getColorById(productId);
        	List<Size> sizeByProductId = sizeDAO.getSizeById(productId);
        	List<Product> productByProductId = productDAO.getProductById(productId);
        	List<Comment> commentByProductId = commentDAO.getCommentByProductId(productId);
        	int totalProductIdSold = orderDetailDAO.getAllByProductIdSold(productId);
        	List<Product> allProduct = productDAO.getAllProducts();
        	
        	if (productByProductId == null || productByProductId.isEmpty()) {
                model.addAttribute("error", "Không tìm thấy sản phẩm với ID: " + id);
                return "error"; 
            }
        	
        	System.out.println("số lượng màu sắc là: " + colorByProductId.size());
        	System.out.println("số lượng kích thước là: " + sizeByProductId.size());

            // Thêm dữ liệu vào Model để hiển thị trên JSP
            model.addAttribute("productList", productByProductId);
            model.addAttribute("colorList", colorByProductId);
            model.addAttribute("sizeList", sizeByProductId);
            model.addAttribute("commentList", commentByProductId);
            model.addAttribute("totalProductIdSold", totalProductIdSold);
            model.addAttribute("allProduct", allProduct);
            
        }catch (Exception e) {
			// TODO: handle exception
		}
        return "chitietsanpham"; 
    }
}
