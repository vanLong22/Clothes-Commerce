package com.example.Shopping.dto;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentResDTO implements Serializable {

	private String status;
	private String message;
	private String URL;
	
	public PaymentResDTO() {
		// TODO Auto-generated constructor stub
	}
	
	
	public PaymentResDTO(String status, String message, String uRL) {
		super();
		this.status = status;
		this.message = message;
		URL = uRL;
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


	public String getURL() {
		return URL;
	}


	public void setURL(String uRL) {
		URL = uRL;
	}
	
	
}
