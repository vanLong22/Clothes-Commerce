<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý Hóa Đơn - Shop Thời Trang</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
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

body {
	background-color: #f5f7fa;
	color: var(--dark);
	display: flex;
	height: 100vh;
	overflow: hidden;
	flex-direction: column;
}

.dashboard {
	display: flex;
	flex: 1;
}

.main-content {
	flex: 1;
	padding: 25px;
	display: flex;
	flex-direction: column;
	gap: 25px;
}

.stats-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	gap: 20px;
}

.stat-card {
	background: white;
	border-radius: 16px;
	padding: 24px;
	box-shadow: var(--card-shadow);
	display: flex;
	align-items: center;
	gap: 16px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.stat-card:hover {
	transform: translateY(-5px);
	box-shadow: var(--hover-shadow);
}

.stat-icon {
	width: 60px;
	height: 60px;
	border-radius: 14px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
}

.stat-icon.primary {
	background: rgba(67, 97, 238, 0.15);
	color: var(--primary);
}

.stat-icon.success {
	background: rgba(76, 201, 240, 0.15);
	color: var(--success-dark);
}

.stat-icon.warning {
	background: rgba(247, 37, 133, 0.15);
	color: var(--warning);
}

.stat-info {
	flex: 1;
}

.stat-title {
	font-size: 15px;
	color: var(--gray);
	margin-bottom: 6px;
}

.stat-value {
	font-size: 26px;
	font-weight: 700;
	color: var(--dark);
}

.table-container {
	background: white;
	border-radius: 16px;
	box-shadow: var(--card-shadow);
	padding: 32px;
	flex: 1;
}

.table-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
	flex-wrap: wrap;
	gap: 15px;
}

.section-title {
	font-size: 22px;
	font-weight: 700;
	color: var(--dark);
}

.search-bar {
	display: flex;
	background: var(--light);
	border-radius: 12px;
	overflow: hidden;
	width: 350px;
	max-width: 100%;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.search-bar input {
	flex: 1;
	padding: 14px 20px;
	border: none;
	background: transparent;
	font-size: 15px;
}

.search-bar button {
	background: var(--primary);
	color: white;
	border: none;
	padding: 0 24px;
	cursor: pointer;
	font-weight: 500;
	transition: background 0.3s ease;
}

.search-bar button:hover {
	background: var(--secondary);
}

.table-wrapper {
	overflow-x: auto;
	border-radius: 12px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.04);
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	min-width: 1000px;
}

thead {
	background: var(--light);
}

th {
	padding: 16px 20px;
	text-align: left;
	font-weight: 600;
	color: var(--gray);
	font-size: 14px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

tbody tr {
	transition: background 0.2s ease;
	border-bottom: 1px solid var(--border);
}

tbody tr:hover {
	background: rgba(67, 97, 238, 0.03);
}

td {
	padding: 18px 20px;
	border-bottom: 1px solid var(--border);
	color: var(--dark);
	font-size: 15px;
}

.status-badge {
	display: inline-block;
	padding: 8px 14px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 500;
}

.status-processing {
	background: rgba(67, 97, 238, 0.15);
	color: var(--primary);
}

.status-delivered {
	background: rgba(76, 201, 240, 0.15);
	color: var(--success-dark);
}

.status-pending {
	background: rgba(255, 193, 7, 0.15);
	color: #ff9800;
}

.status-cancelled {
	background: rgba(220, 53, 69, 0.15);
	color: #dc3545;
}

.actions {
	display: flex;
	gap: 8px;
}

.action-btn {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: all 0.2s ease;
	border: none;
	font-size: 16px;
}

.action-btn:hover {
	transform: translateY(-2px);
}

.edit-btn {
	background: rgba(67, 97, 238, 0.15);
	color: var(--primary);
}

.edit-btn:hover {
	background: rgba(67, 97, 238, 0.25);
}

.delete-btn {
	background: rgba(220, 53, 69, 0.15);
	color: #dc3545;
}

.delete-btn:hover {
	background: rgba(220, 53, 69, 0.25);
}

.view-btn {
	background: rgba(40, 167, 69, 0.15);
	color: #28a745;
}

.view-btn:hover {
	background: rgba(40, 167, 69, 0.25);
}

/* Pagination Styles */
.pagination {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.pagination a {
	padding: 8px 16px;
	text-decoration: none;
	color: var(--primary);
	border: 1px solid var(--border);
	border-radius: 5px;
}

.pagination a.active {
	background: var(--primary);
	color: white;
}

/* Modal Styles */
.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	z-index: 1000;
	animation: fadeIn 0.3s ease;
}

.modal-content {
	background: white;
	border-radius: 16px;
	width: 500px;
	max-width: 90%;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
	animation: slideDown 0.3s ease;
}

.modal-header {
	padding: 20px 25px;
	border-bottom: 1px solid var(--border);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.modal-header h3 {
	font-size: 20px;
	font-weight: 600;
}

.modal-header .close {
	background: none;
	border: none;
	font-size: 24px;
	cursor: pointer;
	color: var(--gray);
}

.modal-body {
	padding: 25px;
}

.info-row {
	display: flex;
	margin-bottom: 15px;
}

.info-row div:first-child {
	flex: 1;
	font-weight: 500;
	color: var(--gray);
}

.info-row div:last-child {
	flex: 2;
}

.modal-footer {
	padding: 15px 25px;
	border-top: 1px solid var(--border);
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.modal-footer button {
	padding: 10px 20px;
	border-radius: 10px;
	cursor: pointer;
	font-weight: 500;
	border: none;
	transition: background 0.2s ease;
}

.btn-cancel {
	background: var(--light-gray);
	color: var(--dark);
}

.btn-confirm {
	background: var(--primary);
	color: white;
}

.btn-danger {
	background: var(--danger);
	color: white;
}

#deleteModal .modal-content {
	width: 400px;
	text-align: center;
}

#deleteModal .modal-body i {
	font-size: 48px;
	color: var(--danger);
	margin-bottom: 15px;
}

#deleteModal .modal-body p {
	font-size: 16px;
	line-height: 1.5;
	margin-bottom: 20px;
}

#deleteModal .modal-footer {
	justify-content: center;
}

#editModal .modal-content {
	width: 450px;
}

#editModal select {
	width: 100%;
	padding: 12px;
	border-radius: 10px;
	border: 1px solid var(--border);
	font-size: 15px;
}

/* Animation */
@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes slideDown {from { transform:translateY(-50px);
	opacity: 0;
}

to {
	transform: translateY(0);
	opacity: 1;
}

}
@media ( max-width : 1200px) {
	.dashboard {
		flex-direction: column;
	}
	.search-bar {
		width: 100%;
	}
	.table-header {
		flex-direction: column;
		align-items: flex-start;
	}
}

@media ( max-width : 768px) {
	.stats-container {
		grid-template-columns: 1fr;
	}
	.stat-card {
		flex-direction: column;
		text-align: center;
	}
	.table-container {
		padding: 20px;
	}
}

@media ( max-width : 480px) {
	.modal-content {
		width: 95% !important;
	}
	.modal-footer {
		flex-direction: column;
		gap: 10px;
	}
	.modal-footer button {
		width: 100%;
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
	<jsp:include page="header.jsp"></jsp:include>

	<div class="dashboard">
		<jsp:include page="sidebar.jsp"></jsp:include>

		<div class="main-content">
			<div class="stats-container">
				<div class="stat-card">
					<div class="stat-icon primary">
						<i class="fas fa-file-invoice-dollar"></i>
					</div>
					<div class="stat-info">
						<div class="stat-title">Tổng hóa đơn</div>
						<div class="stat-value">${totalInvoices}</div>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon success">
						<i class="fas fa-check-circle"></i>
					</div>
					<div class="stat-info">
						<div class="stat-title">Đã hoàn thành</div>
						<div class="stat-value">${completedInvoices}</div>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon warning">
						<i class="fas fa-sync-alt"></i>
					</div>
					<div class="stat-info">
						<div class="stat-title">Đang xử lý</div>
						<div class="stat-value">${processingInvoices}</div>
					</div>
				</div>
				<div class="stat-card">
					<div class="stat-icon primary">
						<i class="fas fa-money-bill-wave"></i>
					</div>
					<div class="stat-info">
						<div class="stat-title">Tổng doanh thu</div>
						<div class="stat-value">
							<fmt:formatNumber value="${totalRevenue}" type="number"
								groupingUsed="true" />
							₫
						</div>
					</div>
				</div>
			</div>

			<div class="table-container">
				<div class="table-header">
					<h2 class="section-title">Danh sách hóa đơn</h2>
					<form action="${pageContext.request.contextPath}/admin/hoadon"
						method="get" class="search-bar">
						<input type="text" name="search"
							placeholder="Tìm kiếm hóa đơn, khách hàng..." value="${search}">
						<button type="submit">
							<i class="fas fa-search"></i>
						</button>
					</form>
				</div>

				<div class="table-wrapper">
					<table>
						<thead>
							<tr>
								<th>Mã HD</th>
								<th>Khách hàng</th>
								<th>Số điện thoại</th>
								<th>Tổng tiền</th>
								<th>Ngày tạo</th>
								<th>Trạng thái</th>
								<th>Thao tác</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="order" items="${orders}">
				                <c:set var="od" value="${order.orderDetails[0]}" /> <!-- Lấy orderDetail đầu tiên -->
				                <c:if test="${not empty od}"> <!-- Kiểm tra nếu có orderDetail -->
				                    <tr data-order-id="${order.id}">
			                        	<td>#HD${order.id}</td>
										<td>${order.name}</td>
										<td>${order.phone}</td>
										<td>${order.totalPrice}₫</td>
										<td><fmt:formatDate value="${order.createdAtAsDate}" pattern="dd/MM/yyyy"/></td>
				                        <td>
				                            <c:choose>
				                                <c:when test="${order.status == 'processing'}">
				                                    <span class="status-badge status-processing">Đang xử lý</span>
				                                </c:when>
				                                <c:when test="${order.status == 'delivered'}">
				                                    <span class="status-badge status-delivered">Đã giao hàng</span>
				                                </c:when>
				                                <c:when test="${order.status == 'pending'}">
				                                    <span class="status-badge status-pending">Chờ xác nhận</span>
				                                </c:when>
				                                <c:when test="${order.status == 'cancelled'}">
				                                    <span class="status-badge status-cancelled">Đã hủy</span>
				                                </c:when>
				                                <c:otherwise>
				                                    <span class="status-badge">${order.status}</span>
				                                </c:otherwise>
				                            </c:choose>
				                        </td>
				                        <td class="actions">
				                            <button class="action-btn view-btn"
													onclick="openViewModal('${order.id}', '${order.name}', '${order.phone}', '${order.totalPrice}', '${od.productName }', '${od.quantity }', '${od.color }', '${od.size }', '${order.createdAtAsDate}', '${order.status}' )">
				                                <i class="fas fa-eye"></i>
				                            </button>
				                            <button class="action-btn edit-btn" onclick="openEditModal('${order.id}', '${order.status}')">
				                                <i class="fas fa-edit"></i>
				                            </button>
				                            <button class="action-btn delete-btn" onclick="openDeleteModal('${order.id}')">
				                                <i class="fas fa-trash"></i>
				                            </button>
				                        </td>
				                    </tr>
				                </c:if>
				            </c:forEach>
						</tbody>
					</table>
				</div>

				<!-- Pagination -->
				<div class="pagination">
					<c:if test="${currentPage > 1}">
						<a
							href="${pageContext.request.contextPath}/admin/hoadon?page=${currentPage - 1}&search=${search}">Previous</a>
					</c:if>
					<c:forEach var="i" begin="1" end="${totalPages}">
						<a
							href="${pageContext.request.contextPath}/admin/hoadon?page=${i}&search=${search}"
							<c:if test="${i == currentPage}">class="active"</c:if>>${i}</a>
					</c:forEach>
					<c:if test="${currentPage < totalPages}">
						<a
							href="${pageContext.request.contextPath}/admin/hoadon?page=${currentPage + 1}&search=${search}">Next</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	
	<!-- View Order Modal -->
	<div id="viewModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h3>Chi tiết hóa đơn</h3>
				<button class="close" onclick="closeViewModal()">&times;</button>
			</div>
			<div class="modal-body">
				<div class="info-row">
					<div>Mã HD:</div>
					<div id="orderId"></div>
				</div>
				<div class="info-row">
					<div>Khách hàng:</div>
					<div id="customerName"></div>
				</div>
				<div class="info-row">
					<div>SĐT:</div>
					<div id="phone"></div>
				</div>
				<div class="info-row">
					<div>Tổng tiền:</div>
					<div id="totalPrice"></div>
				</div>
				<div class="info-row">
					<div>Tên sản phẩm:</div>
					<div id="productName"></div>
				</div>
				<div class="info-row">
					<div>Số lượng:</div>
					<div id="quantity"></div>
				</div>
				<div class="info-row">
					<div>Màu sắc:</div>
					<div id="color"></div>
				</div>
				<div class="info-row">
					<div>Kích thước:</div>
					<div id="size"></div>
				</div>
				<div class="info-row">
					<div>Ngày tạo:</div>
					<div id="createdAt"></div>
				</div>
				<div class="info-row">
					<div>Trạng thái:</div>
					<div><span class="status-badge" id="status"></span></div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn-cancel" onclick="closeViewModal()">Đóng</button>
			</div>
		</div>
	</div>
	
	<!-- Edit Status Modal -->
	<div id="editModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h3>Cập nhật trạng thái</h3>
				<button class="close" onclick="closeEditModal()">&times;</button>
			</div>
			<form id="editForm" action="${pageContext.request.contextPath}/admin/hoadon/update" method="POST">
				<div class="modal-body">
					<input type="hidden" name="id" id="editOrderId">
					<div>
						<label>Trạng thái mới</label>
						<select name="status" id="editStatus">
							<option value="pending">Chờ xác nhận</option>
							<option value="processing">Đang xử lý</option>
							<option value="delivered">Đã giao hàng</option>
							<option value="cancelled">Đã hủy</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-cancel" onclick="closeEditModal()">Hủy</button>
					<button type="submit" class="btn-confirm">Cập nhật</button>
				</div>
			</form>
		</div>
	</div>
	
	<!-- Delete Confirmation Modal -->
	<div id="deleteModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<h3>Xác nhận xóa</h3>
				<button class="close" onclick="closeDeleteModal()">&times;</button>
			</div>
			<div class="modal-body">
				<i class="fas fa-exclamation-circle"></i>
				<p>
					Bạn có chắc chắn muốn xóa hóa đơn 
					<span id="deleteOrderId" style="font-weight:600;"></span>?
					<br>Thao tác này không thể hoàn tác!
				</p>
			</div>
			<div class="modal-footer">
				<button class="btn-cancel" onclick="closeDeleteModal()">Hủy</button>
				<button id="confirmDelete" class="btn-danger">Xóa</button>
			</div>
		</div>
	</div>
	
	<!--notification container -->
    <div id="toast"></div>

	<script>
		// View Modal Functions
		function openViewModal(id, name, phone, totalPrice, productName, quantity, color, size, createdAt, status) {
			document.getElementById('orderId').textContent = '#HD' + id;
			document.getElementById('customerName').textContent = name;
			document.getElementById('phone').textContent = phone;
			document.getElementById('totalPrice').textContent = totalPrice + 'đ';
			document.getElementById('productName').textContent = productName;
			document.getElementById('quantity').textContent = quantity;
			document.getElementById('color').textContent = color;
			document.getElementById('size').textContent = size;
			document.getElementById('createdAt').textContent = createdAt;
			
			// Update status text and style
			const statusElement = document.getElementById('status');
			statusElement.textContent = getStatusText(status);
			statusElement.className = 'status-badge ' + getStatusClass(status);
			
			document.getElementById('viewModal').style.display = 'flex';
		}

		function closeViewModal() {
			document.getElementById('viewModal').style.display = 'none';
		}
		
		// Edit Modal Functions
		function openEditModal(id, status) {
			document.getElementById('editOrderId').value = id;
			document.getElementById('editStatus').value = status;
			document.getElementById('editModal').style.display = 'flex';
		}

		function closeEditModal() {
			document.getElementById('editModal').style.display = 'none';
		}
		
		// Delete Modal Functions
		function openDeleteModal(id) {
			document.getElementById('deleteOrderId').textContent = '#HD' + id;
			document.getElementById('confirmDelete').onclick = function() {
				window.location.href = '${pageContext.request.contextPath}/admin/hoadon/delete?id=' + id;
			};
			document.getElementById('deleteModal').style.display = 'flex';
		}

		function closeDeleteModal() {
			document.getElementById('deleteModal').style.display = 'none';
		}
		
		// Helper functions for status
		function getStatusText(status) {
			switch(status) {
				case 'processing': return 'Đang xử lý';
				case 'delivered': return 'Đã giao hàng';
				case 'pending': return 'Chờ xác nhận';
				case 'cancelled': return 'Đã hủy';
				default: return status;
			}
		}
		
		function getStatusClass(status) {
			switch(status) {
				case 'processing': return 'status-processing';
				case 'delivered': return 'status-delivered';
				case 'pending': return 'status-pending';
				case 'cancelled': return 'status-cancelled';
				default: return '';
			}
		}
		
		// Close modals when clicking outside
		document.querySelectorAll('.modal').forEach(modal => {
			modal.addEventListener('click', function(event) {
				if (event.target === this) {
					this.style.display = 'none';
				}
			});
		});
		
		// Submit Edit Form
	    $('#editForm').submit(function(e) {
	        e.preventDefault();
	        
	        const orderId = $('#editOrderId').val();
	        const status = $('#editStatus').val();
	        
	        $.ajax({
	            url: '${pageContext.request.contextPath}/admin/hoadon/update',
	            type: 'POST',
	            data: { id: orderId, status: status },
	            success: function(response) {
	            	sessionStorage.setItem('orderUpdated', 'true');
                    location.reload();
	            },
	            error: function(xhr) {
	                alert('Lỗi khi cập nhật trạng thái: ' + (xhr.responseJSON?.error || 'Lỗi không xác định'));
	            }
	        });
	    });
		
		// Hiển thị thông báo nếu vừa cập nhật thông tin hóa đơn
        if (sessionStorage.getItem('orderUpdated') === 'true') {
            showToast('Cập nhật hóa đơn thành công.', 'success');
            sessionStorage.removeItem('orderUpdated');
        }

	    // Delete Modal
	    $('.delete-btn').click(function() {
	        const orderId = $(this).closest('tr').data('order-id');
	        $('#deleteOrderId').text('#HD' + orderId);
	        
	        $('#confirmDelete').off('click').click(function() {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/admin/hoadon/delete',
	                type: 'POST',
	                data: { id: orderId },
	                success: function(response) {
	                	sessionStorage.setItem('orderDeleted', 'true');
	                    location.reload();
	            	},
	                error: function(xhr) {
	                    alert('Lỗi khi xóa hóa đơn: ' + (xhr.responseJSON?.error || 'Lỗi không xác định'));
	                }
	            });
	        });
	        
	        $('#deleteModal').css('display', 'flex');
	    });
	    
	 	// Hiển thị thông báo nếu vừa xóa hóa đơn
        if (sessionStorage.getItem('orderDeleted') === 'true') {
            showToast('Xóa hóa đơn thành công.', 'success');
            sessionStorage.removeItem('orderDeleted');
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