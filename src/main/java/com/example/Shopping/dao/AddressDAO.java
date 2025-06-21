package com.example.Shopping.dao;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Address;

@Repository
public class AddressDAO {
    private final JdbcTemplate jdbcTemplate;

    public AddressDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private RowMapper<Address> addressRowMapper() {
        return (rs, rowNum) -> new Address(
            rs.getInt("id"),
            rs.getInt("userId"),
            rs.getString("name"),
            rs.getString("phone"),
            rs.getString("addressLine"),
            rs.getString("note"),
            rs.getString("isDefault")
        );
    }

    public List<Address> getAllAddresses() {
        String sql = "SELECT * FROM address";
        return jdbcTemplate.query(sql, addressRowMapper());
    }

    public List<Address> getAddressesByUserId(int userId) {
        String sql = "SELECT * FROM address WHERE userId = ?";
        return jdbcTemplate.query(sql, addressRowMapper(), userId);
    }

    public Address getAddressById(int id) {
        String sql = "SELECT * FROM address WHERE id = ?";
        System.out.println("Retrieved address with ID: " + id);
        return jdbcTemplate.queryForObject(sql, addressRowMapper(), id);
    }

    public int addAddress(Address address) {
        // Reset all existing addresses for the user to isDefault = 'false'
        String resetSql = "UPDATE address SET isDefault = 'false' WHERE userId = ?";
        int resetResult = jdbcTemplate.update(resetSql, address.getUserId());
        System.out.println("Reset default addresses for userId=" + address.getUserId() + ": " + (resetResult >= 0 ? "✅ Thành công" : "❌ Thất bại"));

        // Insert the new address with isDefault = 'true'
        String sql = "INSERT INTO address (userId, name, phone, addressLine, note, isDefault) VALUES (?, ?, ?, ?, ?, 'true')";
        
        System.out.println("Adding address: userId=" + address.getUserId() +
                ", phone=" + address.getPhone() +
                ", adrressLine=" + address.getAddressLine() +
                ", note=" + address.getNote());
        
        int result = jdbcTemplate.update(sql,
            address.getUserId(),
            address.getName(), 
            address.getPhone(),
            address.getAddressLine(),
            address.getNote()
        );

        if (result > 0) {
            System.out.println("✅ Địa chỉ đã được thêm thành công.");
        } else {
            System.out.println("❌ Thêm địa chỉ thất bại.");
        }

        return result;
    }

    public int updateAddress(Address address) {
    	if(address.getIsDefault() != null) {
            // Câu lệnh 1: Cập nhật tất cả các địa chỉ của userId về false
            String sqlResetDefault = "UPDATE address SET isDefault = false WHERE userId = ?";
            jdbcTemplate.update(sqlResetDefault, address.getUserId());
    	}

        // Câu lệnh 2: Cập nhật địa chỉ được chọn
        String sqlUpdate = "UPDATE address SET name = ?, phone = ?, addressLine = ?, note = ?, isDefault = ? WHERE id = ?";

        int result = jdbcTemplate.update(sqlUpdate,
            address.getName(),
            address.getPhone(),
            address.getAddressLine(),
            address.getNote(),
            address.getIsDefault(),
            address.getId()
        );

        if (result > 0) {
            System.out.println("✅ Địa chỉ đã được cập nhật thành công.");
        } else {
            System.out.println("❌ Cập nhật địa chỉ thất bại.");
        }

        return result;
    }

    public int deleteAddress(int id) {
        String sql = "DELETE FROM address WHERE id = ?";
        int result = jdbcTemplate.update(sql, id);
        
        if (result > 0) {
            System.out.println("✅ Địa chỉ đã được xóa thành công.");
        } else {
            System.out.println("❌ Xóa địa chỉ thất bại.");
        }
        
        return result;
    }
    
    public int setDefaultAddress(int userId, int addressId) {
        // Reset all addresses for the user to isDefault = 'no'
        String resetSql = "UPDATE address SET isDefault = 'false' WHERE userId = ?";
        
        int resetResult = jdbcTemplate.update(resetSql, userId);
        System.out.println("Reset default address for userId=" + userId + ": " + (resetResult >= 0 ? "✅ Thành công" : "❌ Thất bại"));
        
        // Set the selected address as default
        String updateSql = "UPDATE address SET isDefault = 'true' WHERE id = ? AND userId = ?";
        
        int updateResult = jdbcTemplate.update(updateSql, addressId, userId);
        return updateResult;
    }
}