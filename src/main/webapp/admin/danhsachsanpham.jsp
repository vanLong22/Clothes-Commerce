<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fashion Shop - Quản lý Sản phẩm</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    :root {
        --primary: #5c6bc0;
        --primary-dark: #3f51b5;
        --primary-light: #7986cb;
        --secondary: #ff6f61;
        --success: #4caf50;
        --warning: #ff9800;
        --danger: #f44336;
        --light: #f8f9fa;
        --dark: #212529;
        --gray: #6c757d;
        --light-gray: #e9ecef;
        --border: #dee2e6;
        --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        --hover-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        --transition: all 0.3s ease;
    }

    body {
        background-color: #f5f7fa;
        color: var(--dark);
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        overflow-x: hidden;
    }

    .container {
        display: flex;
        flex-direction: column;
    }
        

    /* Layout Structure */
    .layout {
        display: grid;
        grid-template-columns: 250px 1fr;
        gap: 40px; /* Increased gap for more spacing between sidebar and main content */
        width: 100%;
        flex: 1;
    }

    /* Main Content Styles */
    .main-content {
        display: flex;
        flex-direction: column;
        gap: 25px;
    }

    /* Search Container */
    .search-container {
        background: white;
        border-radius: 12px;
        padding: 25px;
        box-shadow: var(--card-shadow);
    }

    .search-container form {
        display: flex;
        gap: 15px;
    }

    .search-container input {
        flex: 1;
        padding: 14px 20px;
        border: 2px solid var(--light-gray);
        border-radius: 8px;
        font-size: 1rem;
        transition: var(--transition);
    }

    .search-container input:focus {
        border-color: var(--secondary);
        outline: none;
        box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.2);
    }

    .search-container button {
        padding: 0 30px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .search-container button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(94, 53, 177, 0.3);
    }

    /* Table Container */
    .table-container {
        background: white;
        border-radius: 12px;
        padding: 25px;
        box-shadow: var(--card-shadow);
        overflow: hidden;
    }

    .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
    }

    .table-header h2 {
        font-size: 1.5rem;
        color: var(--primary);
    }

    .add-btn {
        padding: 12px 25px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .add-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(94, 53, 177, 0.3);
    }

    /* Table Styles */
    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        border-radius: 10px;
        overflow: hidden;
    }

    thead {
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
    }

    th {
        padding: 16px 20px;
        text-align: left;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-size: 0.9rem;
    }

    th:first-child {
        border-top-left-radius: 10px;
    }

    th:last-child {
        border-top-right-radius: 10px;
    }

    tbody tr {
        transition: var(--transition);
        border-bottom: 1px solid var(--light-gray);
    }

    tbody tr:hover {
        background-color: rgba(126, 87, 194, 0.05);
    }

    td {
        padding: 16px 20px;
        border-bottom: 1px solid var(--light-gray);
    }

    .product-image {
        width: 60px;
        height: 60px;
        object-fit: coverritional
        border-radius: 8px;
        border: 2px solid var(--light-gray);
        transition: var(--transition);
    }

    .product-image:hover {
        transform: scale(1.1);
        border-color: var(--secondary);
    }

    .price {
        font-weight: 700;
        color: var(--primary);
    }

    .status {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .status.available {
        background: rgba(76, 175, 80, 0.15);
        color: var(--success);
    }

    .status.out-of-stock {
        background: rgba(244, 67, 54, 0.15);
        color: var(--danger);
    }

    .actions {
        display: flex;
        gap: 10px;
    }

    .action-btn {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        border: none;
        cursor: pointer;
        transition: var(--transition);
        font-size: 1rem;
    }

    .action-btn:hover {
        transform: scale(1.1);
    }

    .edit-btn {
        background: rgba(76, 175, 80, 0.15);
        color: var(--success);
    }

    .edit-btn:hover {
        background: var(--success);
        color: white;
    }

    .delete-btn {
        background: rgba(244, 67, 54, 0.15);
        color: var(--danger);
    }

    .delete-btn:hover {
        background: var(--danger);
        color: white;
    }

    /* Stats Cards */
    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
    }

    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 25px;
        box-shadow: var(--card-shadow);
        display: flex;
        align-items: center;
        gap: 20px;
        transition: var(--transition);
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--hover-shadow);
    }

    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        color: white;
    }

    .stat-icon.products {
        background: linear-gradient(135deg, #5e35b1, #7e57c2);
    }

    .stat-icon.categories {
        background: linear-gradient(135deg, #ff7043, #ff9966);
    }

    .stat-icon.orders {
        background: linear-gradient(135deg, #4caf50, #66bb6a);
    }

    .stat-content h3 {
        font-size: 1.5rem;
        margin-bottom: 5px;
    }

    .stat-content p {
        color: #718096;
        font-size: 0.95rem;
    }

    /* Responsive Design */
    @media (max-width: 992px) {
        .layout {
            grid-template-columns: 80px 1fr;
            gap: 20px;
        }

        .sidebar {
            width: 80px;
            padding: 20px 0;
        }

        .sidebar .brand,
        .sidebar li span {
            display: none;
        }

        .sidebar a {
            justify-content: center;
            padding: 15px;
        }

        .sidebar a i {
            font-size: 1.4rem;
        }

        .main-content {
            padding-right: 10px;
        }
    }

    @media (max-width: 768px) {
        .layout {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .sidebar {
            width: 100%;
            margin-bottom: 20px;
        }

        .main-content {
            padding-right: 0;
        }

        .search-container form {
            flex-direction: column;
        }

        .search-container button {
            justify-content: center;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            min-width: 700px;
        }

        .stats-container {
            grid-template-columns: 1fr;
        }
    }
    
    .pagination {
	    margin-top: 20px;
	    display: flex;
	    justify-content: center;
	    gap: 10px;
	}
	
	.pagination a {
	    padding: 8px 12px;
	    text-decoration: none;
	    color: #333;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	}
	
	.pagination a:hover {
	    background-color: #f0f0f0;
	}
	
	.pagination .current {
	    padding: 8px 12px;
	    background-color: #007bff;
	    color: white;
	    border-radius: 4px;
	}
	
	/* Modal Styles */
	.modal {
	    display: none;
	    position: fixed;
	    z-index: 1000;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    background-color: rgba(0,0,0,0.4);
	}
	
	.modal-content {
	    background-color: #fefefe;
	    margin: 5% auto;
	    padding: 20px;
	    border: 1px solid #888;
	    width: 50%;
	    max-width: 600px;
	    border-radius: 5px;
	    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
	}
	
	.modal h2 {
	    margin-top: 0;
	    color: #333;
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.close:hover {
	    color: black;
	}
	
	.form-group {
	    margin-bottom: 15px;
	}
	
	.form-group label {
	    display: block;
	    margin-bottom: 5px;
	    font-weight: 500;
	}
	
	.form-group input[type="text"],
	.form-group input[type="number"],
	.form-group select,
	.form-group textarea {
	    width: 100%;
	    padding: 8px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	
	.form-group textarea {
	    resize: vertical;
	    min-height: 80px;
	}
	
	.form-actions {
	    display: flex;
	    justify-content: flex-end;
	    gap: 10px;
	    margin-top: 20px;
	}
	
	.save-btn, .delete-btn, .cancel-btn {
	    padding: 8px 16px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-weight: 500;
	}
	
	.save-btn {
	    background-color: #4CAF50;
	    color: white;
	}
	
	.save-btn:hover {
	    background-color: #45a049;
	}
	
	.delete-btn {
	    background-color: #f44336;
	    color: white;
	}
	
	.delete-btn:hover {
	    background-color: #d32f2f;
	}
	
	.cancel-btn {
	    background-color: #f1f1f1;
	    color: #333;
	}
	
	.cancel-btn:hover {
	    background-color: #ddd;
	}
	
	/* notification */
	.toast {
	    position: fixed;
	    top: 20px;
	    right: 20px;
	    min-width: 250px;
	    padding: 15px;
	    border-radius: 5px;
	    color: #333;              
	    font-size: 14px;
	    z-index: 1000;
	    opacity: 0;
	    transition: opacity 0.3s ease-in-out;
	    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	    background-color: #fff;
	}
	
	.toast.show {
	    opacity: 1;
	}
	
	.toast.success {
	    background-color: #d4edda !important; /* Xanh lá nhạt */
	    border: 1px solid #c3e6cb;
	}
	
	.toast.error {
	    background-color: #f8d7da !important; /* Đỏ nhạt */
	    border: 1px solid #f5c6cb;
	}
</style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container">
        <div class="layout">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp"></jsp:include>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Stats Cards -->
                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon products">
                            <i class="fas fa-tshirt"></i>
                        </div>
                        <div class="stat-content">
                            <h3>${totalProduct}</h3>
                            <p>Tổng sản phẩm</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon categories">
                            <i class="fas fa-list"></i>
                        </div>
                        <div class="stat-content">
                            <h3>${totalCategory }</h3>
                            <p>Tổng danh mục</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon orders">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <div class="stat-content">
                            <h3>42</h3>
                            <p>Đơn hàng hôm nay</p>
                        </div>
                    </div>
                </div>

                <!-- Search Container -->
                <div class="search-container">
                    <form method="GET" action="${pageContext.request.contextPath}/admin/danhsachsanpham">
                        <input type="text" name="search" placeholder="Nhập tên sản phẩm, mã sản phẩm..." value="${search}">
                        <button type="submit"><i class="fas fa-search"></i> Tìm Kiếm</button>
                    </form>
                </div>

                <!-- Table Container -->
                <div class="table-container">
                    <div class="table-header">
                        <h2>Danh Sách Sản Phẩm</h2>
                        <button class="add-btn"><i class="fas fa-plus"></i> Thêm Sản Phẩm</button>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Hình Ảnh</th>
                                <th>Số Lượng</th>
                                <th>Trạng Thái</th>
                                <th>Thực Hiện</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${products}">
							    <tr data-description="${product.description}" 
							        data-brand="${product.brand}" 
							        data-category-id="${product.categoryId}">
							        <td>${product.id}</td>
							        <td>${product.name}</td>
							        <td class="price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" /></td>
							        <td><img src="${pageContext.request.contextPath}${product.image}" alt="${product.name}" class="product-image"></td>
							        <td>${product.quantity}</td>
							        <td>
							            <c:choose>
							                <c:when test="${product.quantity == 0}">
							                    <span class="status out-of-stock">Hết Hàng</span>
							                </c:when>
							                <c:when test="${product.quantity <= 10}">
							                    <span class="status out-of-stock">Sắp Hết</span>
							                </c:when>
							                <c:otherwise>
							                    <span class="status available">Còn Hàng</span>
							                </c:otherwise>
							            </c:choose>
							        </td>
							        <td class="actions">
							            <div class="action-btn edit-btn" onclick="openEditModal('${product.id}', '${product.name}', '${product.description }', '${product.price }', '${product.quantity }', '${product.categoryId }', '${product.brand }', '${product.image }')">
                                            <i class="fas fa-edit"></i>
                                        </div>
                                        <div class="action-btn delete-btn" onclick="openDeleteModal('${product.id}', '${product.name}')">
						                    <i class="fas fa-trash"></i>
						                </div>
							        </td>
							    </tr>
							</c:forEach>
                        </tbody>
                    </table>
                    
                    <!-- Pagination -->
                    <div class="pagination">
                        <c:if test="${totalPages > 1}">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/admin/danhsachsanpham?page=${currentPage - 1}&size=${pageSize}&search=${search}">« Trước</a>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage == i}">
                                        <span class="current">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/danhsachsanpham?page=${i}&size=${pageSize}&search=${search}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/admin/danhsachsanpham?page=${currentPage + 1}&size=${pageSize}&search=${search}">Tiếp »</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!-- Modal Chỉnh Sửa Sản Phẩm -->
	<div id="editProductModal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closeEditModal()">&times;</span>
	        <h2>Chỉnh Sửa Sản Phẩm</h2>
	        <form id="editProductForm" method="POST" action="${pageContext.request.contextPath}/admin/capnhatsanpham" enctype="multipart/form-data">
	            <input type="hidden" id="editProductId" name="id">
	            
	            <div class="form-group">
	                <label for="editProductName">Tên Sản Phẩm</label>
	                <input type="text" id="editProductName" name="name" required>
	            </div>
	            
	            <div class="form-group">
	                <label for="editProductDescription">Mô Tả</label>
	                <textarea id="editProductDescription" name="description" rows="3"></textarea>
	            </div>
	            
	            <div class="form-group">
	                <label for="editProductPrice">Giá</label>
	                <input type="text" id="editProductPrice" name="price" required>
	            </div>
	            
	            <div class="form-group">
	                <label for="editProductQuantity">Số Lượng</label>
	                <input type="number" id="editProductQuantity" name="quantity" min="0" required>
	            </div>
	            
	            <div class="form-group">
	                <label for="editProductBrand">Thương Hiệu</label>
	                <input type="text" id="editProductBrand" name="brand">
	            </div>
	            
	            <div class="form-group">
				    <label for="editProductCategory">Danh Mục</label>
				    <select id="editProductCategory" name="categoryId" required>
				        <c:forEach var="category" items="${categories}">
				            <option value="${category.id}" ${category.id != param.categoryId ? 'selected' : ''}>${category.name}</option>
				        </c:forEach>
				    </select>
				</div>
	            
	            <div class="form-group">
	                <label>Hình Ảnh Hiện Tại</label>
	                <img id="editProductCurrentImage" src="" alt="Current Image" style="max-width: 100px; display: block; margin-bottom: 10px;">
	                <input type="hidden" id="editProductCurrentImagePath" name="currentImage">
	            </div>
	            
	            <div class="form-group">
	                <label for="editProductImage">Thay Đổi Hình Ảnh</label>
	                <input type="file" id="editProductImage" name="image" accept="image/*">
	            </div>
	            
	            <div class="form-actions">
	                <button type="submit" class="save-btn">Lưu Thay Đổi</button>
	            </div>
	        </form>
	    </div>
	</div>
	
	<!-- Modal Xác Nhận Xóa -->
	<div id="deleteProductModal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closeDeleteModal()">&times;</span>
	        <h2>Xác Nhận Xóa Sản Phẩm</h2>
	        <p>Bạn có chắc chắn muốn xóa sản phẩm <span id="productToDeleteName"></span>?</p>
	        <form id="deleteProductForm" method="POST" action="${pageContext.request.contextPath}/admin/xoasanpham">
	            <input type="hidden" id="deleteProductId" name="id">
	            <div class="form-actions">
	                <button type="submit" class="delete-btn">Xóa</button>
	                <button type="button" class="cancel-btn">Hủy</button>
	            </div>
	        </form>
	    </div>
	</div>
	
	<!--notification container -->
    <div id="toast"></div>
    
	<script>
		function openEditModal(id, name, description, price, quantity, categoryId, brand, image) {
	        document.getElementById('editProductId').value = id;
	        document.getElementById('editProductName').value = name;
	        document.getElementById('editProductDescription').value = description;
	        document.getElementById('editProductPrice').value = price;
	        document.getElementById('editProductQuantity').value = quantity;
	        document.getElementById('editProductBrand').value = brand;
	        document.getElementById('editProductCategory').value = categoryId;
	        document.getElementById('editProductCurrentImage').src = image;
	        document.getElementById('editProductCurrentImagePath').value = image;
	        document.getElementById('editProductModal').style.display = 'flex';
	    }
		
		function closeEditModal() {
	        document.getElementById('editProductModal').style.display = 'none';
	    }
	
	    document.getElementById('editProductModal').addEventListener('click', function(event) {
	        if (event.target === this) {
	            closeEditModal();
	        }
	    });
	    
	    function openDeleteModal(id, name) {
	        document.getElementById('deleteProductId').value = id;
	        document.getElementById('productToDeleteName').innerText = name;
	        document.getElementById('deleteProductModal').style.display = 'flex';
	    }
	    
	    function closeDeleteModal() {
	        document.getElementById('deleteProductModal').style.display = 'none';
	    }

	    document.getElementById('deleteProductModal').addEventListener('click', function(event) {
	        if (event.target === this) { 
	            closeDeleteModal();
	        }
	    });
		/*
	    // Lấy các modal và nút
	    const editModal = document.getElementById('editProductModal');
	    const deleteModal = document.getElementById('deleteProductModal');
	    const closeButtons = document.getElementsByClassName('close');
	    const cancelButtons = document.getElementsByClassName('cancel-btn');
	    const editButtons = document.getElementsByClassName('edit-btn');
	    const deleteButtons = document.getElementsByClassName('delete-btn');
	    const addButton = document.querySelector('.add-btn');
	
	    // Mở modal thêm sản phẩm
	    addButton.onclick = function() {
	        // Reset form
	        document.getElementById('editProductForm').reset();
	        document.getElementById('editProductId').value = '';
	        document.getElementById('editProductCurrentImage').style.display = 'none';
	        document.getElementById('editProductForm').action = '${pageContext.request.contextPath}/admin/themsanpham';
	        editModal.style.display = 'block';
	    }
	
	    // Mở modal chỉnh sửa sản phẩm
	    for (let i = 0; i < editButtons.length; i++) {
	        editButtons[i].onclick = function() {
	            const row = this.closest('tr');
	            const productId = row.cells[0].textContent;
	            const productName = row.cells[1].textContent;
	            const productPrice = row.cells[2].textContent.replace('₫', '').trim().replace(/\./g, '');
	            const productImage = row.cells[3].querySelector('img').src.replace('${pageContext.request.contextPath}', '');
	            const productQuantity = row.cells[4].textContent;
	            
	            // Giả sử chúng ta có thêm dữ liệu từ data attributes
	            const productDescription = row.dataset.description || '';
	            const productBrand = row.dataset.brand || '';
	            const productCategoryId = row.dataset.categoryId || '';
	
	            // Điền dữ liệu vào form
	            document.getElementById('editProductId').value = productId;
	            document.getElementById('editProductName').value = productName;
	            document.getElementById('editProductDescription').value = productDescription;
	            document.getElementById('editProductPrice').value = productPrice;
	            document.getElementById('editProductQuantity').value = productQuantity;
	            document.getElementById('editProductBrand').value = productBrand;
	            document.getElementById('editProductCategory').value = productCategoryId;
	            
	            // Hiển thị hình ảnh hiện tại
	            document.getElementById('editProductCurrentImage').src = '${pageContext.request.contextPath}' + productImage;
	            document.getElementById('editProductCurrentImage').style.display = 'block';
	            document.getElementById('editProductCurrentImagePath').value = productImage;
	            
	            // Đặt action cho form
	            document.getElementById('editProductForm').action = '${pageContext.request.contextPath}/admin/capnhatsanpham';
	            
	            // Hiển thị modal
	            editModal.style.display = 'block';
	        }
	    }
	
	    // Mở modal xóa sản phẩm
	    for (let i = 0; i < deleteButtons.length; i++) {
	        deleteButtons[i].onclick = function() {
	            const row = this.closest('tr');
	            const productId = row.cells[0].textContent;
	            const productName = row.cells[1].textContent;
	            
	            document.getElementById('deleteProductId').value = productId;
	            document.getElementById('productToDeleteName').textContent = productName;
	            deleteModal.style.display = 'block';
	        }
	    }
	
	    // Đóng modal khi click nút đóng (x)
	    for (let i = 0; i < closeButtons.length; i++) {
	        closeButtons[i].onclick = function() {
	            editModal.style.display = 'none';
	            deleteModal.style.display = 'none';
	        }
	    }
	
	    // Đóng modal khi click nút hủy
	    for (let i = 0; i < cancelButtons.length; i++) {
	        cancelButtons[i].onclick = function() {
	            editModal.style.display = 'none';
	            deleteModal.style.display = 'none';
	        }
	    }
	
	    // Đóng modal khi click bên ngoài modal
	    window.onclick = function(event) {
	        if (event.target == editModal) {
	            editModal.style.display = 'none';
	        }
	        if (event.target == deleteModal) {
	            deleteModal.style.display = 'none';
	        }
	    }
	
	    // Xử lý định dạng giá khi nhập
	    document.getElementById('editProductPrice').addEventListener('blur', function() {
	        let value = this.value.replace(/[^0-9]/g, '');
	        if (value) {
	            this.value = parseInt(value).toLocaleString('vi-VN');
	        }
	    });
	    */
	    
	 	// Xử lý form cập nhật sản phẩm
	    $('#editProductForm').on('submit', function(e) {
		    e.preventDefault();
		
		    const imageInput = document.getElementById('editProductImage');
		    const hasNewImage = imageInput.files.length > 0;
		    const hasCurrentImage = document.getElementById('editProductCurrentImagePath').value !== '';
		
		    // Check if either a new image is selected or a current image exists
		    if (!hasNewImage && !hasCurrentImage) {
		        showToast('Vui lòng chọn một hình ảnh mới hoặc giữ hình ảnh hiện tại!', 'error');
		        return;
		    }
		
		    const formData = new FormData(this);
		
		    $.ajax({
		        url: $(this).attr('action'),
		        type: 'POST',
		        data: formData,
		        processData: false,
		        contentType: false,
		        success: function(response) {
		            if (response.success) {
		            	sessionStorage.setItem('productUpdated', 'true');
	                    location.reload();
		            } else {
		                showToast('Có lỗi xảy ra: ' + response.message, 'error');
		            }
		        },
		        error: function(xhr, status, error) {
		            showToast('Lỗi khi gửi yêu cầu: ' + error, 'error');
		        }
		    });
		});
			 	
	 	// Hiển thị thông báo nếu vừa cập nhật sản phẩm
        if (sessionStorage.getItem('productUpdated') === 'true') {
            showToast('Cập nhật thông tin sản phẩm thành công.', 'success');
            sessionStorage.removeItem('productUpdated');
        }
	 
	 	// Xử lý form xóa sản phẩm
	    $('#deleteProductForm').on('submit', function(e) {
	        e.preventDefault();
	        
	        $.ajax({
	            url: $(this).attr('action'),
	            type: 'POST',
	            data: $(this).serialize(),
	            success: function(response) {
	                if (response.success) {
	                	sessionStorage.setItem('productDeleted', 'true');
	                    location.reload();
	                } else {
	                    alert('Có lỗi xảy ra: ' + response.message);
	                }
	            },
	            error: function(xhr, status, error) {
	                alert('Lỗi khi gửi yêu cầu: ' + error);
	            }
	        });
	    });
	 	
	 	// Hiển thị thông báo nếu vừa xóa sản phẩm
        if (sessionStorage.getItem('productDeleted') === 'true') {
            showToast('Xóa sản phẩm thành công.', 'success');
            sessionStorage.removeItem('productDeleted');
        }
	 	
	 	// Hàm hiển thị toast notification
        function showToast(message, type) {
            const toastContainer = $('#toast');
            const toast = $('<div>').addClass(`toast ${type} show`).text(message);
            toastContainer.append(toast);
            setTimeout(() => {
                toast.removeClass('show');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
	</script>
    <script>
    /*
        // Thêm hiệu ứng khi di chuột vào các hàng trong bảng
        document.querySelectorAll('tbody tr').forEach(row => {
            row.addEventListener('mouseenter', () => {
                row.style.transform = 'translateX(5px)';
            });

            row.addEventListener('mouseleave', () => {
                row.style.transform = 'translateX(0)';
            });
        });

        // Thêm hiệu ứng khi nhấn nút
        document.querySelectorAll('.action-btn, .add-btn, .search-container button').forEach(button => {
            button.addEventListener('mousedown', () => {
                button.style.transform = 'scale(0.95)';
            });

            button.addEventListener('mouseup', () => {
                button.style.transform = '';
            });

            button.addEventListener('mouseleave', () => {
                button.style.transform = '';
            });
        });
    )
    */
    </script>
</body>
</html>