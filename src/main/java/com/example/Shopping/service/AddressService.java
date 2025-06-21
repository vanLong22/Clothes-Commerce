package com.example.Shopping.service;

import com.example.Shopping.dao.AddressDAO;
import com.example.Shopping.model.Address;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressService {
    private final AddressDAO addressDAO;

    public AddressService(AddressDAO addressDAO) {
        this.addressDAO = addressDAO;
    }
   
    public List<Address> getAllAddresses() {
        return addressDAO.getAllAddresses();
    }

    public List<Address> getAddressesByUserId(int userId) {
        return addressDAO.getAddressesByUserId(userId);
    }

    public Address getAddressById(int id) {
        return addressDAO.getAddressById(id);
    }

    public int addAddress(Address address) {
        return addressDAO.addAddress(address);
    }

    public int updateAddress(Address address) {
    	return addressDAO.updateAddress(address);
    }

    public int deleteAddress(int id) {
        return addressDAO.deleteAddress(id);
    }
    
    public int setDefaultAddress(int userId, int addressId) {
        return addressDAO.setDefaultAddress(userId, addressId);
    }
}