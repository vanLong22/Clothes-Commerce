package com.example.Shopping.service;

import com.example.Shopping.dao.DiscountDAO;
import com.example.Shopping.model.Discount;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiscountService {
    private final DiscountDAO discountDAO;

    public DiscountService(DiscountDAO discountDAO) {
        this.discountDAO = discountDAO;
    }

    public List<Discount> getAllDiscounts() {
        return discountDAO.getAllDiscounts();
    }

    public Discount getDiscountById(int id) {
        return discountDAO.getDiscountById(id);
    }

    public int addDiscount(Discount discount) {
        return discountDAO.addDiscount(discount);
    }

    public int updateDiscount(Discount discount) {
        return discountDAO.updateDiscount(discount);
    }

    public int deleteDiscount(int id) {
        return discountDAO.deleteDiscount(id);
    }
}