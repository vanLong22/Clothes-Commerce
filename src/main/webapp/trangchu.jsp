<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.Shopping.model.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Web Mua Sắm Quần Áo Hiện Đại</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome cho icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>

/* Banner */
.banner {
	position: relative;
	height: 600px;
	background: url('https://via.placeholder.com/1920x600?text=Banner')
		no-repeat center/cover;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	color: #fff;
}

.banner::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	z-index: 1;
}

.banner-content {
	position: relative;
	z-index: 2;
}

.banner-content h1 {
	font-size: 3.5em;
	font-weight: 600;
	text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
}

.banner-content p {
	font-size: 1.2em;
}

.banner-content .btn {
	padding: 12px 40px;
	font-weight: 600;
	text-transform: uppercase;
	transition: transform 0.3s;
}

.banner-content .btn:hover {
	transform: translateY(-3px);
}

/* Categories */
.category-card {
	position: relative;
	overflow: hidden;
	border-radius: 15px;
	transition: transform 0.3s;
}

.category-card:hover {
	transform: scale(1.05);
}

.category-card img {
	height: 250px;
	object-fit: cover;
}

.category-card h3 {
	position: absolute;
	bottom: 20px;
	left: 20px;
	color: #fff;
	background: rgba(0, 0, 0, 0.6);
	padding: 8px 15px;
	border-radius: 5px;
	text-transform: uppercase;
}

/* Products */
/* Products */
.product-card {
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	background: #fff;
	border-radius: 10px;
	overflow: hidden;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

.product-card img {
	height: 250px;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.product-card:hover img {
	transform: scale(1.05);
}

.product-card .card-body {
	padding: 15px;
}

.product-card .card-title {
	font-size: 1.2rem;
	font-weight: 600;
	margin-bottom: 10px;
	color: #333;
}

.product-card .card-text {
	font-size: 0.9rem;
	line-height: 1.4;
}

.product-card .price {
	font-size: 1.3rem;
	color: #ff6f61; /* Màu giá nổi bật */
}

.product-card .quantity {
	font-size: 0.9rem;
}

.product-card .btn-primary {
	background-color: #007bff;
	border: none;
	padding: 8px;
	font-weight: 500;
	text-transform: uppercase;
}

.product-card .btn-primary:hover {
	background-color: #0056b3;
}

.product-card .btn-outline-secondary {
	padding: 8px;
	border-color: #ccc;
}

.product-card .btn-outline-secondary:hover {
	background-color: #f8f9fa;
}

/* Badge giảm giá */
.badge {
	font-size: 0.9rem;
	padding: 5px 10px;
}

/* Responsive */
@media ( max-width : 576px) {
	.product-card img {
		height: 200px;
	}
	.product-card .card-title {
		font-size: 1rem;
	}
	.product-card .price {
		font-size: 1.1rem;
	}
}

/****** MODAL đăng nhập **********/
.login {
	display: none; /* ẩn modal mặc định */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
}

.login-content {
	padding: 20px;
	/*background: white;*/
	border-radius: 8px;
	text-align: center;
	width: 900px;
}

.login-body {
	display: flex;
	max-width: 900px;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

.left {
	flex: 1;
	background-color: #1a1a2e;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding: 20px;
	position: relative;
}

.left img {
	position: absolute;
	width: 100%;
	height: 100%;
	object-fit: cover;
	opacity: 1.5; /* tăng độ sáng */
}

.right {
	flex: 1;
	background-color: white;
	padding: 40px;
	display: flex;
	flex-direction: column;
	justify-content: center;
}

h2 {
	font-size: 1.5rem;
	margin-bottom: 20px;
	color: black;
}

.infor {
	width: 100%;
	padding: 10px;
	margin: 10px 0;
	border-radius: 5px;
	box-sizing: border-box;
}

.btn-dangnhap, .btn-dangky, .btn-doimk, .btn-google {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	font-size: 1rem;
	margin-top: 10px;
}

.btn-dangnhap {
	background-color: #007bff;
}

.btn-dangky {
	background-color: #28a745;
}

.btn-doimk {
	background-color: #555555;
}

.btn-google {
	background-color: #db4437; /* Màu đỏ của Google */
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
}

.btn-google i {
	margin-right: 10px;
}

.form-luumk {
	display: flex;
	align-items: center;
	justify-content: space-between;
	font-family: Arial, sans-serif;
	color: #333;
}

.form-luumk label {
	font-size: 0.875rem;
	margin: 0;
}

.form-luumk a {
	font-size: 0.875rem;
	color: #007bff;
	text-decoration: none;
	margin-left: 10px;
}

.error-message {
	color: red;
	font-size: 30px;
	margin-top: 5px;
}

/* Phân trang */
.pagination {
    display: flex;
    justify-content: center;
    gap: 0.5rem; /* Khoảng cách giữa các nút */
    margin-top: 1.5rem; /* Tăng margin-top từ mt-4 */
}

.page-item {
    list-style: none;
}

.page-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 2.5rem; /* Kích thước cố định */
    height: 2.5rem;
    border-radius: 50%; /* Hình tròn */
    font-size: 0.875rem;
    font-weight: 500;
    color: #4f46e5; /* Màu chữ */
    background-color: #fff;
    border: 1px solid #e5e7eb; /* Viền nhẹ */
    text-decoration: none;
    transition: all 0.3s ease; /* Hiệu ứng mượt mà */
}

.page-link:hover {
    background-color: #e0e7ff; /* Màu nền khi hover */
    border-color: #4f46e5; /* Viền đổi màu */
    color: #4f46e5;
}

.page-item.active .page-link {
    background-color: #4f46e5; /* Màu nền khi active */
    color: #fff; /* Màu chữ */
    border-color: #4f46e5;
}

.page-item.disabled .page-link {
    color: #9ca3af; /* Màu chữ khi disabled */
    background-color: #f3f4f6;
    border-color: #e5e7eb;
    cursor: not-allowed;
}

/* Điều chỉnh dấu ba chấm */
.page-item.disabled .page-link {
    border: none;
    background: none;
    pointer-events: none;
}

</style>
</head>
<body>
	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- Main Content -->
	<main>
		<!-- Banner -->
		<section class="banner">
			<div class="banner-content">
				<h1>Bộ Sưu Tập Thu Đông 2023</h1>
				<p>Khám phá phong cách mới nhất với mức giá ưu đãi!</p>
				<button class="btn btn-primary">Mua Ngay</button>
			</div>
		</section>

		<!-- Categories -->
		<section class="categories py-5">
		    <div class="container">
		        <h2 class="text-center mb-5">Danh Sách Sản Phẩm</h2>
		        <div class="row g-4">
		            <c:choose>
		                <c:when test="${not empty allProducts}">
		                    <!-- Tính toán phân trang -->
		                    <c:set var="pageSize" value="6" /> <!-- Số sản phẩm mỗi trang -->
		                    <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
		                    <c:set var="totalProducts" value="${allProducts.size()}" />
		                    <c:set var="totalPages" value="${(totalProducts + pageSize - 1) / pageSize}" />
		
		                    <!-- Lấy danh sách sản phẩm cho trang hiện tại -->
		                    <c:forEach var="product" items="${allProducts}" 
		                               begin="${(currentPage - 1) * pageSize}" 
		                               end="${currentPage * pageSize - 1}">
		                        <div class="col-md-4 col-sm-6">
		                            <div class="product-card card h-100 border-0 shadow-sm">
		                                <div class="position-relative">
		                                    <a href="${pageContext.request.contextPath}/chitietsanpham?id=${product.id}">
										        <img src="${pageContext.request.contextPath}${product.image}"
										             class="card-img-top" alt="${product.name}">
										    </a>
		                                    <span class="badge bg-danger position-absolute top-0 start-0 m-2">
		                                        -${50000}% 
		                                    </span>
		                                </div>
		                                <div class="card-body d-flex flex-column">
		                                    <h5 class="card-title text-truncate">${product.name}</h5>
		                                    <p class="card-text text-muted flex-grow-1">${product.description}</p>
		                                    <div class="d-flex justify-content-between align-items-center mb-2">
		                                        <span class="price fw-bold text-primary">${product.price} VND</span>
		                                        <span class="quantity text-muted">Còn: ${product.quantity}</span>
		                                    </div>
		                                    <div class="d-flex gap-2">
		                                        <a href="#" class="btn btn-primary flex-grow-1">Mua ngay</a>
		                                        <button class="btn btn-outline-secondary add-to-cart"
		                                                data-product-id="${product.id}">
		                                            <i class="fas fa-cart-plus"></i>
		                                        </button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <p class="text-center text-muted py-5">Không có sản phẩm nào.</p>
		                </c:otherwise>
		            </c:choose>
		        </div>
		
                <!-- Phân trang -->
				<c:if test="${totalPages > 1}">
				    <nav aria-label="Page navigation" class="mt-6">
				        <ul class="pagination justify-content-center">
				            <!-- Nút Trang đầu -->
				            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
				                <a class="page-link" href="?page=1" aria-label="First">
				                    <span aria-hidden="true">««</span>
				                </a>
				            </li>
				
				            <!-- Nút Previous -->
				            <c:if test="${currentPage > 1}">
				                <li class="page-item">
				                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
				                        <span aria-hidden="true">«</span>
				                    </a>
				                </li>
				            </c:if>
				
				            <!-- Hiển thị các số trang -->
				            <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
				            <c:set var="endPage" value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>
				            
				            <c:if test="${startPage > 1}">
				                <li class="page-item disabled"><span class="page-link">...</span></li>
				            </c:if>
				            
				            <c:forEach var="i" begin="${startPage}" end="${endPage}">
				                <li class="page-item ${currentPage == i ? 'active' : ''}">
				                    <a class="page-link" href="?page=${i}">${i}</a>
				                </li>
				            </c:forEach>
				
				            <c:if test="${endPage < totalPages}">
				                <li class="page-item disabled"><span class="page-link">...</span></li>
				            </c:if>
				
				            <!-- Nút Next -->
				            <c:if test="${currentPage < totalPages}">
				                <li class="page-item">
				                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
				                        <span aria-hidden="true">»</span>
				                    </a>
				                </li>
				            </c:if>
				
				            <!-- Nút Trang cuối -->
				            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
				                <a class="page-link" href="?page=${totalPages}" aria-label="Last">
				                    <span aria-hidden="true">»»</span>
				                </a>
				            </li>
				        </ul>
				    </nav>
				</c:if>
		    </div>
		</section>

		<!-- Products -->
		<section class="products py-5 bg-light">
			<div class="container">
				<h2 class="text-center mb-4">Sản Phẩm Nổi Bật</h2>
				<!-- những sản phẩm bán chạy nhất của cửa hàng -->
				<div class="row" id="product-grid">
					<!-- Sản phẩm sẽ được thêm bằng JavaScript -->
				</div>
			</div>
		</section>
	</main>


 

	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		
		
		
        // Dữ liệu sản phẩm mẫu
        const products = [
            { name: 'Áo Thun Basic', price: '250.000 VND', image: 'https://via.placeholder.com/300x350?text=Áo+Thun' },
            { name: 'Quần Jeans Rách', price: '600.000 VND', image: 'https://via.placeholder.com/300x350?text=Quần+Jeans' },
            { name: 'Váy Maxi Hoa', price: '450.000 VND', image: 'https://via.placeholder.com/300x350?text=Váy+Maxi' },
            { name: 'Túi Xách Mini', price: '350.000 VND', image: 'https://via.placeholder.com/300x350?text=Túi+Xách' },
        ];

        // Hiển thị sản phẩm
        function displayProducts(productList) {
            const productGrid = document.getElementById('product-grid');
            productGrid.innerHTML = '';
            productList.forEach(product => {
                const productHTML = `
                    <div class="col-md-3 mb-4">
                        <div class="product-card card h-100">
                            <img src="${product.image}" class="card-img-top" alt="${product.name}">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text">${product.price}</p>
                                <button class="btn btn-primary">Thêm Vào Giỏ</button>
                            </div>
                        </div>
                    </div>
                `;
                productGrid.innerHTML += productHTML;
            });
        }

        // Tìm kiếm sản phẩm
        document.querySelector('.navbar form').addEventListener('submit', function(e) {
            e.preventDefault();
            const searchTerm = this.querySelector('input').value.toLowerCase();
            const filteredProducts = products.filter(product => 
                product.name.toLowerCase().includes(searchTerm)
            );
            displayProducts(filteredProducts);
        });

        // Hiển thị sản phẩm khi trang tải
        window.onload = () => displayProducts(products);
    </script>
</body>
</html>