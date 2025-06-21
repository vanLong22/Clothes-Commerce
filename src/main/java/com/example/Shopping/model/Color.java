package com.example.Shopping.model;

public class Color {
	private int id;
	private int productId;
	private String name;
	
	public Color() {
		// TODO Auto-generated constructor stub
	}

	public Color(int id, int productId, String name) {
		super();
		this.id = id;
		this.productId = productId;
		this.name = name;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	
}
