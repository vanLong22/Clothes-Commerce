package com.example.Shopping.model;

import java.util.Date;


public class Payment {
	private int id;
	private int userId;
	private int orderId;
	private int discountId;
	private String method;
	private String transactionNo;
	private String status;
	private Date createAt;
	private int totalPrice;
	
	public Payment() {
		// TODO Auto-generated constructor stub
	}

	public Payment(int id, int userId, int orderId, int discountId, String method, String transactionNo, String status, Date createAt, int totalPrice) {
		super();
		this.id = id;
		this.userId = userId;
		this.orderId = orderId;
		this.discountId = discountId;
		this.method = method;
		this.transactionNo = transactionNo;
		this.status = status;
		this.createAt = createAt;
		this.totalPrice = totalPrice;
	}
	
	public Payment(int id, int userId, int orderId, int discountId, String method, String transactionNo, String status, Date createAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.orderId = orderId;
		this.discountId = discountId;
		this.method = method;
		this.transactionNo = transactionNo;
		this.status = status;
		this.createAt = createAt;
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

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getDiscountId() {
		return discountId;
	}

	public void setDiscountId(int discountId) {
		this.discountId = discountId;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getTransactionNo() {
		return transactionNo;
	}

	public void setTransactionNo(String transactionNo) {
		this.transactionNo = transactionNo;
	}
	
	
	
}
