package com.example.Shopping.model;

import java.math.BigDecimal;

public class ProductVariant {
	private int id;
	private int productId;
	private int colorId;
	private int sizeId;
	private BigDecimal price;
	private int stockQuantity;

	public ProductVariant() {
		// TODO Auto-generated constructor stub
	}

	public ProductVariant(int id, int productId, int colorId, int sizeId, BigDecimal price, int stockQuantity) {
		super();
		this.id = id;
		this.productId = productId;
		this.colorId = colorId;
		this.sizeId = sizeId;
		this.price = price;
		this.stockQuantity = stockQuantity;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getColorId() {
		return colorId;
	}

	public void setColorId(int colorId) {
		this.colorId = colorId;
	}

	public int getSizeId() {
		return sizeId;
	}

	public void setSizeId(int sizeId) {
		this.sizeId = sizeId;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public int getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
	
	
}
