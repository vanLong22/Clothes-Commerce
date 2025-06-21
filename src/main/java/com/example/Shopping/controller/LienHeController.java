package com.example.Shopping.controller;


 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.Shopping.dao.ProductDAO;
import com.example.Shopping.model.Product;

import java.util.List;

@Controller
public class LienHeController {
    
	private final ProductDAO productDAO;

    public LienHeController(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    @GetMapping({"/lienhe"})
    public String showHomePage(Model model) {
        
        return "lienhe";  

    }

}
