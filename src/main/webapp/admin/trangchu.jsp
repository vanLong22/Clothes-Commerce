<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang chủ</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* === RESET & BASE STYLES === */
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

/* === MAIN CONTAINER === */
.main-container {
	display: flex;
	height: 100%;
	width: 100%;
}

/* === MAIN CONTENT === */
.main-content {
	flex-grow: 1;
	padding: 30px;
	background-color: #f5f7fa;
}

.section-title {
	font-size: 1.8rem;
	color: var(--primary-dark);
	margin-bottom: 25px;
	font-weight: 600;
	padding-bottom: 15px;
	border-bottom: 2px solid var(--primary-light);
}

/* === STATS === */
.stats {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.stat-item {
	background: white;
	padding: 25px;
	border-radius: 15px;
	box-shadow: var(--card-shadow);
	display: flex;
	align-items: center;
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
}

.stat-item:hover {
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
	margin-right: 20px;
	font-size: 1.8rem;
	color: white;
}

.stat-icon.total {
	background: linear-gradient(135deg, #5c6bc0, #7986cb);
}

.stat-icon.products {
	background: linear-gradient(135deg, #4caf50, #66bb6a);
}

.stat-icon.users {
	background: linear-gradient(135deg, #ff9800, #ffa726);
}

.stat-icon.requests {
	background: linear-gradient(135deg, #f44336, #ef5350);
}

.stat-info {
	flex-grow: 1;
}

.stat-item span {
	display: block;
	font-size: 1rem;
	color: var(--gray);
	margin-bottom: 5px;
}

.stat-item h3 {
	font-size: 1.8rem;
	color: var(--dark);
	font-weight: 700;
}

/* === CONTENT SECTIONS === */
.content {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
	gap: 25px;
	margin-bottom: 30px;
}

/* === TABLES === */
.table-container {
	overflow-x: auto;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	min-width: 0; /* Loại bỏ min-width cố định */
}

table th {
	background: linear-gradient(to bottom, var(--primary),
		var(--primary-dark));
	color: white;
	padding: 12px 10px;
	text-align: left;
	font-weight: 500;
	font-size: 0.9rem;
}

table th:first-child {
	border-top-left-radius: 10px;
}

table th:last-child {
	border-top-right-radius: 10px;
}

table td {
	padding: 10px;
	border-bottom: 1px solid var(--border);
	background-color: white;
	font-size: 0.85rem;
}

table tr:last-child td {
	border-bottom: none;
}

table tr:last-child td:first-child {
	border-bottom-left-radius: 10px;
}

table tr:last-child td:last-child {
	border-bottom-right-radius: 10px;
}

table tr:hover td {
	background-color: #f8f9ff;
}

table td button {
	padding: 6px 12px;
	background: linear-gradient(to right, var(--primary),
		var(--primary-light));
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: all 0.3s ease;
	font-weight: 500;
	font-size: 0.8rem;
}

table td button:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(92, 107, 192, 0.3);
}

.status {
	padding: 5px 10px;
	border-radius: 20px;
	color: white;
	font-size: 0.8rem;
	font-weight: 500;
	display: inline-block;
}

.status.processing {
	background: linear-gradient(to right, #ff9800, #ffa726);
}

.status.completed {
	background: linear-gradient(to right, #4caf50, #66bb6a);
}

.status.cancelled {
	background: linear-gradient(to right, #f44336, #ef5350);
}

/* === BUTTONS === */
.more {
	background: linear-gradient(to right, var(--primary),
		var(--primary-light));
	color: white;
	padding: 8px 16px;
	border: none;
	border-radius: 8px;
	font-size: 0.9rem;
	cursor: pointer;
	transition: all 0.3s ease;
	font-weight: 500;
	display: inline-flex;
	align-items: center;
}

.more i {
	margin-left: 8px;
}

.more:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(92, 107, 192, 0.3);
}

/* === ANIMATIONS === */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.stat-item, .card {
	animation: fadeIn 0.5s ease forwards;
}

.stat-item:nth-child(2) {
	animation-delay: 0.1s;
}

.stat-item:nth-child(3) {
	animation-delay: 0.2s;
}

.stat-item:nth-child(4) {
	animation-delay: 0.3s;
}

.card:nth-child(1) {
	animation-delay: 0.2s;
}

.card:nth-child(2) {
	animation-delay: 0.3s;
}

/* === RESPONSIVE === */
@media ( max-width : 1400px) {
	.content {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 992px) {
	.main-content {
		padding: 20px 15px;
	}
	.stats {
		grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
	}
	table th, table td {
		padding: 8px;
		font-size: 0.8rem;
	}
}

@media ( max-width : 768px) {
	.stats {
		grid-template-columns: 1fr;
	}
	.section-title {
		font-size: 1.5rem;
	}
	/* Ẩn một số cột trong bảng để tránh tràn */
	table th:nth-child(4), table td:nth-child(4), table th:nth-child(5),
		table td:nth-child(5) {
		display: none;
	}
}

@media ( max-width : 576px) {
	.header h1 {
		font-size: 1.3rem;
	}
	.stat-icon {
		width: 50px;
		height: 50px;
		font-size: 1.5rem;
	}
	.stat-item h3 {
		font-size: 1.5rem;
	}
}
</style>
<script>
        document.addEventListener('DOMContentLoaded', () => {
            // Dropdown toggle functionality
            document.querySelectorAll('.sidebar .dropdown-toggle').forEach(link => {
                link.addEventListener('click', function(event) {
                    event.preventDefault();
                    const parentLi = this.parentElement;
                    parentLi.classList.toggle('open');
                    
                    // Close other dropdowns
                    document.querySelectorAll('.sidebar .dropdown').forEach(li => {
                        if (li !== parentLi) {
                            li.classList.remove('open');
                        }
                    });
                });
            });

            // Active state for sidebar items
            const sidebarLinks = document.querySelectorAll('.sidebar ul li a, .sidebar ul li button');
            sidebarLinks.forEach(link => {
                link.addEventListener('click', function() {
                    sidebarLinks.forEach(l => l.parentElement.classList.remove('active'));
                    this.parentElement.classList.add('active');
                    
                    const parentLi = this.closest('.dropdown');
                    if (parentLi) {
                        parentLi.querySelectorAll('ul li').forEach(sibling => {
                            if (sibling !== this.parentElement) {
                                sibling.classList.remove('active');
                            }
                        });
                    }
                });
            });
            
            // Add animation to stat items
            const statItems = document.querySelectorAll('.stat-item');
            statItems.forEach((item, index) => {
                item.style.animationDelay = `${index * 0.1}s`;
            });
        });
    </script>
</head>
<body>
	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Main Container -->
	<div class="main-container">
		<!-- Sidebar -->
		<jsp:include page="sidebar.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="main-content">
			<h1 class="section-title">Bảng điều khiển</h1>

			<div class="stats">
				<div class="stat-item">
					<div class="stat-icon total">
						<i class="fas fa-wallet"></i>
					</div>
					<div class="stat-info">
						<span>Tổng Doanh Thu</span>
						<h3>
							<fmt:formatNumber value="${totalRevenue}" type="currency"
								currencySymbol="đ" groupingUsed="true" maxFractionDigits="0" />
						</h3>
					</div>
				</div>
				<div class="stat-item">
					<div class="stat-icon products">
						<i class="fas fa-boxes"></i>
					</div>
					<div class="stat-info">
						<span>Số Lượng Sản Phẩm</span>
						<h3>${totalProduct}</h3>
					</div>
				</div>
				<div class="stat-item">
					<div class="stat-icon users">
						<i class="fas fa-users"></i>
					</div>
					<div class="stat-info">
						<span>Số Lượng Người Dùng</span>
						<h3>${totalUser}</h3>
					</div>
				</div>
				<div class="stat-item">
					<div class="stat-icon requests">
						<i class="fas fa-tasks"></i>
					</div>
					<div class="stat-info">
						<span>Yêu Cầu Đang Xử Lý</span>
						<h3>${totalOrder}</h3>
					</div>
				</div>
			</div>

			<div class="content">
				<div class="card">
					<div class="card-header">
						<h2 class="card-title">Sản phẩm mới</h2>
					</div>
					<div class="table-container">
						<table>
							<thead>
								<tr>
									<th>Sản Phẩm</th>
									<th>Giá</th>
									<th>Tình trạng</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="productCount" value="0" />
								<c:forEach var="product" items="${allProducts}">
									<c:if test="${productCount < 10}">
										<tr>
											<td><c:out value="${product.name}" /></td>
											<td><fmt:formatNumber value="${product.price}"
													type="currency" currencySymbol="đ" groupingUsed="true"
													maxFractionDigits="0" /></td>
											<td><span
												class="status ${product.quantity > 10 ? 'completed' : 'processing'}">
													${product.quantity > 10 ? 'Còn hàng' : 'Sắp hết'} </span></td>
										</tr>
										<c:set var="productCount" value="${productCount + 1}" />
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<form
						action="${pageContext.request.contextPath}/admin/danhsachsanpham"
						method="get" style="margin-top: 20px; text-align: right;">
						<button class="more" name="xemthemsanpham">
							Xem thêm <i class="fas fa-arrow-right"></i>
						</button>
					</form>
				</div>

				<div class="card">
					<div class="card-header">
						<h2 class="card-title">Hóa Đơn mới</h2>
					</div>
					<div class="table-container">
						<table>
							<thead>
								<tr>
									<th>STT</th>
									<th>Khách Hàng</th>
									<th>Tổng Tiền</th>
									<th>Trạng Thái</th>
									<th>Thực Hiện</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty allOrders}">
										<c:forEach var="invoice" items="${allOrders}" varStatus="loop">
											<tr>
												<td>${loop.index + 1}</td>
												<td>#HD<c:out value="${invoice.id}" /></td>
												<td><fmt:formatNumber value="${invoice.totalPrice}"
														type="currency" currencySymbol="đ" groupingUsed="true"
														maxFractionDigits="0" /></td>
												<td><span class="status processing"> Đang xử lý
												</span></td>
												<td>
													<button>
														<i class="fas fa-eye"></i> Chi tiết
													</button>
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" style="text-align: center; padding: 30px;">
												Không có hóa đơn nào</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<form action="${pageContext.request.contextPath}/admin/hoadon"
						method="get" style="margin-top: 20px; text-align: right;">
						<button class="more" name="xemthemhoadon">
							Xem thêm <i class="fas fa-arrow-right"></i>
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>


