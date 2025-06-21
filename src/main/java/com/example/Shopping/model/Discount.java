package com.example.Shopping.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Discount {
	private int id;
	private String code;
	private BigDecimal discountPercentage;
	private Date expirationDate;
	
	public Discount() {
		// TODO Auto-generated constructor stub
	}

	public Discount(int id, String code, BigDecimal discountPercentage, Date expirationDate) {
		super();
		this.id = id;
		this.code = code;
		this.discountPercentage = discountPercentage;
		this.expirationDate = expirationDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BigDecimal getDiscountPercentage() {
		return discountPercentage;
	}

	public void setDiscountPercentage(BigDecimal discountPercentage) {
		this.discountPercentage = discountPercentage;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	
	
	
}
