<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fashion Shop - Thống Kê</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
/* Phần CSS chung giữ nguyên từ giao diện trước */
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
	gap: 40px;
	width: 100%;
	flex: 1;
}

/* Main Content Styles */
.main-content {
	display: flex;
	flex-direction: column;
	gap: 25px;
	padding: 20px;
}

/* Header */
.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.page-title {
	font-size: 1.8rem;
	color: var(--primary);
	font-weight: 600;
}

.date-filter {
	display: flex;
	gap: 15px;
	align-items: center;
}

.date-filter select {
	padding: 10px 15px;
	border: 2px solid var(--light-gray);
	border-radius: 8px;
	background: white;
	font-size: 1rem;
	cursor: pointer;
}

/* Stats Cards */
.stats-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	margin-bottom: 25px;
}

.stat-card {
	background: white;
	border-radius: 12px;
	padding: 25px;
	box-shadow: var(--card-shadow);
	display: flex;
	flex-direction: column;
	transition: var(--transition);
	position: relative;
	overflow: hidden;
}

.stat-card:hover {
	transform: translateY(-5px);
	box-shadow: var(--hover-shadow);
}

.stat-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 5px;
	height: 100%;
	background: var(--primary);
}

.stat-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.stat-title {
	font-size: 1rem;
	color: var(--gray);
	font-weight: 500;
}

.stat-icon {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.5rem;
	color: white;
	background: var(--primary);
}

.stat-value {
	font-size: 1.8rem;
	font-weight: 700;
	margin-bottom: 5px;
}

.stat-trend {
	display: flex;
	align-items: center;
	font-size: 0.9rem;
}

.trend-up {
	color: var(--success);
}

.trend-down {
	color: var(--danger);
}

/* Charts Container */
.charts-container {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 25px;
	margin-bottom: 25px;
}

@media ( max-width : 992px) {
	.charts-container {
		grid-template-columns: 1fr;
	}
}

.chart-card {
	background: white;
	border-radius: 12px;
	padding: 25px;
	box-shadow: var(--card-shadow);
}

.chart-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.chart-title {
	font-size: 1.2rem;
	font-weight: 600;
	color: var(--dark);
}

.chart-actions {
	display: flex;
	gap: 10px;
}

.chart-action-btn {
	background: var(--light);
	border: none;
	border-radius: 6px;
	padding: 8px 12px;
	font-size: 0.9rem;
	cursor: pointer;
	transition: var(--transition);
}

.chart-action-btn:hover {
	background: var(--primary-light);
	color: white;
}

.chart-wrapper {
	position: relative;
	height: 300px;
}

/* Recent Orders */
.recent-orders {
	background: white;
	border-radius: 12px;
	padding: 25px;
	box-shadow: var(--card-shadow);
}

.recent-orders-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.recent-orders-title {
	font-size: 1.2rem;
	font-weight: 600;
	color: var(--dark);
}

.view-all-btn {
	background: var(--primary);
	color: white;
	border: none;
	border-radius: 8px;
	padding: 8px 16px;
	font-weight: 500;
	cursor: pointer;
	transition: var(--transition);
	display: flex;
	align-items: center;
	gap: 8px;
}

.view-all-btn:hover {
	background: var(--primary-dark);
	transform: translateY(-2px);
}

.orders-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
}

.orders-table th {
	padding: 12px 15px;
	text-align: left;
	font-weight: 600;
	color: var(--gray);
	border-bottom: 2px solid var(--light-gray);
}

.orders-table td {
	padding: 15px;
	border-bottom: 1px solid var(--light-gray);
}

.order-status {
	display: inline-block;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 500;
}

.status-pending {
	background: rgba(255, 152, 0, 0.15);
	color: var(--warning);
}

.status-shipping {
	background: rgba(33, 150, 243, 0.15);
	color: #2196f3;
}

.status-delivered {
	background: rgba(76, 175, 80, 0.15);
	color: var(--success);
}

.status-cancelled {
	background: rgba(244, 67, 54, 0.15);
	color: var(--danger);
}

/* Responsive Design */
@media ( max-width : 992px) {
	.layout {
		grid-template-columns: 80px 1fr;
		gap: 20px;
	}
}

@media ( max-width : 768px) {
	.layout {
		grid-template-columns: 1fr;
		gap: 20px;
	}
	.charts-container {
		grid-template-columns: 1fr;
	}
	.stats-container {
		grid-template-columns: 1fr;
	}
	.date-filter {
		flex-direction: column;
		align-items: flex-start;
	}
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
				<!-- Page Header -->
				<div class="page-header">
					<h1 class="page-title">Bảng điều khiển thống kê</h1>
					<div class="date-filter">
						<span>Xem theo:</span> <select id="timeFilter">
							<option value="today">Hôm nay</option>
							<option value="week">Tuần này</option>
							<option value="month" selected>Tháng này</option>
							<option value="quarter">Quý này</option>
							<option value="year">Năm nay</option>
							<option value="custom">Tùy chỉnh</option>
						</select>
					</div>
				</div>

				<!-- Stats Cards -->
				<div class="stats-container">
					<div class="stat-card">
						<div class="stat-header">
							<span class="stat-title">Tổng doanh thu</span>
							<div class="stat-icon">
								<i class="fas fa-money-bill-wave"></i>
							</div>
						</div>
						<div class="stat-value">
							<fmt:formatNumber value="${totalRevenue}" type="currency"
								currencySymbol="₫" maxFractionDigits="0" />
						</div>
						<div class="stat-trend trend-up">
							<i class="fas fa-arrow-up"></i> <span>12.5% so với tháng
								trước</span>
						</div>
					</div>

					<div class="stat-card">
						<div class="stat-header">
							<span class="stat-title">Tổng đơn hàng</span>
							<div class="stat-icon">
								<i class="fas fa-shopping-bag"></i>
							</div>
						</div>
						<div class="stat-value">${totalOrders}</div>
						<div class="stat-trend trend-up">
							<i class="fas fa-arrow-up"></i> <span>8.2% so với tháng
								trước</span>
						</div>
					</div>

					<div class="stat-card">
						<div class="stat-header">
							<span class="stat-title">Khách hàng mới</span>
							<div class="stat-icon">
								<i class="fas fa-user-plus"></i>
							</div>
						</div>
						<div class="stat-value">${newCustomers}</div>
						<div class="stat-trend trend-up">
							<i class="fas fa-arrow-up"></i> <span>5.3% so với tháng
								trước</span>
						</div>
					</div>

					<div class="stat-card">
						<div class="stat-header">
							<span class="stat-title">Tỷ lệ hoàn thành</span>
							<div class="stat-icon">
								<i class="fas fa-check-circle"></i>
							</div>
						</div>
						<div class="stat-value">
							<fmt:formatNumber value="${completionRate}" type="number"
								maxFractionDigits="1" />
							%
						</div>
						<div class="stat-trend trend-down">
							<i class="fas fa-arrow-down"></i> <span>1.2% so với tháng
								trước</span>
						</div>
					</div>
				</div>

				<!-- Charts Container -->
				<div class="charts-container">
					<!-- Revenue Chart -->
					<div class="chart-card">
						<div class="chart-header">
							<h3 class="chart-title">Doanh thu theo tháng</h3>
							<div class="chart-actions">
							    <button class="chart-action-btn" data-range="day">Ngày</button>
							    <button class="chart-action-btn" data-range="week">Tuần</button>
							    <button class="chart-action-btn active" data-range="month">Tháng</button>
							    <button class="chart-action-btn" data-range="quarter">Quý</button>
							    <button class="chart-action-btn" data-range="year">Năm</button>
							</div>
						</div>
						<div class="chart-wrapper">
							<canvas id="revenueChart"></canvas>
						</div>
					</div>

					<!-- Order Status Chart -->
					<div class="chart-card">
						<div class="chart-header">
							<h3 class="chart-title">Phân phối đơn hàng</h3>
						</div>
						<div class="chart-wrapper">
							<canvas id="orderStatusChart"></canvas>
						</div>
					</div>
				</div>

				<!-- Top Products Chart -->
				<div class="chart-card">
					<div class="chart-header">
						<h3 class="chart-title">Top sản phẩm bán chạy</h3>
					</div>
					<div class="chart-wrapper">
						<canvas id="topProductsChart"></canvas>
					</div>
				</div>

				<!-- Recent Orders -->
				<div class="recent-orders">
					<div class="recent-orders-header">
						<h3 class="recent-orders-title">Đơn hàng gần đây</h3>
						<button class="view-all-btn">
							<i class="fas fa-list"></i> Xem tất cả
						</button>
					</div>
					<table class="orders-table">
						<thead>
							<tr>
								<th>Mã đơn hàng</th>
								<th>Khách hàng</th>
								<th>Ngày đặt</th>
								<th>Tổng tiền</th>
								<th>Trạng thái</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="order" items="${recentOrders}">
								<tr>
									<td>#DH-${order.id}</td>
									<td>${order.name}</td>
									<td><fmt:formatDate value="${order.createdAtAsDate}" pattern="dd/MM/yyyy"/></td>
									<td><fmt:formatNumber value="${order.totalPrice}"
											type="currency" currencySymbol="₫" maxFractionDigits="0" /></td>
									<td><c:choose>
											<c:when test="${order.status == 'delivered'}">
												<span class="order-status status-delivered">Đã giao</span>
											</c:when>
											<c:when test="${order.status == 'shipping'}">
												<span class="order-status status-shipping">Đang giao</span>
											</c:when>
											<c:when test="${order.status == 'pending'}">
												<span class="order-status status-pending">Chờ xử lý</span>
											</c:when>
											<c:when test="${order.status == 'cancelled'}">
												<span class="order-status status-cancelled">Đã hủy</span>
											</c:when>
											<c:otherwise>
												<span class="order-status">${order.status}</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script>
 		// Doanh thu theo tháng
	    const monthlyRevenueData = ${monthlyRevenueJson}; // Giả định truyền JSON từ controller
	    const revenueLabels = monthlyRevenueData.map(item => 'Tháng ' + item.month);
	    const revenueValues = monthlyRevenueData.map(item => item.revenue / 1000000); // Chuyển về triệu ₫
	
	    const revenueChart = new Chart(document.getElementById('revenueChart').getContext('2d'), {
	        type: 'line',
	        data: {
	            labels: revenueLabels,
	            datasets: [{
	                label: 'Doanh thu (triệu ₫)',
	                data: revenueValues,
	                backgroundColor: 'rgba(92, 107, 192, 0.1)',
	                borderColor: 'rgba(92, 107, 192, 1)',
	                borderWidth: 3,
	                pointBackgroundColor: 'rgba(92, 107, 192, 1)',
	                pointRadius: 5,
	                tension: 0.3
	            }]
	        },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `Doanh thu: \${context.parsed.y.toLocaleString()} triệu ₫`;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            callback: function(value) {
                                return value + ' triệu ₫';
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

	 	// Phân phối trạng thái đơn hàng
	    const statusData = ${orderStatusDistributionJson}; // Giả định truyền JSON
	    const statusLabels = statusData.map(item => item.status);
	    const statusValues = statusData.map(item => item.count);

	    const orderStatusChart = new Chart(document.getElementById('orderStatusChart').getContext('2d'), {
	        type: 'doughnut',
	        data: {
	            labels: statusLabels,
	            datasets: [{
	                data: statusValues,
	                backgroundColor: [
	                    'rgba(76, 175, 80, 0.8)',  // Đã giao
	                    'rgba(33, 150, 243, 0.8)', // Đang giao
	                    'rgba(255, 152, 0, 0.8)',  // Chờ xử lý
	                    'rgba(244, 67, 54, 0.8)'   // Đã hủy
	                ],
	                borderWidth: 1
	            }]
	        },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            boxWidth: 15,
                            padding: 20
                        }
                    },
                    tooltip: {
                        callbacks: {
                        	label: function(context) {
                        	    const total = context.dataset.data.reduce((a, b) => a + b, 0);
                        	    const percentage = ((context.raw / total) * 100).toFixed(1);
                        	    return `${context.label}: ${percentage}%`;
                        	}
                        }
                    }
                },
                cutout: '65%'
            }
        });

	 	// Top sản phẩm bán chạy
	    const topProductsData = ${topProductsJson}; // Giả định truyền JSON
	    const productLabels = topProductsData.map(item => item.name);
	    const productValues = topProductsData.map(item => item.totalQuantity);

	    const topProductsChart = new Chart(document.getElementById('topProductsChart').getContext('2d'), {
	        type: 'bar',
	        data: {
	            labels: productLabels,
	            datasets: [{
	                label: 'Số lượng bán',
	                data: productValues,
	                backgroundColor: 'rgba(92, 107, 192, 0.8)',
	                borderColor: 'rgba(92, 107, 192, 1)',
	                borderWidth: 1
	            }]
	        },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    x: {
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    y: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

        // Xử lý nút lọc thời gian
        $('.chart-action-btn').click(function() {
            $('.chart-action-btn').removeClass('active');
            $(this).addClass('active');
            
            // Ở đây có thể thêm logic cập nhật biểu đồ theo khoảng thời gian
        });

        // Xử lý dropdown lọc thời gian
        $('#timeFilter').change(function() {
            const selectedValue = $(this).val();
            console.log(`Đã chọn khoảng thời gian: ${selectedValue}`);
            // Ở đây có thể thêm logic cập nhật toàn bộ trang theo khoảng thời gian
        });
    </script>
</body>
</html>