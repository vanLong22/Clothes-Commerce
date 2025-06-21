package com.example.Shopping.service;

import com.example.Shopping.dao.UserDAO;
import com.example.Shopping.model.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {
    private final UserDAO userDAO;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public int totalUser() {
        return userDAO.totalUser();
    }

    public int totalUserByRole(String role) {
    	return userDAO.totalUserByRole(role);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    public void addUser(User user) {
        userDAO.addUser(user);
    }

    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }

    public int getUserByEmail(String email, int id) {
        return userDAO.getUserByEmail(email, id);
    }
    
    public int getUserByPhone(String phone, int id) {
    	return userDAO.getUserByPhone(phone, id);
    }
    
    public boolean registerUser(User user) {
        try {
            // Kiểm tra null cho username và email
            if (user.getUsername() == null || user.getEmail() == null) {
                throw new IllegalArgumentException("Username và email không được để trống!");
            }

            // Kiểm tra xem username
            String checkSql = "SELECT COUNT(*) FROM user WHERE username = ? ";
            Integer count = userDAO.getJdbcTemplate().queryForObject(checkSql, Integer.class, user.getUsername());

            if (count != null && count > 0) {
                return false; // Tài khoản đã tồn tại
            }

            // Mã hóa mật khẩu trước khi lưu 
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            // Đặt role mặc định nếu không có
            if (user.getRole() == null) {
                user.setRole("customer");
            }

            userDAO.addUser(user);
            return true;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi đăng ký người dùng: " + e.getMessage());
        }
    }
      
    public User authenticateUser(String username, String password) {
        try {
            // Tìm người dùng theo username
            String sql = "SELECT * FROM user WHERE username = ?";
            User user = userDAO.getJdbcTemplate().query(sql, userDAO.userRowMapper(), username)
                .stream().findFirst().orElse(null);

            // Kiểm tra người dùng tồn tại và mật khẩu khớp
            if (user != null && passwordEncoder.matches(password, user.getPassword())) {
                return user;
            }
            return null;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi xác thực người dùng: " + e.getMessage());
        }
    }
    
    public boolean changePassword(String username, String currentPassword, String newPassword, String confirmPassword) {
    	try {
    		if (username == null || currentPassword == null || newPassword == null || confirmPassword == null) {
                throw new IllegalArgumentException("Tất cả các trường không được để trống!");
            }
    		
    		// tìm người dùng theo username 
    		String sql = "SELECT * FROM user WHERE username = ?";
            User user = userDAO.getJdbcTemplate().query(sql, userDAO.userRowMapper(), username)
                .stream().findFirst().orElse(null);

            if (user == null) {
    			return false; // người dùng không tồn tại
    		}
    		
    		if(!passwordEncoder.matches(currentPassword, user.getPassword())) {
    			return false; // mật khẩu hiên tại không đúng
    		}
    		
    		if (!newPassword.equals(confirmPassword)) {
                return false; // Mật khẩu mới và xác nhận không khớp
            }
    		
    		//mã hóa mật khẩu mới
    		String encodeNewPassword = passwordEncoder.encode(newPassword);
    		user.setPassword(encodeNewPassword);
    		
    		//cập nhật mật khẩu trong csdl
    		userDAO.updateUser(user);
    		return true;
    	}catch (Exception e) {
    		throw new RuntimeException("Lỗi khi đổi mật khẩu: " + e.getMessage());
		}
    }
    
    public List<User> getUsers(String search, int page, int size) {
        int offset = (page - 1) * size;
        return userDAO.getUsers(search, size, offset);
    }

    public int getTotalUsers(String search) {
        return userDAO.getTotalUsers(search);
    }

    public String encodePassword(String password) {
        return passwordEncoder.encode(password);
    }
}