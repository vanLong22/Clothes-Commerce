package com.example.Shopping.dto;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TransactionStatusDTO implements Serializable{

	private String status;
	private String message;
	private String data;
	
	public TransactionStatusDTO() {
		// TODO Auto-generated constructor stub
	}

	public TransactionStatusDTO(String status, String message, String data) {
		super();
		this.status = status;
		this.message = message;
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
	
}
