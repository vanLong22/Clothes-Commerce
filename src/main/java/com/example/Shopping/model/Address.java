package com.example.Shopping.model;

public class Address {
	private int id;
	private int userId;
	private String name;
	private String phone;
	private String addressLine;
	private String note;
	private String isDefault;
	
	public Address() {
		// TODO Auto-generated constructor stub
	}

	public Address(int id, int userId, String name, String phone, String addressLine, String note, String isDefault) {
		super();
		this.id = id;
		this.userId = userId;
		this.name = name;
		this.phone = phone;
		this.addressLine = addressLine;
		this.note = note;
		this.isDefault = isDefault;
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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	
}
