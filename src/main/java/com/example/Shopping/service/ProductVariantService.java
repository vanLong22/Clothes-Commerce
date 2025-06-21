package com.example.Shopping.service;

import com.example.Shopping.dao.ProductVariantDAO;
import com.example.Shopping.model.ProductVariant;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductVariantService {
    private final ProductVariantDAO productVariantDAO;

    public ProductVariantService(ProductVariantDAO productVariantDAO) {
        this.productVariantDAO = productVariantDAO;
    }

    public List<ProductVariant> getAllProductVariants() {
        return productVariantDAO.getAllProductVariants();
    }

    public ProductVariant getProductVariantById(int id) {
        return productVariantDAO.getProductVariantById(id);
    }

    public boolean addProductVariant(ProductVariant productVariant) {
        return productVariantDAO.addProductVariant(productVariant) > 0;
    }

    public boolean updateProductVariant(ProductVariant productVariant) {
        return productVariantDAO.updateProductVariant(productVariant) > 0;
    }

    public boolean deleteProductVariant(int id) {
        return productVariantDAO.deleteProductVariant(id) > 0;
    }
}
