<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
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
            flex-direction: column;
        }
        
        .main-content {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 25px;
            flex: 1;
        }
        
        .content {
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border);
        }
        
        .page-title {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .page-title h2 {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
        }
        
        .title-icon {
            width: 50px;
            height: 50px;
            background: rgba(67, 97, 238, 0.1);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 22px;
        }
        
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--secondary);
            font-size: 14px;
        }
        
        .breadcrumb a {
            color: var(--primary);
            text-decoration: none;
        }
        
        .form-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
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
        
        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 16px;
            transition: var(--transition);
            background: #f8fafc;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }
        
        .form-control::placeholder {
            color: #a0aec0;
        }
        
        .file-upload {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border: 2px dashed var(--border);
            border-radius: 10px;
            padding: 30px;
            background: #f8fafc;
            text-align: center;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .file-upload:hover {
            border-color: var(--primary);
            background: rgba(67, 97, 238, 0.05);
        }
        
        .file-upload i {
            font-size: 40px;
            color: var(--primary);
            margin-bottom: 15px;
        }
        
        .file-upload p {
            color: var(--secondary);
            margin-bottom: 10px;
        }
        
        .file-upload span {
            color: var(--primary);
            font-weight: 500;
        }
        
        .file-upload input {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }
        
        .description {
            grid-column: 1 / -1;
            margin-top: 10px;
        }
        
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 14px 28px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 6px rgba(67, 97, 238, 0.3);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            box-shadow: 0 6px 8px rgba(67, 97, 238, 0.4);
            transform: translateY(-2px);
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            justify-content: flex-end;
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--border);
            color: var(--secondary);
        }
        
        .btn-outline:hover {
            background: #f8f9fa;
            border-color: var(--primary);
            color: var(--primary);
        }
        
        .image-preview {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        
        .preview-container {
            width: 200px;
            height: 200px;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8fafc;
        }
        
        .preview-container img {
            max-width: 100%;
            max-height: 100%;
            display: none;
        }
        
        .preview-placeholder {
            text-align: center;
            color: var(--secondary);
            padding: 20px;
        }
        
        .preview-placeholder i {
            font-size: 50px;
            margin-bottom: 15px;
            color: #cbd5e0;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: var(--secondary);
            font-size: 14px;
        }
        
        /* Responsive design */
        @media (max-width: 992px) {
            .form-container {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                grid-template-columns: 1fr;
            }
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
    <div class="container">
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="main-content">
            <jsp:include page="sidebar.jsp"></jsp:include>
            
            <div class="content">
                <div class="page-header">
                    <div class="page-title">
                        <div class="title-icon">
                            <i class="fas fa-plus-circle"></i>
                        </div>
                        <div>
                            <h2>Thêm sản phẩm mới</h2>
                            <div class="breadcrumb">
                                <a href="#">Sản phẩm</a>
                                <i class="fas fa-chevron-right"></i>
                                <span>Thêm mới</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <form id="product-form">
                    <div class="form-container">
                        <div class="form-group">
						    <label for="danh-muc">Danh mục sản phẩm</label>
						    <select id="danh-muc" class="form-control" name="danh_muc">
						        <option value="0">Chọn danh mục</option>
						        <c:forEach var="category" items="${allCategory}">
						            <option value="${category.id}">${category.name}</option>
						        </c:forEach>
						    </select>
						</div>
                        
                        <div class="form-group">
                            <label for="ten-san-pham">Tên sản phẩm</label>
                            <input type="text" id="ten-san-pham" class="form-control" name="ten_san_pham" placeholder="Nhập tên sản phẩm">
                        </div>
                        
                        <div class="form-group">
                            <label for="ten_thuong_hieu">Tên thương hiệu</label>
                            <input type="text" id="ten_thuong_hieu" class="form-control" name="ten_thuong_hieu" placeholder="Nhập tên thương hiệu">
                        </div>
                        
                        <div class="form-group">
                            <label for="gia-san-pham">Giá sản phẩm (VND)</label>
                            <input type="number" id="gia-san-pham" class="form-control" name="gia_san_pham" placeholder="Nhập giá sản phẩm">
                        </div>
                        
                        <div class="form-group">
                            <label for="so-luong">Số lượng tồn kho</label>
                            <input type="number" id="so-luong" class="form-control" name="so_luong" value="0">
                        </div>
                        
                        <div class="form-group">
                            <label for="mo-ta">Mô tả sản phẩm</label>
                            <textarea id="mo-ta" class="form-control" name="mo_ta" placeholder="Nhập mô tả chi tiết về sản phẩm..."></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label>Ảnh đại diện</label>
                            <div class="file-upload" id="upload-area">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <p>Kéo thả ảnh vào đây hoặc <span>chọn từ máy tính</span></p>
                                <p class="small">(Định dạng JPG, PNG, tối đa 5MB)</p>
                                <input type="file" id="anh-dai-dien" name="anh_dai_dien" accept="image/*">
                            </div>
                            <div class="image-preview">
                                <div class="preview-container">
                                    <div class="preview-placeholder">
                                        <i class="fas fa-image"></i>
                                        <p>Chưa có ảnh được chọn</p>
                                    </div>
                                    <img id="preview-img" src="" alt="Preview">
                                </div>
                            </div>
                        </div>                        
                    </div>
                    
                    <div class="action-buttons">
                        <button type="button" class="btn btn-outline">
                            <i class="fas fa-times"></i> Hủy bỏ
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i> Thêm sản phẩm
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!--notification container -->
    <div id="toast"></div>
    
    <script>
	    $(document).ready(function() {
	        $('#product-form').on('submit', function(e) {
	            e.preventDefault();
	
	            // Create FormData object to handle file upload
	            let formData = new FormData(this);
	
	            $.ajax({
	                url: '${pageContext.request.contextPath}/admin/themsanpham',
	                type: 'POST',
	                data: formData,
	                processData: false,
	                contentType: false,
	                success: function(response) {
	                	if (response.success) {
		                	sessionStorage.setItem('productAdded', 'true');
		                    location.reload();
		                } else {
		                    alert('Có lỗi xảy ra: ' + (response.message || 'Không có thông báo lỗi'));
		                }
	                },
	                error: function(xhr) {
	                    let errorMessage = xhr.responseText || 'Đã có lỗi xảy ra khi thêm sản phẩm';
	                    showToast(errorMessage, 'error');
	                }
	            });
	        });
	    });
	    
		// Hiển thị thông báo nếu vừa thêm sản phẩm
        if (sessionStorage.getItem('productAdded') === 'true') {
            showToast('Thêm sản phẩm thành công.', 'success');
            sessionStorage.removeItem('productAdded');
        }
	    
        // Image preview functionality
        const uploadArea = document.getElementById('upload-area');
        const fileInput = document.getElementById('anh-dai-dien');
        const previewImg = document.getElementById('preview-img');
        const previewPlaceholder = document.querySelector('.preview-placeholder');
        
        uploadArea.addEventListener('click', () => {
            fileInput.click();
        });
        
        fileInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                    previewPlaceholder.style.display = 'none';
                }
                
                reader.readAsDataURL(this.files[0]);
            }
        });
        
        
        
        // Drag and drop for image upload
        uploadArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            this.style.borderColor = '#4361ee';
            this.style.backgroundColor = 'rgba(67, 97, 238, 0.1)';
        });
        
        uploadArea.addEventListener('dragleave', function() {
            this.style.borderColor = '#e1e5eb';
            this.style.backgroundColor = '#f8fafc';
        });
        
        uploadArea.addEventListener('drop', function(e) {
            e.preventDefault();
            this.style.borderColor = '#e1e5eb';
            this.style.backgroundColor = '#f8fafc';
            
            if (e.dataTransfer.files.length) {
                fileInput.files = e.dataTransfer.files;
                
                // Trigger change event
                const event = new Event('change');
                fileInput.dispatchEvent(event);
            }
        });
        
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