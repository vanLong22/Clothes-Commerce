package com.example.Shopping.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.Shopping.dao.ProductDAO;
import com.example.Shopping.model.Product;
 
@Service

public class ProductService {
	private final ProductDAO productDAO;

    public ProductService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    public int totalProduct() {
        return productDAO.totalProduct();
    }
    
    public int totalCategory() {
        return productDAO.totalCategory();
    }
    
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }
    
    public List<Product> getProductById(int id) {
        return productDAO.getProductById(id);
    }

    public int updateQuantity(int productId, int quantity) {
        return productDAO.updateQuantity(productId, quantity);
    }
    
    public void updateProduct(Product product) {
        productDAO.updateProduct(product);
    }

    public void deleteProduct(int id) {
        productDAO.deleteProduct(id);
    }
    
    public List<Product> findByNameContainingIgnoreCase(String query) {
        return productDAO.findByNameContainingIgnoreCase(query);
    }

    public void addProduct(Product product) {
        productDAO.addProduct(product);
    }
 
    public List<Product> getAllProducts(int offset, int limit) {
        return productDAO.getAllProducts(offset, limit);
    }
    
    public List<Product> findByNameContainingIgnoreCase(String query, int offset, int limit) {
        return productDAO.findByNameContainingIgnoreCase(query, offset, limit);
    }
    
    public int countByNameContainingIgnoreCase(String query) {
        return productDAO.countByNameContainingIgnoreCase(query);
    }
    

}
