package com.example.Shopping.model;

import java.sql.Date;

public class Comment {
	private int id;
	private int productId;
	private int userId;
	private String content;
	private Date createAt;
	private String username;
	
	public Comment() {
		// TODO Auto-generated constructor stub
	}

	public Comment(int id, int productId, int userId, String content, Date createAt, String username) {
		super();
		this.id = id;
		this.productId = productId;
		this.userId = userId;
		this.content = content;
		this.createAt = createAt;
		this.username = username;
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

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	
}
