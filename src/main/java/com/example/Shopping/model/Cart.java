package com.example.Shopping.model;

import java.sql.Date;

public class Cart {
	private int id;	
	private int userId;
	private int productId;
	private int colorId;
	private int sizeId;
	private int variantId;
	private int quantity;
	private Date createAt;
	private String productImage; 
	private String productName;  
	private int productQuantity;
	private int productPrice;
	private String colorName;    
    private String sizeName;
	
	public Cart() {
		// TODO Auto-generated constructor stub
	}

	

	



	public Cart(int id, int userId, int productId, int colorId, int sizeId, int variantId, int quantity, Date createAt,
			String productImage, String productName, int productQuantity, int productPrice, String colorName,
			String sizeName) {
		super();
		this.id = id;
		this.userId = userId;
		this.productId = productId;
		this.colorId = colorId;
		this.sizeId = sizeId;
		this.variantId = variantId;
		this.quantity = quantity;
		this.createAt = createAt;
		this.productImage = productImage;
		this.productName = productName;
		this.productQuantity = productQuantity;
		this.productPrice = productPrice;
		this.colorName = colorName;
		this.sizeName = sizeName;
	}







	public int getId() {
		return id;
	}







	public void setId(int id) {
		this.id = id;
	}







	public int getUserId() {
		return userId;
	}







	public void setUserId(int userId) {
		this.userId = userId;
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







	public int getVariantId() {
		return variantId;
	}







	public void setVariantId(int variantId) {
		this.variantId = variantId;
	}







	public int getQuantity() {
		return quantity;
	}







	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}







	public Date getCreateAt() {
		return createAt;
	}







	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}







	public String getProductImage() {
		return productImage;
	}







	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}







	public String getProductName() {
		return productName;
	}







	public void setProductName(String productName) {
		this.productName = productName;
	}







	public int getProductQuantity() {
		return productQuantity;
	}







	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}







	public int getProductPrice() {
		return productPrice;
	}







	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}







	public String getColorName() {
		return colorName;
	}







	public void setColorName(String colorName) {
		this.colorName = colorName;
	}







	public String getSizeName() {
		return sizeName;
	}







	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

 
	


	
	

}
