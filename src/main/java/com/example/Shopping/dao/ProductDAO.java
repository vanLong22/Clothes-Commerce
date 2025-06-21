package com.example.Shopping.dao;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.Shopping.model.Product;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductDAO {
	private final JdbcTemplate jdbcTemplate;

	public ProductDAO(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	// Ánh xạ dữ liệu từ ResultSet vào Product object
	private RowMapper<Product> productRowMapper() {
		return (rs, rowNum) -> new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
				rs.getInt(5), rs.getString(6), rs.getString(7), rs.getInt(8));
	}
 
	//tính tổng số sản phẩm
    public int totalProduct() {
        String sql = "SELECT COUNT(*) FROM product";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
    // tính tổng số danh mục sản phẩm
    public int totalCategory() {
    	String sql = "SELECT COUNT(DISTINCT categoryId) AS category_count FROM product";
    	
    	return jdbcTemplate.queryForObject(sql, Integer.class);
    }
    
	// Lấy tất cả sản phẩm
	public List<Product> getAllProducts() { 
		String sql = "SELECT * FROM product";
		List<Product> products = jdbcTemplate.query(sql, productRowMapper());
		System.out.println("Số lượng sản phẩm truy vấn được: " + products.size());
		return products; 
	} 

	// Lấy sản phẩm theo ID
	public List<Product> getProductById(int id) {
		String sql = "SELECT * FROM product WHERE id = ?";
		System.out.println("Id sản phẩm là: " + id);
		return jdbcTemplate.query(sql, productRowMapper(), id);
	}
	/*
	public Map<Integer, Product> getAllProducts() {
        String sql = "SELECT id, name, price, image, quantity FROM product";
        List<Product> products = jdbcTemplate.query(sql, productRowMapper());
        Map<Integer, Product> productMap = new HashMap<>();
        for (Product product : products) {
            productMap.put(product.getId(), product);
        }
        return productMap;
    }

    public Product getProductById(int productId) {
        return getAllProducts().get(productId);
    }
    */

	// Lấy sản phẩm theo CategoryId
	public List<Product> getProductByCategoryId(int categoryId) {
		String sql = "SELECT * FROM product WHERE categoryId = ?";
		return jdbcTemplate.query(sql, productRowMapper(), categoryId);
	}

	// Tìm kiếm sản phẩm theo tên (không phân biệt hoa thường)
	public List<Product> findByNameContainingIgnoreCase(String query) {
	    String sql = "SELECT * FROM product WHERE name LIKE ?";
	    String searchTerm = "%" + query + "%"; 
	    
	    List<Product> products = jdbcTemplate.query(sql, productRowMapper(), searchTerm);

	    System.out.println("Dữ liệu từ DAO: " + query);
    	for (Product product : products) {
    	    System.out.println("ID: " + product.getId());
    	    System.out.println("Name: " + product.getName());
    	    System.out.println("Price: " + product.getPrice());
    	    System.out.println("Description: " + product.getDescription());
    	    System.out.println("---------------------------");
    	}
    	
    	return products;
	}


	public int updateQuantity(int productId, int quantity) {
        String sql = "UPDATE product SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        return jdbcTemplate.update(sql, quantity, productId, quantity);
    }
	
	public void updateProduct(Product product) {
        String sql = "UPDATE product SET name = ?, description = ?, image = ?, quantity = ?, price = ?, brand = ?, categoryId = ? WHERE id = ?";
        jdbcTemplate.update(sql, 
            product.getName(),
            product.getDescription(),
            product.getImage(),
            product.getQuantity(),
            product.getPrice(),
            product.getBrand(),
            product.getCategoryId(),
            product.getId());
    }
	
	public void deleteProduct(int id) {
        String sql = "DELETE FROM product WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
	
	// lấy sản phẩm theo những tiêu chí khác nhau 
    public List<Product> filterProducts(String categoryId, double maxPrice, List<String> sizes, List<String> colors) {
        String sql = "SELECT DISTINCT p.* " +
                     "FROM product p " +
                     "LEFT JOIN size s ON p.id = s.productId " +
                     "LEFT JOIN color c ON p.id = c.productId " +
                     "WHERE 1=1 ";
        List<Object> params = new ArrayList<>();

        
        // Lọc theo categoryId
        if (categoryId != null && !categoryId.isEmpty()) {
            sql += "AND p.categoryId = ? ";
            params.add(categoryId);
        }
		
        // Lọc theo giá (giả sử minPrice là 0)
        sql += "AND CAST(p.price AS DECIMAL) >= ? ";
        params.add(maxPrice);

        // Lọc theo danh sách kích cỡ
        if (sizes != null && !sizes.isEmpty()) {
            sql += "AND s.name IN (" + String.join(",", sizes.stream().map(s -> "?").toList()) + ") ";
            params.addAll(sizes);
        }

        // Lọc theo danh sách màu sắc
        if (colors != null && !colors.isEmpty()) {
            sql += "AND c.name IN (" + String.join(",", colors.stream().map(c -> "?").toList()) + ") ";
            params.addAll(colors);
        }

        return jdbcTemplate.query(sql, productRowMapper(), params.toArray());
    }

    // thêm sản phẩm
    public void addProduct(Product product) {
        String sql = "INSERT INTO product (name, description, image, quantity, price, brand, categoryId) VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, 
            product.getName(), 
            product.getDescription(), 
            product.getImage(), 
            product.getQuantity(), 
            product.getPrice(), 
            product.getBrand(), 
            product.getCategoryId()
        );
    }
    
    // Lấy tất cả sản phẩm với phân trang
    public List<Product> getAllProducts(int offset, int limit) {
        String sql = "SELECT * FROM product ORDER BY id LIMIT ? OFFSET ?";
        List<Product> products = jdbcTemplate.query(sql, productRowMapper(), limit, offset);
        System.out.println("Số lượng sản phẩm truy vấn được (phân trang): " + products.size());
        return products;
    }

    // Tìm kiếm sản phẩm theo tên với phân trang
    public List<Product> findByNameContainingIgnoreCase(String query, int offset, int limit) {
    	String sql;
        List<Object> params = new ArrayList<>();
        
        // Kiểm tra xem query có phải là số (id) hay không
        try {
            int id = Integer.parseInt(query);
            // Tìm kiếm theo id
            sql = "SELECT * FROM product WHERE id = ? ORDER BY id LIMIT ? OFFSET ?";
            params.add(id);
            params.add(limit);
            params.add(offset);
        } catch (NumberFormatException e) {
            // Tìm kiếm theo tên nếu query không phải là số
            sql = "SELECT * FROM product WHERE name LIKE ? ORDER BY id LIMIT ? OFFSET ?";
            String searchTerm = "%" + query + "%";
            params.add(searchTerm);
            params.add(limit);
            params.add(offset);
        }

        List<Product> products = jdbcTemplate.query(sql, productRowMapper(), params.toArray());
        
        System.out.println("Dữ liệu từ DAO (phân trang): " + query);
        for (Product product : products) {
            System.out.println("ID: " + product.getId()); 
            System.out.println("Name: " + product.getName());
            System.out.println("Price: " + product.getPrice());
            System.out.println("Description: " + product.getDescription());
            System.out.println("---------------------------");
        }
        
        return products;

    }

    // Đếm số sản phẩm phù hợp với từ khóa tìm kiếm
    public int countByNameContainingIgnoreCase(String query) {
        String sql = "SELECT COUNT(*) FROM product WHERE name LIKE ?";
        String searchTerm = "%" + query + "%";
        
        return jdbcTemplate.queryForObject(sql, Integer.class, searchTerm);
    }
    

    
    
} 