<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh Mục - Shop Thời Trang</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
        }

        body {
            background-color: #f5f7fa;
            color: var(--dark);
            display: flex;
            height: 100vh;
            overflow-y: auto;
            flex-direction: column;
        }
        
        .container {
            display: flex;
            flex-direction: row;
        }
        

        /* Main Content */
        .main-content {
            flex: 1;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 30px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--light-gray);
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
        }

        .page-title i {
            margin-right: 12px;
            color: var(--primary);
            background: rgba(67, 97, 238, 0.1);
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }

        .btn i {
            margin-right: 8px;
        }

        /* Search and Filter */
        .search-section {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .search-form {
            flex: 1;
            position: relative;
        }

        .search-form input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            font-size: 15px;
            transition: var(--transition);
        }

        .search-form input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
            outline: none;
        }

        .search-form i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        .filter-btn {
            background: white;
            border: 1px solid var(--light-gray);
            padding: 0 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            color: var(--gray);
            cursor: pointer;
            transition: var(--transition);
        }

        .filter-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        /* Table */
        .table-container {
            flex: 1;
            overflow: auto;
            border-radius: var(--border-radius);
            border: 1px solid var(--light-gray);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 800px;
        }

        thead {
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th {
            background: var(--primary);
            color: white;
            padding: 16px 20px;
            text-align: left;
            font-weight: 500;
        }

        th:first-child {
            border-top-left-radius: 8px;
        }

        th:last-child {
            border-top-right-radius: 8px;
        }

        tbody tr {
            transition: var(--transition);
        }

        tbody tr:nth-child(even) {
            background-color: #f9fafc;
        }

        tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        td {
            padding: 15px 20px;
            border-bottom: 1px solid var(--light-gray);
        }

        .category-image {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 24px;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
        }

        .edit-btn {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .edit-btn:hover {
            background: rgba(76, 201, 240, 0.2);
            transform: translateY(-2px);
        }

        .delete-btn {
            background: rgba(247, 37, 133, 0.1);
            color: var(--secondary);
        }

        .delete-btn:hover {
            background: rgba(247, 37, 133, 0.2);
            transform: translateY(-2px);
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 100;
        }

        .modal-content {
            background-color: #fff;
            padding: 30px;
            border-radius: 15px;
            width: 450px;
            max-width: 90%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            position: relative;
            animation: modalAppear 0.3s ease-out;
        }

        @keyframes modalAppear {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 22px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
        }

        .modal-title i {
            margin-right: 10px;
            color: var(--primary);
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 24px;
            color: var(--gray);
            cursor: pointer;
            transition: var(--transition);
        }

        .close-modal:hover {
            color: var(--secondary);
            transform: rotate(90deg);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        .form-group input {
            width: 100%;
            padding: 14px;
            border: 1px solid var(--light-gray);
            border-radius: 8px;
            font-size: 16px;
            transition: var(--transition);
        }

        .form-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
            outline: none;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 20px;
        }

        .btn-outline {
            background: white;
            border: 1px solid var(--light-gray);
            color: var(--gray);
        }

        .btn-outline:hover {
            background: var(--light-gray);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                box-shadow: none;
            }
            .main-content {
                width: 100%;
            }
            .search-section {
                flex-direction: column;
            }
        }

        /* Stats */
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            flex: 1;
            background: white;
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--box-shadow);
            display: flex;
            align-items: center;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 24px;
        }

        .stat-1 .stat-icon {
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .stat-2 .stat-icon {
            background: rgba(247, 37, 133, 0.1);
            color: var(--secondary);
        }

        .stat-3 .stat-icon {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .stat-info h3 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--gray);
            font-size: 14px;
        }
        
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
        }
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        .pagination .current {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
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
		
		/*modal confirm delete*/
		.delete-modal {
		    display: none;
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background-color: rgba(0, 0, 0, 0.5);
		    justify-content: center;
		    align-items: center;
		    z-index: 100;
		}
		
		.delete-modal-content {
		    background-color: #fff;
		    padding: 25px;
		    border-radius: 12px;
		    width: 400px;
		    max-width: 90%;
		    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
		    position: relative;
		    animation: modalAppear 0.3s ease-out;
		}
		
		.delete-modal-header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin-bottom: 20px;
		}
		
		.delete-modal-title {
		    font-size: 20px;
		    font-weight: 600;
		    color: var(--dark);
		    display: flex;
		    align-items: center;
		}
		
		.delete-modal-title i {
		    margin-right: 10px;
		    color: var(--danger);
		}
		
		.delete-modal-close {
		    background: none;
		    border: none;
		    font-size: 22px;
		    color: var(--gray);
		    cursor: pointer;
		    transition: var(--transition);
		}		
		
		.delete-modal-btn {
		    padding: 10px 20px;
		    border-radius: 8px;
		    font-weight: 500;
		    cursor: pointer;
		    transition: var(--transition);
		    border: none;
		    display: inline-flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.delete-modal-btn.confirm {
		    background: var(--danger);
		    color: white;
		}
		
 
		.delete-modal-btn.cancel {
		    background: var(--light-gray);
		    color: var(--gray);
		}
 
 
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container">
        <div class="sidebar">
            <jsp:include page="sidebar.jsp"></jsp:include>
        </div>
        
        <div class="main-content">
            <div class="page-header">
                <div class="page-title">
                    <i class="fas fa-list"></i>
                    <h1>Quản Lý Danh Mục</h1>
                </div>
                <button class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm Danh Mục
                </button>
            </div>
            
            <!-- Stats -->
            <div class="stats">
                <div class="stat-card stat-1">
                    <div class="stat-icon">
                        <i class="fas fa-list"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalCategories}</h3>
                        <p>Tổng danh mục</p>
                    </div>
                </div>
                <div class="stat-card stat-2">
                    <div class="stat-icon">
                        <i class="fas fa-tshirt"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalProducts}</h3>
                        <p>Sản phẩm</p>
                    </div>
                </div>
                <div class="stat-card stat-3">
                    <div class="stat-icon">
                        <i class="fas fa-fire"></i>
                    </div>
                    <div class="stat-info">
                        <h3>123</h3>
                        <p>Danh mục nổi bật</p>
                    </div>
                </div>
            </div>
            
            <!-- Search Section -->
            <div class="search-section">
                <form action="${pageContext.request.contextPath}/admin/danhmucsanpham" method="GET" class="search-form">
                    <i class="fas fa-search"></i>
                    <input type="text" name="search" placeholder="Tìm kiếm danh mục..." value="${search}">
                    <input type="hidden" name="page" value="1">
                    <button type="submit" style="display:none;">Search</button>
                </form>
                <div class="filter-btn">
                    <i class="fas fa-filter"></i>
                </div>
            </div>
            
            <!-- Table -->
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Hình Ảnh</th>
                            <th>Tên Danh Mục</th>
                            <th>Số Sản Phẩm</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>
                                    <div class="category-image">
                                        <i class="fas fa-tshirt"></i>  
                                    </div>
                                </td>
                                <td>${category.name}</td>
                                <td>${category.productCount}</td>
                                <td>
                                    <div class="actions">
                                        <div class="action-btn edit-btn" onclick="openEditModal('${category.id}', '${category.name}', '${category.parentId }', '${category.description }')">
                                            <i class="fas fa-edit"></i>
                                        </div>
                                        <div class="action-btn delete-btn" onclick="openDeleteModal('${category.id}', '${category.name}')">
						                    <i class="fas fa-trash"></i>
						                </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <div class="pagination">
                <c:if test="${totalPages > 1}">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/admin/danhmucsanpham?page=${currentPage - 1}&size=${pageSize}&search=${search}">&laquo; Previous</a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/admin/danhmucsanpham?page=${i}&size=${pageSize}&search=${search}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/danhmucsanpham?page=${currentPage + 1}&size=${pageSize}&search=${search}">Next &raquo;</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- Edit Modal -->
    <div id="editCategoryModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">
                    <i class="fas fa-edit"></i>
                    <h2>Chỉnh sửa danh mục</h2>
                </div>
                <button class="close-modal" onclick="closeEditModal()">×</button>
            </div>
            
            <form id="editCategoryForm" method="POST" action="${pageContext.request.contextPath}/admin/capnhatdanhmuc">
                <input type="hidden" id="editCategoryId" name="id">
                
                <div class="form-group">
                    <label for="categoryName">Tên danh mục</label>
                    <input type="text" id="categoryName" name="categoryName" required>
                </div>
                
                <div class="form-group">
                    <label for="categoryType">Loại danh mục</label>
                    <select id="categoryType" name="categoryType" style="width:100%;padding:14px;border-radius:8px;border:1px solid #e9ecef;">
                        <option value="male">Đồ nam</option>
                        <option value="female">Đồ nữ</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="description">Mô tả</label>
                    <textarea id="description" name="description" rows="4" style="width:100%;padding:14px;border-radius:8px;border:1px solid #e9ecef;"></textarea>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" onclick="closeEditModal()">Hủy bỏ</button>
                    <button type="submit" class="btn btn-primary" name="edit_category">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Modal Xác Nhận Xóa -->
	<div id="deleteCategoryModal" class="delete-modal">
	    <div class="delete-modal-content">
	        <div class="delete-modal-header">
	            <div class="delete-modal-title">
	                <i class="fas fa-exclamation-triangle"></i>
	                <h2>Xác Nhận Xóa Danh Mục</h2>
	            </div>
	            <button class="delete-modal-close" onclick="closeDeleteModal()">×</button>
	        </div>
	        <div class="delete-modal-body">
	            <p>Bạn có chắc chắn muốn xóa danh mục <span id="categoryToDeleteName"></span>?</p>
	        </div>
	        <form id="deleteCategoryForm" method="POST" action="${pageContext.request.contextPath}/admin/xoadanhmuc">
	            <input type="hidden" id="deleteCategoryId" name="id">
	            <div class="delete-modal-footer">
	                <button type="submit" class="delete-modal-btn confirm">Xóa</button>
	                <button type="button" class="delete-modal-btn cancel" onclick="closeDeleteModal()">Hủy</button>
	            </div>
	        </form>
	    </div>
	</div>
		
	<!--notification container -->
    <div id="toast"></div>
    
    <script>
	    function openEditModal(id, categoryName, parentId, description) {
	        document.getElementById('editCategoryId').value = id;
	        document.getElementById('categoryName').value = categoryName;
	        document.getElementById('categoryType').value = parentId === '100' ? 'male' : 'female';
	        document.getElementById('description').value = description;
	        document.getElementById('editCategoryModal').style.display = 'flex';
	    }
	
	    function closeEditModal() {
	        document.getElementById('editCategoryModal').style.display = 'none';
	    }
	
	    document.getElementById('editCategoryModal').addEventListener('click', function(event) {
	        if (event.target === this) {
	            closeEditModal();
	        }
	    });
	    
	    function openDeleteModal(categoryId, categoryName) {
	        document.getElementById('deleteCategoryId').value = categoryId;
	        document.getElementById('categoryToDeleteName').innerText = categoryName;
	        document.getElementById('deleteCategoryModal').style.display = 'flex';
	    }
	    
	    function closeDeleteModal() {
	        document.getElementById('deleteCategoryModal').style.display = 'none';
	    }

	    document.getElementById('deleteCategoryModal').addEventListener('click', function(event) {
	        if (event.target === this) { 
	            closeDeleteModal();
	        }
	    });
	    
	    $('#editCategoryForm').on('submit', function(e) {
	        e.preventDefault();
	        console.log("Form submitted");

	        const formData = new FormData(this);
	        for (var pair of formData.entries()) {
	            console.log(pair[0] + ': ' + pair[1]); // In ra dữ liệu form để kiểm tra
	        }

	        $.ajax({
	            url: $(this).attr('action'),
	            type: 'POST',
	            data: formData,
	            processData: false, 
	            contentType: false, 
	            success: function(response) {
	                console.log("Response:", response);
	                if (response.success) {
	                	sessionStorage.setItem('categoryUpdated', 'true');
	                    location.reload();
	                    /*
	                    showToast('Cập nhật danh mục thành công!', 'success');
	                    document.getElementById('editCategoryModal').style.display = 'none';
	                    location.reload();
	                    */
	                } else {
	                    alert('Có lỗi xảy ra: ' + (response.message || 'Không có thông báo lỗi'));
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', xhr.responseText);
	                alert('Lỗi khi gửi yêu cầu: ' + xhr.responseText);
	            }
	        });
	    });
	    
	 	// Hiển thị thông báo nếu vừa cập nhật thông tin danh mục
        if (sessionStorage.getItem('categoryUpdated') === 'true') {
            showToast('Cập nhật thông tin danh mục thành công', 'success');
            sessionStorage.removeItem('categoryUpdated');
        }
	 	
	 
	 	// Xử lý form xóa danh mục
	    $('#deleteCategoryForm').on('submit', function(e) {
		    e.preventDefault();
		    
		    const deleteModal = document.getElementById('deleteCategoryModal');
		    
		    $.ajax({
		        url: $(this).attr('action'),
		        type: 'POST',
		        data: $(this).serialize(),
		        success: function(response) {
		            if (response.success) {
		            	sessionStorage.setItem('categoryDeleted', 'true');
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
			    
	 	// Hiển thị thông báo nếu vừa xóa danh mục
        if (sessionStorage.getItem('categoryDeleted') === 'true') {
            showToast('Xóa danh mục thành công', 'success');
            sessionStorage.removeItem('categoryDeleted');
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
</body>
</html>