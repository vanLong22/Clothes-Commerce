package com.example.Shopping.model;

import java.math.BigDecimal;
import java.sql.Date;

public class OrderDetail {
	private int id;
	private int orderId;
	private int productId;
	private String quantity;
	private String color;
	private String size;
	private BigDecimal unitPrice;
	private Date createAt;	
	
	private String productName;
	private String productImage;
	
	
	public OrderDetail() {
		// TODO Auto-generated constructor stub
	}


	public OrderDetail(int id, int orderId, int productId, String quantity, String color, String size,
			BigDecimal unitPrice, Date createAt, String productName, String productImage) {
		super();
		this.id = id;
		this.orderId = orderId;
		this.productId = productId;
		this.quantity = quantity;
		this.color = color;
		this.size = size;
		this.unitPrice = unitPrice;
		this.createAt = createAt;
		this.productName = productName;
		this.productImage = productImage;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getOrderId() {
		return orderId;
	}


	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}


	public int getProductId() {
		return productId;
	}


	public void setProductId(int productId) {
		this.productId = productId;
	}


	public String getQuantity() {
		return quantity;
	}


	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}


	public String getColor() {
		return color;
	}


	public void setColor(String color) {
		this.color = color;
	}


	public String getSize() {
		return size;
	}


	public void setSize(String size) {
		this.size = size;
	}


	public BigDecimal getUnitPrice() {
		return unitPrice;
	}


	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}


	public Date getCreateAt() {
		return createAt;
	}


	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getProductImage() {
		return productImage;
	}


	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}


	
	
	
}
