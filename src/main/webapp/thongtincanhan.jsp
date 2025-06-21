<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --background-color: #f8f9fa;
            --text-color: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
            gap: 20px;
        }

        aside {
            width: 250px;
            background: var(--primary-color);
            color: white;
            border-radius: 10px;
            padding: 1.5rem;
            height: fit-content;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        aside ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        aside li {
            padding: 15px 20px;
            cursor: pointer;
            transition: background 0.3s ease;
            border-radius: 5px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            font-size: 16px;
        }

        aside li i {
            margin-right: 10px;
            font-size: 18px;
        }

        aside li:hover {
            background: rgba(255,255,255,0.1);
        }

        aside li.active {
            background: rgba(255,255,255,0.2);
            border-left: 3px solid var(--secondary-color);
        }

        aside li:not(:last-child) {
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        main {
            flex: 1;
            background: white;
            border-radius: 10px;
            padding: 2.5rem;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-control {
            width: 100%;
            padding: 0.875rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
            outline: none;
        }

        .address-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            position: relative;
            border: 1px solid #eee;
        }

        .address-card.default {
            border-left: 4px solid var(--secondary-color);
        }

        .address-actions {
            position: absolute;
            top: 1rem;
            right: 1rem;
            display: flex;
            gap: 8px;
        }

        .order-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .tab {
            padding: 10px 20px;
            border: none;
            background: #eee;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .tab.active {
            background: var(--primary-color);
            color: white;
        }

        .tab:hover {
            background: var(--secondary-color);
            color: white;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .order-table th,
        .order-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .order-table th {
            background: var(--primary-color);
            color: white;
        }

        main section {
            display: none;
        }

        main section.active {
            display: block;
            animation: fadeIn 0.3s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @media (max-width: 768px) {
		    .container {
		        padding: 0 10px;
		    }
		    
		    aside {
		        position: static;
		        width: 100%;
		        height: auto;
		        margin-bottom: 20px;
		    }
		    
		    main {
		        margin-left: 0;
		        width: 100%;
		        padding: 1.5rem;
		    }
		}
	        
	    .order-card {
	        background: white;
	        border-radius: 12px;
	        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	        margin-bottom: 1.5rem;
	        overflow: hidden;
	    }
	
	    .order-header {
	        padding: 1.5rem;
	        background: #f8f9fa;
	        border-bottom: 1px solid #eee;
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        flex-wrap: wrap;
	        gap: 1rem;
	    }
	
	    .order-meta {
	        flex: 1;
	        min-width: 250px;
	    }
	
	    .order-status {
	        padding: 6px 12px;
	        border-radius: 20px;
	        font-size: 0.85rem;
	        font-weight: 500;
	    }
	
	    .status-pending { background: #fff3cd; color: #856404; }
	    .status-shipping { background: #cce5ff; color: #004085; }
	    .status-completed { background: #d4edda; color: #155724; }
	    .status-canceled { background: #f8d7da; color: #721c24; }
	
	    .order-address {
	        padding: 1rem 1.5rem;
	        background: #f8f9fa;
	        border-bottom: 1px solid #eee;
	        display: flex;
	        align-items: center;
	        gap: 1rem;
	    }
	
	    .address-icon {
	        font-size: 1.2rem;
	        color: #666;
	    }
	
	    .order-products {
	        padding: 1.5rem;
	    }
	
	    .product-item {
	        display: flex;
	        gap: 1.5rem;
	        padding: 1rem 0;
	        border-bottom: 1px solid #eee;
	    }
	
	    .product-item:last-child {
	        border-bottom: none;
	    }
	
	    .product-image {
	        width: 80px;
	        height: 80px;
	        border-radius: 8px;
	        object-fit: cover;
	    }
	
	    .product-info {
	        flex: 1;
	    }
	
	    .product-variant {
	        font-size: 0.9rem;
	        color: #666;
	        margin-top: 0.5rem;
	    }
	
	    .product-price {
	        min-width: 120px;
	        text-align: right;
	    }
	
	    .order-footer {
	        padding: 1.5rem;
	        border-top: 1px solid #eee;
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	    }
	
	    .total-amount {
	        font-size: 1.2rem;
	        font-weight: 600;
	        color: var(--primary-color);
	    }
	
	    @media (max-width: 768px) {
	        .product-item {
	            flex-direction: column;
	            align-items: flex-start;
	        }
	        
	        .product-price {
	            text-align: left;
	            width: 100%;
	        }
	    }
	    
	    .btn-outline {
		  padding: 8px 16px;
		  border: 2px solid #3498db;
		  color: #3498db;
		  background-color: transparent;
		  border-radius: 6px;
		  font-size: 14px;
		  font-weight: 500;
		  cursor: pointer;
		  transition: all 0.3s ease;
		}
		
		.btn-outline:hover {
		  background-color: #3498db;
		  color: white;
		}
		
		.btn-danger {
		  padding: 8px 16px;
		  border: none;
		  background-color: #e74c3c;
		  color: white;
		  border-radius: 6px;
		  font-size: 14px;
		  font-weight: 500;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.btn-danger:hover {
		  background-color: #c0392b;
		}
		
		.toast {
            position: fixed;
            top: 20px;
            right: 20px;
            min-width: 250px;
            padding: 15px;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            z-index: 1000;
            opacity: 0;
            transition: opacity 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .toast.show {
            opacity: 1;
        }

        .toast.success {
            background: var(--success);
        }

        .toast.error {
            background: var(--danger);
        }
    
 
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        

        .modal-content {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            width: 100%;
            max-width: 500px;
            position: relative;
            box-shadow: 0 8px 30px rgba(0,0,0,0.2);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }

        .modal-close:hover {
            color: var(--danger);
        }
        
        .modal.show {
		    display: flex;
		}

        .btn-primary {
            padding: 10px 20px;
            border: none;
            background: var(--secondary-color);
            color: white;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn-primary:hover {
            background: Calais: 0;
            background: var(--primary-color);
        }

        .btn-icon {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            color: #666;
        }

        .btn-icon.text-danger {
            color: var(--danger);
        }
        
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal-content {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            transform: translateY(-20px);
            transition: transform 0.3s ease-out;
        }

        .modal-overlay.show .modal-content {
            transform: translateY(0);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--dark);
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            transition: opacity 0.3s ease;
            flex: 1;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: none;
        }

        .btn-secondary {
            background: var(--light);
            color: var(--dark);
            border: 2px solid #e9ecef;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            transition: border-color 0.3s ease;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <div style="height: 40px;"></div> <!-- Khoảng cách 20px -->
    

    <div class="container">
        <aside>
            <h3 style="color: white; margin-top: 0;">Tài khoản</h3>
            <ul>
                <li data-section="profile" class="active"><i class="fas fa-user"></i> Thông tin cơ bản</li>
                <li data-section="address"><i class="fas fa-map-marker-alt"></i> Địa chỉ giao hàng</li>
                <li data-section="orders"><i class="fas fa-history"></i> Lịch sử đơn hàng</li>
            </ul>
        </aside>

        <main>
            <section id="profile" class="active">
			    <div class="section-header">
			        <h2>Thông tin cá nhân</h2>
			        <button class="btn-primary">Lưu thay đổi</button>
			    </div>
			    <div class="form-grid">
			        <div class="form-group">
			            <label>Họ và tên</label>
			            <input type="text" id="inputUsername" class="form-control" value="${user.username}">
			        </div>
			        <div class="form-group">
			            <label>Email</label>
						<div><input class="form-control" id="inputEmail" value="${user.email}"></div>
			        </div>
			        <div class="form-group">
			            <label>Số điện thoại</label>
						<div><input class="form-control" id="inputPhone" value="${user.phone}"></div>
			        </div>
			    </div>
			</section>

            <section id="address">
			    <div class="section-header">
			        <h2>Địa chỉ của bạn</h2>
			        <button class="btn-primary" onclick="showAddressModal()">
			            <i class="fas fa-plus"></i> Thêm địa chỉ
			        </button>
			    </div>
			
			    <c:forEach var="item" items="${address}">
 
					
					<div class="address-card ${item.isDefault ? 'default' : ''}" data-address-id="${item.id}">
					    <div class="address-actions">
					        <button class="btn-icon"><i class="fas fa-edit"></i></button>
					        <button class="btn-icon text-danger"><i class="fas fa-trash"></i></button>
					    </div>
					    <h4>
					        <c:choose>
					            <c:when test="${item.isDefault}">
					                Địa chỉ mặc định
					                <p class="address-name">${item.name}</p>
					            </c:when>
					            <c:otherwise>
					                ${item.name}
					            </c:otherwise>
					        </c:choose>
					    </h4>
					    <p class="address-line">${item.addressLine}</p>
					    <p class="phone">Điện thoại: ${item.phone}</p>
					</div>
			    </c:forEach>
			</section>

            <section id="orders">
			    <h2>Lịch sử đơn hàng</h2>
			    <div class="order-tabs">
			        <button class="tab active" data-status="all">Tất cả</button>
			        <button class="tab" data-status="pending">Chờ xác nhận</button>
			        <button class="tab" data-status="shipped">Đang giao</button>
			        <button class="tab" data-status="delivered">Hoàn thành</button>
			        <button class="tab" data-status="canceled">Đã hủy</button>
			    </div>
			
			    <c:forEach var="order" items="${orders}">
			        <div class="order-card" data-status="${order.status}">
			            <div class="order-header">
			                <div class="order-meta">
			                    <div class="text-sm">Mã đơn hàng: #${order.id}</div>
			                    <div class="text-sm">Ngày đặt hàng: 
			                    	<fmt:formatDate value="${order.createdAtAsDate}" pattern="dd/MM/yyyy"/>
			                    </div>
			                </div>
			                <div class="order-status status-${order.status}">
			                </div>
			            </div>
			
			            <div class="order-address">
			                <i class="fas fa-map-marker-alt address-icon"></i>
			                <div>
			                    <div>Tên người nhận hàng: ${order.name}</div>
								<div>Số điện thoại: ${order.phone}</div>
			                    <div class="text-sm">Địa chỉ nhận hàng: ${order.addressLine}</div>
			                </div>
			            </div>
			            <div class="order-products">
			                <c:forEach var="orderDT" items="${orderDetails}">
			                    <c:if test="${order.id == orderDT.orderId}">
			                    	<div class="product-item">
				                        <div class="product-info">
				                            <div class="font-medium">${orderDT.productName}</div>
				                            <div class="product-variant">
				                                <span>Size: ${orderDT.size}</span>
				                                <span> | Màu: ${orderDT.color}</span>
				                            </div>
				                            <div class="text-sm">Số lượng: ${orderDT.quantity}</div>
				                        </div>
				                        <div class="product-price">Đơn giá:
				                            <fmt:formatNumber value="${orderDT.unitPrice}" 
				                                            type="currency"
				                                            currencySymbol="₫"/>
				                        </div>
				                    </div>
			                    </c:if>
			                </c:forEach>
			            </div>
			
			            <div class="order-footer">
			                <div class="total-amount">
			                    Tổng tiền: 
			                    <fmt:formatNumber value="${order.totalPrice}" 
			                                      type="currency"
			                                      currencySymbol="₫"/>
			                </div>
			                <div class="flex gap-2">
			                    <!--<button class="btn-outline">Xem chi tiết</button>  -->
			                    <c:if test="${order.status == 'pending'}">
			                        <button class="btn-danger" onclick="refundOrder(${order.id}, '${order.createdAt}', ${order.totalPrice})">Hủy đơn</button>
			                    </c:if>
			                </div>
			            </div>
			        </div>
			    </c:forEach>
			</section>

        </main>
    </div>
    
    <!-- Update Address Modal -->
    <div id="updateAddressModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Cập nhật địa chỉ</h2>
                <button class="modal-close">&times;</button>
            </div>
            <form id="updateAddressForm">
                <input type="hidden" id="addressId" name="id">
                <div class="form-group">
                    <label class="form-label">Họ và tên</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" id="addressLine" name="addressLine" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Ghi chú</label>
                    <textarea id="note" name="note" class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label>
                        <input type="checkbox" id="isDefault" name="isDefault">
                        Đặt làm địa chỉ mặc định
                    </label>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
	
	<!-- Address Modal -->
    <div class="modal-overlay" id="addressModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Chỉnh sửa địa chỉ nhận hàng</h3>
                <button class="modal-close" onclick="closeAddressModal()">×</button>
            </div>
            <div class="form-group">
                <label class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="modalName" required>
            </div>
            <div class="form-group">
                <label class="form-label">Số điện thoại</label>
                <input type="tel" class="form-control" id="modalPhone" required>
            </div>
            <div class="form-group">
                <label class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="modalAddress" required>
            </div>
            <div class="form-group">
                <label class="form-label">Ghi chú</label>
                <textarea class="form-control" id="modalNote" rows="3"></textarea>
            </div>
            <div class="modal-buttons">
                <button class="btn btn-secondary" onclick="closeAddressModal()">Hủy</button>
                <button class="btn btn-primary" onclick="saveAddress()">Lưu</button>
            </div>
        </div>
    </div>
    
	<div id="toast"></div>
	
    <jsp:include page="footer.jsp"></jsp:include>

    <script>
    function showAddressModal() {
        // Lấy phần tử modal bằng ID
        const addressModal = document.getElementById('addressModal');
        
        // Hiển thị modal bằng cách thêm class 'show' hoặc thay đổi style
        addressModal.style.display = 'flex';
        
        // Xóa dữ liệu cũ trong các trường input (nếu cần)
        document.getElementById('modalName').value = '';
        document.getElementById('modalPhone').value = '';
        document.getElementById('modalAddress').value = '';
        document.getElementById('modalNote').value = '';
    }
    

 	// Hàm đóng modal
    function closeAddressModal() {
        const addressModal = document.getElementById('addressModal');
        addressModal.style.display = 'none';
    }

    // Thêm sự kiện khi DOM được tải
    document.addEventListener('DOMContentLoaded', () => {
        const addressModal = document.getElementById('addressModal');
        
        // Đóng modal khi click vào nút "Hủy"
        const cancelButton = addressModal.querySelector('.btn-secondary');
        if (cancelButton) {
            cancelButton.addEventListener('click', closeAddressModal);
        }
        
        // Đóng modal khi click vào nút "×"
        const closeButton = addressModal.querySelector('.modal-close');
        if (closeButton) {
            closeButton.addEventListener('click', closeAddressModal);
        }
        
        // Đóng modal khi click ra ngoài modal
        addressModal.addEventListener('click', (event) => {
            if (event.target === addressModal) {
                closeAddressModal();
            }
        });
    });
     
    $(document).ready(function() {
        // Xử lý sự kiện khi click nút Lưu thay đổi
        $('#profile .btn-primary').click(function(e) {
            e.preventDefault();
            
            // Lấy giá trị từ input
			var newUsername = $('#inputUsername').val().trim();
		    var newEmail = $('#inputEmail').val().trim();
		    var newPhone = $('#inputPhone').val().trim();
            
            // Tạo dữ liệu gửi đi
            var updateData = {
                id: ${user.id},
                username: newUsername,
                email: newEmail,
                phone: newPhone
            };
            
            // Gửi yêu cầu AJAX
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/thongtincanhan/capnhat",
                contentType: "application/json",
                data: JSON.stringify(updateData),
                success: function(response) {
                	if (response.success) {
                    	sessionStorage.setItem('userUpdated', 'true');
	                    location.reload();
                    } else {
                    	showToast(response.message, 'error');
                    }
                },
                error: function(xhr) {
                    showToast('Lỗi hệ thống: ' + xhr.statusText, 'error');
                }
            });
        });

     	// Hiển thị thông báo nếu vừa cập nhật thông tin cá nhân của người dùng
        if (sessionStorage.getItem('userUpdated') === 'true') {
            showToast('Cập nhật thông tin người dùng thành công', 'success');
            sessionStorage.removeItem('userUpdated');
        }
    });
    
    document.addEventListener('DOMContentLoaded', () => {
        const menuItems = document.querySelectorAll('aside li');
        const sections = document.querySelectorAll('main section');
        const tabs = document.querySelectorAll('.order-tabs .tab');
        const rows = document.querySelectorAll('.order-table tbody tr');

        

        function switchSection(sectionId) {
            sections.forEach(section => {
                section.classList.remove('active');
                if (section.id === sectionId) section.classList.add('active');
            });
            menuItems.forEach(item => {
                item.classList.remove('active');
                if (item.dataset.section === sectionId) item.classList.add('active');
            });
            localStorage.setItem('activeSection', sectionId);
        }

        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                const sectionId = item.dataset.section;
                switchSection(sectionId);
            });
        });

        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                const status = tab.dataset.status;
                tabs.forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                rows.forEach(row => {
                    if (status === 'all' || row.dataset.status === status) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });

        const savedSection = localStorage.getItem('activeSection') || 'profile';
        switchSection(savedSection);

        const modal = document.getElementById('updateAddressModal');
        modal.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.classList.remove('show');
            }
        });
    });

    function changePassword() {
        const newPassword = document.getElementById('new-password').value;
        const confirmPassword = document.getElementById('confirm-password').value;
        if (newPassword === confirmPassword) {
            alert('Đổi mật khẩu thành công!');
            document.getElementById('current-password').value = '';
            document.getElementById('new-password').value = '';
            document.getElementById('confirm-password').value = '';
        } else {
            alert('Mật khẩu xác nhận không khớp!');
        }
    }

    function refundOrder(orderId, transDate, amount) {
        showToast("Yêu cầu hoàn tiền đang được gửi...", 'info');
        
        $.ajax({
            url: '${pageContext.request.contextPath}/api/payment/refund',  
            type: 'GET', 
            data: {
                orderId: orderId, 
                transDate: transDate, 
                amount: amount, 
                transType: '02', 
                user: 'admin' 
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'Ok') {
                    showToast("Yêu cầu hoàn tiền đang được xử lý. Giao dịch sẽ hoàn tất trong ít ngày.", 'success');
                } else {
                    showToast('Hoàn tiền thất bại: ' + response.message, 'error');
                }
            },
            error: function(xhr, status, error) {
                showToast('Đã có lỗi xảy ra khi gửi yêu cầu hoàn tiền: ' + error, 'error');
            }
        });
    }

    $(document).ready(function() {
        $('aside li').click(function() {
            $('aside li').removeClass('active');
            $(this).addClass('active');
            $('main section').removeClass('active');
            $('#' + $(this).data('section')).addClass('active');
            // Lưu section hiện tại vào localStorage
            localStorage.setItem('activeSection', $(this).data('section'));
        });

        window.showUpdateAddressModal = function(id, name, phone, addressLine, note, isDefault) {
            $('#addressId').val(id);
            $('#name').val(name);
            $('#phone').val(phone);
            $('#addressLine').val(addressLine);
            $('#note').val(note || '');
            $('#isDefault').prop('checked', isDefault);
            $('#updateAddressModal').addClass('show');
        };

        $('.address-card .btn-icon:not(.text-danger)').on('click', function() {
            const $addressCard = $(this).closest('.address-card');
            const id = $addressCard.data('address-id');
            const name = $addressCard.find('h4').text().replace('Địa chỉ mặc định', '').trim();
            const phone = $addressCard.find('p:eq(1)').text().replace('Điện thoại: ', '').trim();
            const addressLine = $addressCard.find('p:eq(0)').text();
            const note = $addressCard.find('p:contains("Ghi chú:")').text().replace('Ghi chú: ', '').trim() || '';
            const isDefault = $addressCard.hasClass('default');
            showUpdateAddressModal(id, name, phone, addressLine, note, isDefault);
        });

        $('.modal-close').click(function() {
            $(this).closest('.modal').removeClass('show');
        });

        $('#updateAddressForm').submit(function(e) {
            e.preventDefault();

            const id = $('#addressId').val();
            const name = $('#name').val();
            const phone = $('#phone').val();
            const addressLine = $('#addressLine').val();
            const note = $('#note').val();
            const isDefault = $('#isDefault').is(':checked');
            const userId = ${user.id};

            showToast('Đang xử lý cập nhật địa chỉ...', 'info');

            $.ajax({
                url: '${pageContext.request.contextPath}/capnhatdiachi',
                type: 'POST',
                data: {
                    id: id,
                    name: name,
                    phone: phone,
                    addressLine: addressLine,
                    note: note,
                    isDefault: isDefault,
                    userId: userId
                },
                success: function(response) {
                    if (response > 0) {
                        sessionStorage.setItem('addressUpdated', 'true');
                        window.location.reload();
                    } else {
                        showToast('Cập nhật địa chỉ thất bại', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    let errorMessage = xhr.responseText || error;
                    showToast('Lỗi khi cập nhật địa chỉ: ' + errorMessage, 'error');
                }
            });
        });

        // Hiển thị thông báo nếu vừa cập nhật địa chỉ
        if (sessionStorage.getItem('addressUpdated') === 'true') {
            showToast('Cập nhật địa chỉ thành công', 'success');
            sessionStorage.removeItem('addressUpdated');
        }
        
        window.saveAddress = function() {
            const name = $('#modalName').val();
            const phone = $('#modalPhone').val();
            const address = $('#modalAddress').val();
            const note = $('#modalNote').val();
            const userId = ${user.id};

            if (!name || !phone || !address) {
                showToast('Vui lòng điền đầy đủ thông tin bắt buộc!', 'error');
                return;
            }

            const addressData = {
                userId: parseInt(userId),
                name: name,
                phone: phone,
                addressLine: address,
                note: note
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/themdiachi',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(addressData),
                success: function(result) {
                    if (result > 0) {
                    	sessionStorage.setItem('addressAdded', 'true');
						location.reload();
                    } else {
                        showToast('Lưu địa chỉ thất bại.', 'error');
                    }
                },
                error: function() {
                    showToast('Lỗi khi lưu địa chỉ.', 'error');
                }
            });
        };
        
        // Hiển thị thông báo nếu vừa cập nhật địa chỉ
        if (sessionStorage.getItem('addressAdded') === 'true') {
            showToast('Thêm địa chỉ thành công', 'success');
            sessionStorage.removeItem('addressAdded');
        }


        $('.address-card .btn-icon.text-danger').on('click', function() {
            const $addressCard = $(this).closest('.address-card');
            const addressId = $addressCard.data('address-id');
            
            if (!addressId) {
                alert('Địa chỉ không tìm thấy.');
                return;
            }

            if (!confirm('Bạn có chắc muốn xóa địa chỉ này không?')) {
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/xoadiachi', 
                type: 'POST',
                data: { addressId: addressId },
                success: function(response) {
                    if (response > 0) {
                        $addressCard.remove();
                        showToast('Địa chỉ đã được xóa thành công.', 'success');
                    } else {
                        alert('Failed to delete address. It may not exist or is in use.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error deleting address:', error);
                    alert('An error occurred while deleting the address.');
                }
            });
        });
    });
    
    function showToast(message, type) {
        const toast = $('<div>').addClass(`toast ${type} show`).text(message);
        $('#toast').append(toast);
        setTimeout(() => {
            toast.removeClass('show');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }
    </script>
</body>
</html>