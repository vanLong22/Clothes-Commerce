package com.example.Shopping.model;

import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.ZoneId;

public class Order {
	private int id;
	private int userId;
	private int addressId;
	private String totalPrice;
	private String  status;
	private String createdAt;
	private String name;
	private String phone;
	private String addressLine;

	private List<OrderDetail> orderDetails;
	
	public Order() {
		// TODO Auto-generated constructor stub
	}

	
	public Order(int id, int userId, int addressId, String totalPrice, String status, String createdAt, String name,
			String phone, String addressLine) {
		super();
		this.id = id;
		this.userId = userId;
		this.addressId = addressId;
		this.totalPrice = totalPrice;
		this.status = status;
		this.createdAt = createdAt;
		this.name = name;
		this.phone = phone;
		this.addressLine = addressLine;
	}

	public Order(int id, int userId, int addressId, String totalPrice, String status, String createdAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.addressId = addressId;
		this.totalPrice = totalPrice;
		this.status = status;
		this.createdAt = createdAt;
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


	public int getAddressId() {
		return addressId;
	}


	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}


	public String getTotalPrice() {
		return totalPrice;
	}


	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getAddressLine() {
		return addressLine;
	}


	public void setAddressLine(String addressLine) {
		this.addressLine = addressLine;
	}

	

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}


	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}


	public Date getCreatedAtAsDate() throws Exception {
	    if (createdAt != null && !createdAt.isEmpty()) {
	        // Kiểm tra định dạng yyyy-MM-dd
	        if (createdAt.matches("\\d{4}-\\d{2}-\\d{2}")) {
	            LocalDate localDate = LocalDate.parse(createdAt, DateTimeFormatter.ISO_LOCAL_DATE);
	            LocalDateTime localDateTime = localDate.atStartOfDay(); // Thêm thời gian 00:00:00
	            return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
	        }
	        // Kiểm tra định dạng yyyyMMddHHmmss
	        else if (createdAt.matches("\\d{14}")) {
	            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	            return formatter.parse(createdAt);
	        }
	        // Nếu không khớp định dạng nào, ném ngoại lệ hoặc trả về null
	        throw new IllegalArgumentException("Invalid date format: " + createdAt);
	    }
	    return null;
	}
	
}
