<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thêm Danh Mục</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
	--success-dark: #388e3c;
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

html, body {
    margin: 0;
    padding: 0;
}

body {
	background-color: #f5f7fa;
	color: var(--dark);
	display: flex;
	height: 100vh;
	overflow: hidden;
	flex-direction: column;
}

.container {
	display: flex;
	flex-direction: column;
	flex: 1;
}

.main-content {
	display: grid;
	grid-template-columns: 250px 1fr;
	gap: 25px;
	flex: 1;
	padding: 20px;
}

/* Form Container */
.form-container {
	background: white;
	border-radius: 16px;
	box-shadow: var(--card-shadow);
	padding: 30px;
	width: 100%;
	transition: var(--transition);
	display: flex;
	flex-direction: column;
	height: 100%;
}

.form-container:hover {
	box-shadow: var(--hover-shadow);
}

.form-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
	padding-bottom: 15px;
	border-bottom: 1px solid var(--border);
}

.form-title {
	font-size: 1.75rem;
	font-weight: 600;
	color: var(--primary-dark);
	display: flex;
	align-items: center;
	gap: 10px;
}

.form-icon {
	width: 50px;
	height: 50px;
	background: #eef2ff;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: var(--primary);
	font-size: 1.5rem;
}

.form-content {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 25px;
	flex: 1;
}

.form-section {
	background: #fafbff;
	border-radius: 12px;
	padding: 20px;
	border: 1px solid var(--light-gray);
}

.form-section-title {
	font-size: 1.1rem;
	font-weight: 600;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 1px dashed var(--border);
	color: var(--primary-dark);
	display: flex;
	align-items: center;
	gap: 8px;
}

.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	margin-bottom: 8px;
	font-weight: 500;
	color: var(--dark);
	display: flex;
	align-items: center;
	gap: 6px;
}

.form-label i {
	color: var(--primary);
	font-size: 0.9rem;
}

.form-input {
	width: 100%;
	padding: 14px 16px;
	border: 1px solid var(--border);
	border-radius: 10px;
	font-size: 1rem;
	transition: var(--transition);
	background: white;
}

.form-input:focus {
	outline: none;
	border-color: var(--primary);
	box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
}

.form-textarea {
	min-height: 120px;
	resize: vertical;
}

.btn-submit {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	padding: 14px 28px;
	background: var(--primary);
	color: white;
	border: none;
	border-radius: 10px;
	font-size: 1rem;
	font-weight: 600;
	cursor: pointer;
	transition: var(--transition);
	margin-top: 10px;
	width: 100%;
	box-shadow: 0 4px 6px rgba(92, 107, 192, 0.2);
}

.btn-submit:hover {
	background: var(--primary-dark);
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(67, 97, 238, 0.3);
}

.btn-submit:active {
	transform: translateY(0);
}

.btn-submit i {
	margin-right: 8px;
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

/* Responsive */
@media ( max-width : 992px) {
	.main-content {
		grid-template-columns: 1fr;
	}
	.form-content {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 768px) {
	.form-container {
		padding: 20px;
	}
	.form-header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
	.form-title {
		font-size: 1.5rem;
	}
}
</style>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="main-content">
			<jsp:include page="sidebar.jsp"></jsp:include>

			<div class="form-container">
				<div class="form-header">
					<div class="form-title">
						<i class="fas fa-folder-plus"></i> Thêm Danh Mục Mới
					</div>
					<div class="form-icon">
						<i class="fas fa-tags"></i>
					</div>
				</div>

				<div class="form-content">
					<div class="form-section">
						<div class="form-section-title">
							<i class="fas fa-info-circle"></i> Thông tin cơ bản
						</div>

						<form action="#">
							<div class="form-group">
								<label for="tenDanhMuc" class="form-label"> <i
									class="fas fa-tag"></i> Tên Danh Mục
								</label> <input type="text" id="tenDanhMuc" name="tenDanhMuc"
									class="form-input" placeholder="Nhập tên danh mục" required>
							</div>

							<div class="form-group">
								<label for="chonDanhMuc" class="form-label"> <i
									class="fas fa-sitemap"></i> Danh mục cha
								</label> <select id="chonDanhMuc" name="chonDanhMuc"
									class="form-input form-select" required>
									<option value="" disabled selected>Chọn danh mục
										cha...</option>
									<option value="100">Đồ nam</option>
									<option value="200">Đồ nữ</option>
									<option value="300">Đồ trẻ em</option>
									<option value="400">Phụ kiện</option>
								</select>
							</div>
					</div>

					<div class="form-section">
						<div class="form-section-title">
							<i class="fas fa-align-left"></i> Mô tả danh mục
						</div>

						<div class="form-group">
							<label for="nhapDanhMuc" class="form-label"> <i
								class="fas fa-pen"></i> Mô tả chi tiết
							</label>
							<textarea id="nhapDanhMuc" name="nhapDanhMuc"
								class="form-input form-textarea"
								placeholder="Nhập mô tả chi tiết..." required></textarea>
						</div>

						<button type="submit" class="btn-submit">
							<i class="fas fa-plus-circle"></i> Thêm Danh Mục
						</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- notification container -->
	<div id="toast"></div>

	<script>
	    $(document).ready(function() {
	        // Xử lý sự kiện submit form
	        $('.btn-submit').on('click', function(event) {
	            event.preventDefault(); 
	
	            // Lấy dữ liệu từ form
	            var formData = {
	                name: $('#tenDanhMuc').val(),
	                parentId: $('#chonDanhMuc').val() === 'male' ? 100 : 200, 
	                description: $('#nhapDanhMuc').val()
	            };
	
	            // Gửi yêu cầu Ajax
	            $.ajax({
	                url: '${pageContext.request.contextPath}/admin/themdanhmuc',
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify(formData),
	                success: function(response) {
	                	if (response.success) {
		                	sessionStorage.setItem('categoryAdded', 'true');
		                    location.reload();
		                } else {
		                    alert('Có lỗi xảy ra: ' + (response.message || 'Không có thông báo lỗi'));
		                }
	                },
	                error: function(xhr, status, error) {
	                    alert('Có lỗi xảy ra: ' + xhr.responseText);
	                }
	            });
	        });
	    });
	    
		// Hiển thị thông báo nếu vừa thêm danh mục
        if (sessionStorage.getItem('categoryAdded') === 'true') {
            showToast('Thêm danh mục thành công.', 'success');
            sessionStorage.removeItem('categoryAdded');
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