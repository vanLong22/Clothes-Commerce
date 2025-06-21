package com.example.Shopping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.Shopping.model.Address;
import com.example.Shopping.service.AddressService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AddressController {

	@Autowired
	private AddressService addressService;

	@PostMapping("/themdiachi")
	@ResponseBody
	public int createAddress(@RequestBody Address address) {
		return addressService.addAddress(address);
	}

	@PostMapping("/capnhatdiachimacdinhgiaohang")
	@ResponseBody
	public int setDefaultAddress(@RequestParam("userId") int userId, @RequestParam("addressId") int addressId,
			HttpSession session) {
		session.setAttribute("selectedAddressId", addressId);
		System.out.println("Địa chỉ giao hàng được chọn: " + addressId);

		return addressService.setDefaultAddress(userId, addressId);
	}

	@PostMapping("/xoadiachi")
	@ResponseBody
	public int deleteAddress(@RequestParam("addressId") int addressId) {
		return addressService.deleteAddress(addressId);
	}

	@PostMapping("/capnhatdiachi")
	@ResponseBody
	public int updateAddress(@RequestParam("id") int id, @RequestParam("name") String name,
			@RequestParam("phone") String phone, @RequestParam("addressLine") String addressLine,
			@RequestParam(value = "note", required = false) String note, @RequestParam("isDefault") boolean isDefault, @RequestParam("userId") int userId) {
		Address address = new Address();
		address.setId(id);
		address.setName(name);
		address.setPhone(phone);
		address.setAddressLine(addressLine);
		address.setNote(note);
		address.setUserId(userId);
		
		if(isDefault) {
			address.setIsDefault("true");
		}else {
			address.setIsDefault("false");
		}

		return addressService.updateAddress(address);
	}
}