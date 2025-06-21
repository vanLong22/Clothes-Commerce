package com.example.Shopping.service;

import com.example.Shopping.dao.CartDAO;
import com.example.Shopping.model.Cart;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {
    private final CartDAO cartDAO;

    public CartService(CartDAO cartDAO) {
        this.cartDAO = cartDAO;
    }

    public List<Cart> getAllCarts() {
        return cartDAO.getAllCarts();
    }

    public List<Cart> getCartsByUserId(int userId) { 
        return cartDAO.getCartsByUserId(userId);
    }

    public Cart getCartById(int id) {
        return cartDAO.getCartById(id);
    }

    public void addCart(Cart cart) {
        cartDAO.addCart(cart);
    }

    public void updateCart(Cart cart) {
        cartDAO.updateCart(cart);
    }

    public void deleteCart(int id) {
        cartDAO.deleteCart(id);
    }
}