package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.example.Shopping.dao.ProductDAO;
import com.example.Shopping.model.Product;
import java.util.List;

@Controller
@RestController
@RequestMapping("/search")
public class SearchController {   
   
    @Autowired
    private ProductDAO productDAO;

    @GetMapping("/suggestions")
    public List<Product> getSearchSuggestions(@RequestParam("q") String query) {
    	System.out.println("Dữ liệu nhận được từ client: " + query); 
    	
    	List<Product> products = productDAO.findByNameContainingIgnoreCase(query);

    	for (Product product : products) {
    	    System.out.println("ID: " + product.getId());
    	    System.out.println("Name: " + product.getName());
    	    System.out.println("Price: " + product.getPrice());
    	    System.out.println("Description: " + product.getDescription());
    	    System.out.println("---------------------------");
    	}
    	
    	return products;
    } 
}