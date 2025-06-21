<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @charset "UTF-8";

		body {
			margin-bottom: 90px;
			padding-top: 80px;
		}
        header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 10px 0;
            height: 80px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 1000;
             
        }

		.header-container {
		    padding: 0 15px; /* Giữ padding mặc định của Bootstrap */
		}
		
        .navbar {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            background: #fff;
        }

        .navbar-brand img {
            height: 50px;
            transition: transform 0.3s;
        }

        .navbar-brand img:hover {
            transform: scale(1.1);
        }

        .nav-link {
            font-weight: 600;
            text-transform: uppercase;
            color: #333 !important;
        }

        .nav-link:hover {
            color: #ff6f61 !important;
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }

        .dropdown-item {
            font-weight: 500;
            transition: all 0.3s;
        }

        .dropdown-item:hover {
            background: #ff6f61;
            color: #fff !important;
        }

        .dropdown-divider {
            opacity: 0.1;
        }

        @media (max-width: 991px) {
            .dropdown-menu {
                border: none;
                box-shadow: none;
                margin-top: 0;
                background: rgba(0, 0, 0, 0.03);
            }
            .dropdown-item {
                padding-left: 30px;
            }
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .cart-icon {
            display: flex;
            align-items: center;
            color: #333;
            text-decoration: none;
            transition: color 0.3s;
        }

        .cart-icon:hover {
            color: #ff6f61;
        }

        .user-actions .dropdown-toggle {
            display: flex;
            align-items: center;
            color: #0080ff;
            text-decoration: none;
            padding: 5px;
            transition: color 0.3s;
        }

        .user-actions .dropdown-toggle:hover {
            color: #ff6f61;
        }

        .user-actions .dropdown-menu {
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            min-width: 180px;
            margin-top: 5px;
            z-index: 2000;
        }

        .user-actions .dropdown-item {
            font-weight: 500;
            padding: 8px 15px;
            transition: all 0.3s;
        }

        .user-actions .dropdown-item:hover {
            background: #ff6f61;
            color: #fff !important;
        }

        @media (max-width: 991px) {
            .user-actions {
                gap: 10px;
                padding: 10px 0;
            }
            .user-actions .dropdown-menu {
                box-shadow: none;
                width: 100%;
            }
        }
		
		/* Common modal styles */
		.modal {
		    display: none;
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: rgba(0, 0, 0, 0.6);
		    justify-content: center;
		    align-items: center;
		    z-index: 2000;
		    animation: fadeIn 0.3s ease-in-out;
		}
		
		.modal-content {
		    background: white;
		    border-radius: 16px;
		    width: 90%;
		    max-width: 800px;
		    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
		    overflow: hidden;
		    position: relative;
		    transform: scale(0.95);
		    animation: scaleUp 0.3s ease-in-out forwards;
		}
		
		.modal-header {
		    padding: 24px;
		    border-bottom: 1px solid #eee;
		    position: relative;
		}
		
		.modal-title {
		    font-size: 24px;
		    font-weight: 700;
		    color: #333;
		    margin: 0;
		}
		
		.close-btn {
		    position: absolute;
		    top: 20px;
		    right: 20px;
		    font-size: 24px;
		    color: #666;
		    cursor: pointer;
		    transition: color 0.3s;
		}
		
		.close-btn:hover {
		    color: #333;
		}
		
		.modal-body {
		    display: flex;
		    min-height: 400px;
		}
		
		.modal-image-section {
		    flex: 1;
		    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		    padding: 40px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.modal-image {
		    max-width: 280px;
		    width: 100%;
		    height: auto;
		    border-radius: 8px;
		    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
		}
		
		.form-section {
		    flex: 1;
		    padding: 40px;
		    background: #f8f9fa;
		}
		
		.form-message {
		    color: #dc3545;
		    font-size: 14px;
		    margin-bottom: 16px;
		    display: none;
		}
		
		.modal-form {
		    display: flex;
		    flex-direction: column;
		    gap: 16px;
		}
		
		.form-input {
		    width: 100%;
		    padding: 12px 16px;
		    border: 2px solid #e9ecef;
		    border-radius: 8px;
		    font-size: 14px;
		    transition: all 0.3s;
		}
		
		.form-input:focus {
		    border-color: #667eea;
		    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
		    outline: none;
		}
		
		.form-actions {
		    display: flex;
		    flex-direction: column;
		    gap: 12px;
		    margin-top: 24px;
		}
		
		.btn-primary {
		    background: #667eea;
		    color: white;
		    padding: 12px;
		    border: none;
		    border-radius: 8px;
		    font-size: 14px;
		    font-weight: 600;
		    cursor: pointer;
		    transition: all 0.3s;
		}
		
		.btn-primary:hover {
		    background: #5666d6;
		    transform: translateY(-1px);
		}
		
		.btn-secondary {
		    background: #4CAF50;
		    color: white;
		}
		
		.btn-tertiary {
		    background: #008CBA;
		    color: white;
		}
		
		.social-login {
		    margin-top: 24px;
		    text-align: center;
		}
		
		.social-divider {
		    color: #666;
		    margin: 20px 0;
		    position: relative;
		}
		
		.social-divider::before,
		.social-divider::after {
		    content: "";
		    flex: 1;
		    border-bottom: 1px solid #ddd;
		    margin: auto 10px;
		}
		
		.google-btn {
		    background: #4285F4;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    gap: 10px;
		    padding: 12px;
		    border-radius: 8px;
		    color: white;
		    text-decoration: none;
		    transition: all 0.3s;
		}
		
		.google-btn:hover {
		    background: #357abd;
		    transform: translateY(-1px);
		}
		
		/* Specific modal adjustments */
		#registerModal .modal-image-section {
		    background: linear-gradient(135deg, #4CAF50 0%, #81C784 100%);
		}
		
		#changePasswordModal .modal-image-section {
		    background: linear-gradient(135deg, #008CBA 0%, #00bcd4 100%);
		}
		
		.redirect-text {
		    text-align: center;
		    margin: 16px 0;
		    color: #666;
		}
		
		.redirect-link {
		    color: #667eea;
		    cursor: pointer;
		    font-weight: 500;
		    transition: color 0.3s;
		}
		
		.redirect-link:hover {
		    color: #5666d6;
		}
		
		/* Responsive Design */
		@media (max-width: 768px) {
		    .modal-body {
		        flex-direction: column;
		    }
		
		    .modal-image-section {
		        padding: 24px;
		        display: none; /* Hide image on mobile */
		    }
		
		    .form-section {
		        padding: 32px;
		    }
		
		    .modal-content {
		        max-width: 95%;
		    }
		}
		
		@keyframes fadeIn {
		    from { opacity: 0; }
		    to { opacity: 1; }
		}
		
		@keyframes scaleUp {
		    from { transform: scale(0.95); }
		    to { transform: scale(1); }
		}
		
		/* gợi ý tìm kiếm */
		.search-container {
		    position: relative;
		}
		
		.suggestions {
		    position: absolute;
		    top: 100%;
		    left: 0;
		    right: 0;
		    background: white;
		    border: 1px solid #ddd;
		    border-radius: 4px;
		    max-height: 300px;
		    overflow-y: auto;
		    z-index: 1000;
		    display: none;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.suggestion-item {
		    display: flex;
		    align-items: center;
		    padding: 10px;
		    cursor: pointer;
		    border-bottom: 1px solid #eee;
		    min-height: 60px;
		    gap: 12px; /* Thêm khoảng cách giữa các phần tử */
		}
		
		.suggestion-image {
		    width: 40px;
		    height: 40px;
		    object-fit: cover;
		    border-radius: 4px;
		    background-color: #f0f0f0;
		    flex-shrink: 0; /* Ngăn hình ảnh co lại */
		}
		
		/* Đảm bảo text không bị tràn */
		.suggestion-text {
		    overflow: hidden;
		}
		
		.suggestion-name {
		    font-weight: 500;
		    color: #333;
		    font-size: 1em;
		    white-space: nowrap;
		    overflow: hidden;
		    text-overflow: ellipsis;
		}
		
		.suggestion-price {
		    color: #d32f2f;
		    font-size: 0.9em;
		    margin-top: 4px;
		}
		
		.dropdown-toggle .username {
            font-weight: 600;
            color: #333;
            margin-left: 5px;
        }
        
        /* Style cho avatar */
        .user-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 5px;
        }
    </style>    
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light sticky-top">
            <div class="container header-container">
                <a class="navbar-brand" href="trangchu">
                    <img src="https://via.placeholder.com/150x50?text=Logo" alt="Logo">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="trangchu">Trang Chủ</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Sản Phẩm</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/danhmuc?category=112">Áo</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/danhmuc?category=114">Quần</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/danhmuc?category=120">Váy</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/danhmuc?category=all">Tất cả sản phẩm</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Khuyến Mãi</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Deal sốc</a></li>
                                <li><a class="dropdown-item" href="#">Combo giảm giá</a></li>
                                <li><a class="dropdown-item" href="#">Flash sale</a></li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="lienhe">Liên Hệ</a></li>
                    </ul>
                    <form class="d-flex me-3 search-container"  action="${pageContext.request.contextPath}/timkiem">
                        <input id="search-input" class="form-control me-2 search-input" type="search" name="q" placeholder="Tìm kiếm sản phẩm..." aria-label="Search" autocomplete="off" >
                        <button class="btn btn-outline-success" type="submit"><i class="fas fa-search"></i></button>
                        <div class="suggestions" id="suggestions"></div>
                    </form>
                    <div class="user-actions">
                        <c:choose>
                            <c:when test="${sessionScope.userId != null}">
                                <a href="giohang?userId=${sessionScope.userId}" class="me-3">
                                    <i class="fas fa-shopping-cart fa-lg"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" class="me-3 show-login-modal">
                                    <i class="fas fa-shopping-cart fa-lg"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <div class="dropdown">
                            <a class="dropdown-toggle" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <!-- Sử dụng JSTL để hiển thị ban đầu -->
                                <c:choose>
                                    <c:when test="${sessionScope.userId != null}">
                                        <c:if test="${not empty sessionScope.avatar}">
                                            <img src="${sessionScope.avatar}" class="user-avatar" alt="Avatar">
                                        </c:if>
                                        <span class="username">${sessionScope.username}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user fa-lg"></i>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <!-- Sử dụng JSTL để hiển thị menu ban đầu -->
                                <c:choose>
                                    <c:when test="${sessionScope.userId != null}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/thongtincanhan">Thông tin cá nhân</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/lichsudathang">Lịch sử đặt hàng</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a id="logoutLink" class="dropdown-item" href="#">Đăng xuất</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a id="openLoginModal" class="dropdown-item">Đăng Nhập</a></li>
                                        <li><a id="openRegisterModal" class="dropdown-item" href="#">Đăng Ký</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a id="openChangePasswordFromDropdown" class="dropdown-item" href="#">Quên mật khẩu?</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

		<!-- Login Modal -->
		<div id="loginModal" class="modal">
		    <div class="modal-content">
		        <div class="modal-header">
		            <h2 class="modal-title">Đăng nhập</h2>
		            <span id="closeLoginBtn" class="close-btn">&times;</span>
		        </div>
		        <div class="modal-body">
		            <div class="modal-image-section">
		                <img src="https://example.com/login-image.jpg" class="modal-image" alt="Login">
		            </div>
		            <div class="form-section">
		                <p class="form-message" id="loginMessage"></p>
		                <form class="modal-form" id="loginForm">
		                    <input type="text" name="username" class="form-input" placeholder="Tên đăng nhập" required>
		                    <input type="password" name="password" class="form-input" placeholder="Mật khẩu" required>
		                    <div class="form-actions">
		                        <button type="submit" class="btn-primary btn-primary">Đăng nhập</button>
		                        <button type="button" class="btn-primary btn-secondary" id="openRegister">Đăng ký tài khoản</button>
		                    </div>
		                </form>
		                <div class="social-login">
		                    <div class="social-divider">Hoặc tiếp tục với</div>
		                    <a href="https://accounts.google.com/o/oauth2/v2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/BTFOMain/dangnhap&response_type=code&client_id=424217027014-ki3n2f8ufhrmigar1e8hmtga8gt80cd6.apps.googleusercontent.com&approval_prompt=force"
								class="google-btn">
		                        <i class="fab fa-google"></i>
		                        Đăng nhập bằng Google
		                    </a>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
		<!-- Register Modal -->
		<div id="registerModal" class="modal">
		    <div class="modal-content">
		        <div class="modal-header">
		            <h2 class="modal-title">Đăng ký</h2>
		            <span id="closeRegisterBtn" class="close-btn">&times;</span>
		        </div>
		        <div class="modal-body">
		            <div class="modal-image-section">
		                <img src="https://example.com/register-image.jpg" class="modal-image" alt="Register">
		            </div>
		            <div class="form-section">
		                <p class="form-message" id="registerMessage"></p>
		                <form class="modal-form" id="registerForm">
		                    <input type="text" class="form-input" placeholder="Họ và tên" required>
		                    <input type="email" class="form-input" placeholder="Email" required>
		                    <input type="text" class="form-input" placeholder="Số điện thoại" name="phone">
							<input type="text" class="form-input" placeholder="Địa chỉ" name="address">
		                    <input type="password" class="form-input" placeholder="Mật khẩu" required>
		                    <input type="password" class="form-input" placeholder="Nhập lại mật khẩu" required>
		                    <div class="form-actions">
		                        <button type="submit" class="btn-primary btn-secondary">Đăng ký</button>
		                        <p class="redirect-text">
		                            Đã có tài khoản? 
		                            <span class="redirect-link" id="openLoginFromChangeRegister">Đăng nhập ngay</span>
		                        </p>
		                    </div>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>
		
		<!-- Change Password Modal -->
		<div id="changePasswordModal" class="modal">
		    <div class="modal-content">
		        <div class="modal-header">
		            <h2 class="modal-title">Đổi mật khẩu</h2>
		            <span class="close-btn">&times;</span>
		        </div>
		        <div class="modal-body">
		            <div class="modal-image-section">
		                <img src="https://example.com/password-image.jpg" class="modal-image" alt="Change Password">
		            </div>
		            <div class="form-section">
		                <p class="form-message" id="passwordMessage"></p>
		                <form class="modal-form" id="changePasswordForm">
		                	<input type="text" class="form-input" placeholder="Tên đăng nhập" required>
		                    <input type="password" class="form-input" placeholder="Mật khẩu hiện tại" required>
		                    <input type="password" class="form-input" placeholder="Mật khẩu mới" required>
		                    <input type="password" class="form-input" placeholder="Xác nhận mật khẩu" required>
		                    <div class="form-actions">
		                        <button type="submit" class="btn-primary btn-tertiary">Đổi mật khẩu</button>
		                        <p class="redirect-text">
		                            Quay lại 
		                            <span class="redirect-link" id="backToLogin">Đăng nhập</span>
		                        </p>
		                    </div>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>
    </header>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/3.0.1/js.cookie.min.js"></script>
	<script>	
		$('#search-input').on('input', function () {
		    const query = $(this).val();
		    
		    if (query.length === 0) {
		        $('#suggestions').hide().empty();
		        return;
		    }
	
		    $.ajax({
		        url: '/Shopping/search/suggestions',
		        method: 'GET',
		        data: { q: query },
		        success: function (data) {
		            const $suggestions = $('#suggestions');
		            $suggestions.empty();
		            
		            if (data.length > 0) {
		                data.forEach(function (item) {
		                    // Tạo phần tử gợi ý
		                    const $item = $('<div class="suggestion-item"></div>');
		                    
		                    // Thêm hình ảnh nếu có
		                    if (item.image) {
		                        $item.append($('<img>', {
		                            'class': 'suggestion-image',
		                            'src': contextPath + item.image,
		                            'alt': item.name
		                        }));
		                    } else {
		                        $item.append($('<div>', {
		                            'class': 'suggestion-image'
		                        }));
		                    }
		                    
		                    // Tạo container cho văn bản
		                    const $textContainer = $('<div class="suggestion-text"></div>');
		                    $textContainer.append($('<span class="suggestion-name">').text(item.name));
		                    
		                    if (item.price) {
		                        $textContainer.append($('<span class="suggestion-price">').text(' ' + item.price + 'đ'));
		                    }
		                    
		                    $item.append($textContainer);
		                    
		                    // Sự kiện click để chuyển hướng
		                    $item.on('click', function() {
		                        window.location.href = contextPath + '/chitietsanpham?id=' + item.id;
		                    });
		                    
		                    $suggestions.append($item);
		                });
		                $suggestions.show();
		            } else {
		                $suggestions.hide();
		            }
		        },
		        error: function (xhr, status, error) {
		            console.error('Error fetching suggestions:', error);
		        }
		    });
		});
	
		// nhấn Enter để chuyển đến trang tìm kiếm
		$('#search-input').on('keypress', function (e) {
		    if (e.which === 13) { // 13 là mã phím Enter
		    	e.preventDefault();
		        const query = $(this).val().trim();
		        if (query) {
		            window.location.href = contextPath + '/timkiem?q=' + encodeURIComponent(query);
		        }
		    }
		});	    
		
		
	 	// Đóng danh sách gợi ý khi nhấp bên ngoài
	    $(document).on('click', function(event) {
	        if (!$(event.target).closest('#suggestions, #search-input').length) {
	            $('#suggestions').hide().empty();
	        }
	    });
	</script>
	
	<script>
        // Khai báo contextPath để sử dụng trong JavaScript
        const contextPath = "${pageContext.request.contextPath}";
        
        // Hàm cập nhật giao diện người dùng
        function updateUserInterface() {
            const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
            const username = localStorage.getItem("username");
            const avatar = localStorage.getItem("avatar");
            const userId = localStorage.getItem("userId");
            
            const $userDropdown = $(".dropdown-toggle");
            const $dropdownMenu = $(".dropdown-menu");
            const $cartLink = $(".user-actions a.me-3");
            
            if (isLoggedIn && username) {
                // Cập nhật dropdown header
                let avatarHtml = '';
                if (avatar) {
                    avatarHtml = `<img src="\${avatar}" class="user-avatar" alt="Avatar">`;
                }
                $userDropdown.html(`\${avatarHtml}<span class="username">\${username}</span>`);
                
                // Cập nhật menu dropdown - THÊM userId VÀO LINK THÔNG TIN CÁ NHÂN
                const userMenu = `
                    <li><a class="dropdown-item" href="\${contextPath}/thongtincanhan?userId=\${userId}">Thông tin cá nhân</a></li>
                    <li><a class="dropdown-item" href="\${contextPath}/lichsudathang">Lịch sử đặt hàng</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a id="logoutLink" class="dropdown-item" href="#">Đăng xuất</a></li>
                `;
                $dropdownMenu.html(userMenu);
                
                // Cập nhật link giỏ hàng
                $cartLink.attr("href", `giohang?userId=\${userId}`);
                $cartLink.removeClass("show-login-modal");
            } else {
                // Reset về giao diện chưa đăng nhập
                $userDropdown.html('<i class="fas fa-user fa-lg"></i>');
                
                const guestMenu = `
                    <li><a id="openLoginModal" class="dropdown-item">Đăng Nhập</a></li>
                    <li><a id="openRegisterModal" class="dropdown-item" href="#">Đăng Ký</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a id="openChangePasswordFromDropdown" class="dropdown-item" href="#">Quên mật khẩu?</a></li>
                `;
                $dropdownMenu.html(guestMenu);
                
                $cartLink.attr("href", "#").addClass("show-login-modal");
            }
            
            // Gắn lại sự kiện cho các phần tử mới
            $("#openLoginModal").on("click", openLoginModal);
            $("#openRegisterModal").on("click", openRegisterModal);
            $("#logoutLink").on("click", handleLogout);
            $("#openChangePasswordFromDropdown").on("click", openChangePasswordModal);
        }

        // Hàm tiện ích để mở modal
        function openLoginModal(event) {
            if(event) event.preventDefault();
            localStorage.setItem("redirectUrl", window.location.href);
            $("#loginModal").show();
        }
        
        function openRegisterModal(event) {
            if(event) event.preventDefault();
            $("#registerModal").show();
        }
        
        function openChangePasswordModal(event) {
            if(event) event.preventDefault();
            $("#changePasswordModal").show();
        }

        // Hàm tiện ích để đóng modal
        function closeModal(modalId) {
            $("#" + modalId).hide();
        }

        // Kiểm tra trạng thái đăng nhập khi tải trang
        $(document).ready(function () {
            // Kiểm tra localStorage để cập nhật giao diện
            updateUserInterface();
            
            // Đóng modal khi click ra ngoài
            $(".modal").on("click", function (event) {
                if ($(event.target).is(".modal")) {
                    $(this).hide();
                }
            });

            // Xử lý form đăng nhập
            $("#loginForm").on("submit", function (event) {
                event.preventDefault();
                const formData = {
                    username: $("#loginForm input[name='username']").val(),
                    password: $("#loginForm input[name='password']").val()
                };

                $.ajax({
                    type: "POST",
                    url: contextPath + "/users/login",
                    data: JSON.stringify(formData),
                    contentType: "application/json",
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {
                            $("#loginMessage").text(response.message).css("color", "green").show();
                            
                            // Lưu thông tin người dùng
                            localStorage.setItem("token", response.token);
                            localStorage.setItem("userId", response.userId);
                            localStorage.setItem("username", response.username);
                            localStorage.setItem("avatar", response.avatar || "");
                            localStorage.setItem("role", response.role);
                            localStorage.setItem("isLoggedIn", "true");

                            // Cập nhật giao diện
                            updateUserInterface();
                            closeModal("loginModal");

                            // Điều hướng
                            if (response.role === "admin") {
                                window.location.href = contextPath + "/admin/trangchu";
                            } else {
                                const redirectUrl = localStorage.getItem("redirectUrl") || contextPath + "/trangchu";
                                localStorage.removeItem("redirectUrl");
                                window.location.href = redirectUrl;
                            }
                        } else {
                            $("#loginMessage").text(response.message).css("color", "red").show();
                        }
                    },
                    error: function (xhr) {
                        $("#loginMessage").text("Đã xảy ra lỗi. Vui lòng thử lại.").css("color", "red").show();
                    }
                });
            });

            // Xử lý đăng xuất
            function handleLogout(event) {
                event.preventDefault();
                localStorage.setItem("redirectUrl", window.location.href);
                
                $.ajax({
                    type: "GET",
                    url: contextPath + "/users/logout",
                    contentType: "application/json",
                    success: function (response) {
                        // Xóa thông tin đăng nhập
                        localStorage.removeItem("token");
                        localStorage.removeItem("userId");
                        localStorage.removeItem("username");
                        localStorage.removeItem("avatar");
                        localStorage.removeItem("role");
                        localStorage.removeItem("isLoggedIn");
                        
                        // Cập nhật giao diện
                        updateUserInterface();
                        
                        // Điều hướng
                        window.location.href = contextPath + "/trangchu";
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi khi đăng xuất:", error);
                        alert("Đăng xuất thất bại. Vui lòng thử lại!");
                    }
                });
            }

            // Các sự kiện khác
            $("#openLoginModal").on("click", openLoginModal);
            $("#openRegisterModal").on("click", openRegisterModal);
            $("#openChangePasswordFromDropdown").on("click", openChangePasswordModal);
            $("#logoutLink").on("click", handleLogout);
            
            // Đóng modal
            $("#closeLoginBtn").on("click", function() { closeModal("loginModal"); });
            $("#closeRegisterBtn").on("click", function() { closeModal("registerModal"); });
            
            // Chuyển đổi giữa các modal
            $("#openRegister").on("click", function() {
                closeModal("loginModal");
                openRegisterModal();
            });
            $("#openLoginFromChangeRegister").on("click", function() {
                closeModal("registerModal");
                openLoginModal();
            });
            $("#backToLogin").on("click", function() {
                closeModal("changePasswordModal");
                openLoginModal();
            });
            
            // Mở modal đăng nhập khi click vào giỏ hàng
            $("body").on("click", ".show-login-modal", openLoginModal);
            
            // Tìm kiếm và gợi ý
            $('#search-input').on('input', function () {
                const query = $(this).val();
                
                if (query.length === 0) {
                    $('#suggestions').hide().empty();
                    return;
                }
        
                $.ajax({
                    url: contextPath + '/search/suggestions',
                    method: 'GET',
                    data: { q: query },
                    success: function (data) {
                        const $suggestions = $('#suggestions');
                        $suggestions.empty();
                        
                        if (data.length > 0) {
                            data.forEach(function (item) {
                                // Tạo phần tử gợi ý
                                const $item = $('<div class="suggestion-item"></div>');
                                
                                // Thêm hình ảnh nếu có
                                if (item.image) {
                                    $item.append($('<img>', {
                                        'class': 'suggestion-image',
                                        'src': contextPath + item.image,
                                        'alt': item.name
                                    }));
                                } else {
                                    $item.append($('<div>', {
                                        'class': 'suggestion-image'
                                    }));
                                }
                                
                                // Tạo container cho văn bản
                                const $textContainer = $('<div class="suggestion-text"></div>');
                                $textContainer.append($('<span class="suggestion-name">').text(item.name));
                                
                                if (item.price) {
                                    $textContainer.append($('<span class="suggestion-price">').text(' ' + item.price + 'đ'));
                                }
                                
                                $item.append($textContainer);
                                
                                // Sự kiện click để chuyển hướng
                                $item.on('click', function() {
                                    window.location.href = contextPath + '/chitietsanpham?id=' + item.id;
                                });
                                
                                $suggestions.append($item);
                            });
                            $suggestions.show();
                        } else {
                            $suggestions.hide();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error fetching suggestions:', error);
                    }
                });
            });
        
            // nhấn Enter để chuyển đến trang tìm kiếm
            $('#search-input').on('keypress', function (e) {
                if (e.which === 13) { // 13 là mã phím Enter
                    e.preventDefault();
                    const query = $(this).val().trim();
                    if (query) {
                        window.location.href = contextPath + '/timkiem?q=' + encodeURIComponent(query);
                    }
                }
            });    
            
            // Đóng danh sách gợi ý khi nhấp bên ngoài
            $(document).on('click', function(event) {
                if (!$(event.target).closest('#suggestions, #search-input').length) {
                    $('#suggestions').hide().empty();
                }
            });
        });
    </script>
</body>
</html>