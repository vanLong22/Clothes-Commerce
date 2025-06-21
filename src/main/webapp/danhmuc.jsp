<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Fashion Store - Danh Mục</title>
    <style type="text/css">
        /* Định nghĩa CSS tùy chỉnh */
        body {
            background-color: #f9fafb;
            font-family: 'Arial', sans-serif; /* Thêm font chữ */
        }

        /* Container chính */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }
        @media (min-width: 640px) {
            .container {
                padding: 2rem 1.5rem;
            }
        }
        @media (min-width: 1024px) {
            .container {
                padding: 2rem 2rem;
            }
        }

        /* Breadcrumb */
        .breadcrumb {
            margin-bottom: 1.5rem;
        }
        .breadcrumb a {
            font-size: 0.875rem;
            color: #6b7280;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            color: #4f46e5;
        }
        .breadcrumb span {
            margin: 0 0.5rem;
            color: #9ca3af;
        }

        /* Điều hướng danh mục */
        .category-nav {
            margin-bottom: 2rem;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 1rem;
        }
        .heading {
            font-size: 1.5rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: 1rem;
        }
        .flex-container {
            display: flex;
            gap: 2rem; /* Tăng gap từ 1.5rem */
            overflow-x: auto;
            padding-bottom: 0.5rem;
        }
        .category-link {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0.75rem 1.25rem; /* Tăng padding */
            background-color: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s, transform 0.3s;
        }
        .category-link:hover {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
        .category-icon {
            font-size: 1.5rem; /* Tăng kích thước icon */
            color: #4f46e5;
            margin-bottom: 0.5rem;
        }
        .category-text {
            font-size: 0.875rem;
            font-weight: 500;
            color: #374151;
        }

        /* Nội dung chính */
        .main-content {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        @media (min-width: 1024px) {
            .main-content {
                flex-direction: row;
            }
        }
        @media (max-width: 640px) {
            .main-content {
                flex-direction: column; /* Sidebar dưới sản phẩm trên mobile */
            }
        }

        /* Sidebar bộ lọc */
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        @media (min-width: 1024px) {
            .sidebar {
                width: 16rem;
            }
        }
        @media (max-width: 640px) {
            .sidebar {
                width: 100%;
            }
        }
        .filter-section {
            background-color: #fff;
            padding: 1.5rem; /* Tăng padding từ 1rem */
            border-radius: 0.75rem;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        .filter-heading {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #111827;
        }
        .label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        .price-range {
            width: 100%;
            margin-top: 0.5rem;
        }
        .price-range::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 20px;
            height: 20px;
            background: #4f46e5;
            border-radius: 50%;
            cursor: pointer;
        }
        .price-range-values {
            display: flex;
            justify-content: space-between;
            font-size: 0.75rem;
            color: #6b7280;
            margin-top: 0.5rem;
        }
        .size-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 0.75rem; /* Tăng gap từ 0.5rem */
        }
        .size-button {
            font-size: 0.875rem;
            padding: 0.5rem 1rem; /* Tăng padding */
            border-radius: 9999px;
            background-color: #f3f4f6;
            transition: background-color 0.3s, color 0.3s;
        }
        .size-button:hover {
            background-color: #e0e7ff;
            color: #4f46e5;
        }
        .color-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 0.75rem; /* Tăng gap từ 0.5rem */
        }
        .color-option {
            width: 2rem;
            height: 2rem;
            border-radius: 50%;
            border: 2px solid #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: transform 0.3s;
        }
        .color-option:hover {
            transform: scale(1.1);
        }
        .color-red { background-color: #ef4444; }
        .color-blue { background-color: #2563eb; }
        .color-black { background-color: #000; }
        .color-white { background-color: #fff; border-color: #e5e7eb; }

        /* Lưới sản phẩm */
        .product-section {
            flex: 1;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(1, minmax(0, 1fr));
            gap: 2rem; /* Tăng gap từ 1.5rem */
        }
        @media (min-width: 640px) {
            .product-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }
        @media (min-width: 1024px) {
            .product-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }
        .product-card {
            background-color: #fff;
            border-radius: 0.75rem;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            transition: box-shadow 0.3s, transform 0.3s;
            position: relative;
            overflow: hidden;
        }
        .product-card:hover {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
        .product-image {
            width: 100%;
            height: 16rem;
            object-fit: cover;
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
            transition: transform 0.3s;
        }
        .product-card:hover .product-image {
            transform: scale(1.05); /* Zoom nhẹ khi hover */
        }
        .product-info {
            padding: 1rem;
        }
        .product-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #111827;
        }
        .product-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: #4f46e5;
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

        /* Utility classes */
        .mb-6 {
            margin-bottom: 1.5rem;
        }
        
        .size-button.active {
		    background-color: #4f46e5;
		    color: #fff;
		}
		.color-option.active {
		    border: 2px solid #4f46e5;
		}
    </style>
</head>
<body class="bg-gray-50">
    <!-- Header -->
    <jsp:include page="header.jsp"></jsp:include>
    
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="/Shopping/trangchu">Trang chủ</a>
            <span>/</span>
            <span>Thời Trang Nam</span>
        </div>

        <!-- Category Navigation -->
        <div class="category-nav">
            <h1 class="heading">Thời Trang Nam</h1>
            <div class="flex-container">
                <a href="${pageContext.request.contextPath}/danhmuc?category=112" class="category-link">
                    <span class="category-icon">👕</span>
                    <span class="category-text">Áo</span>
                </a>
                <a href="${pageContext.request.contextPath}/danhmuc?category=114" class="category-link">
                    <span class="category-icon">👖</span>
                    <span class="category-text">Quần</span>
                </a>
                <a href="${pageContext.request.contextPath}/danhmuc?category=120" class="category-link">
                    <span class="category-icon">👟</span>
                    <span class="category-text">Giày</span>
                </a>
            </div>
        </div>

        <div class="main-content">
            <!-- Filters Sidebar -->
            <div class="sidebar">
                <div class="filter-section">
                    <h3 class="filter-heading">Bộ lọc</h3>
                    
                    <!-- Price Filter -->
                    <div class="mb-6">
                        <label class="label">Khoảng giá</label>
                        <input type="range" class="price-range" id="priceRange" 
                               min="0" max="1000000" step="100000" onchange="applyFilters()" />
                        <div class="price-range-values">
                            <span id="priceMin">0đ</span>
                            <span id="priceMax">1.000.000đ</span>
                        </div>
                    </div>
            
                    <!-- Size Filter -->
                    <div class="mb-6">
                        <label class="label">Kích cỡ</label>
                        <div class="size-grid">
                            <button class="size-button" onclick="toggleSize('S')">S</button>
                            <button class="size-button" onclick="toggleSize('M')">M</button>
                            <button class="size-button" onclick="toggleSize('L')">L</button>
                            <button class="size-button" onclick="toggleSize('XL')">XL</button>
                        </div>
                    </div>
            
                    <!-- Color Filter -->
                    <div class="mb-6">
                        <label class="label">Màu sắc</label>
                        <div class="color-grid">
                            <div class="color-option color-red" onclick="toggleColor('red')"></div>
                            <div class="color-option color-blue" onclick="toggleColor('blue')"></div>
                            <div class="color-option color-black" onclick="toggleColor('black')"></div>
                            <div class="color-option color-white" onclick="toggleColor('white')"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Grid -->
            <div class="product-section">
                <div class="product-grid" id="productGrid">
                    <c:forEach var="product" items="${allProducts}">
                        <div class="product-card">
                            <div class="relative">
                                <a href="${pageContext.request.contextPath}/chitietsanpham?id=${product.id}">
                                    <img src="${pageContext.request.contextPath}${product.image}" class="product-image" alt="${product.name}">
                                </a>
                            </div>
                            <div class="product-info">
                                <h3 class="product-title">${product.name}</h3>
                                <span class="product-price">${product.price}đ</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Phân trang -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-6">
                        <ul class="pagination justify-content-center">
                            <!-- Nút Trang đầu -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?category=${param.category}&page=1&price=${maxPrice}&sizes=${sizes}&colors=${colors}" aria-label="First">
                                    <span aria-hidden="true">««</span>
                                </a>
                            </li>
                            <!-- Nút Previous -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?category=${param.category}&page=${currentPage - 1}&price=${maxPrice}&sizes=${sizes}&colors=${colors}" aria-label="Previous">
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
                                    <a class="page-link" href="?category=${param.category}&page=${i}&price=${maxPrice}&sizes=${sizes}&colors=${colors}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${endPage < totalPages}">
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                            </c:if>
                
                            <!-- Nút Next -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?category=${param.category}&page=${currentPage + 1}&price=${maxPrice}&sizes=${sizes}&colors=${colors}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </c:if>
                            <!-- Nút Trang cuối -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="?category=${param.category}&page=${totalPages}&price=${maxPrice}&sizes=${sizes}&colors=${colors}" aria-label="Last">
                                    <span aria-hidden="true">»»</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>
    
    <script>
    // Lưu trữ các giá trị bộ lọc
    let selectedSizes = "${sizes}".split(",").filter(s => s !== "");
    let selectedColors = "${colors}".split(",").filter(c => c !== "");
    let selectedPrice = ${maxPrice};

    // Cập nhật giá trị thanh trượt giá
    $(document).ready(function() {
        // Khởi tạo giá trị thanh trượt
        $('#priceRange').val(selectedPrice);
        $('#priceMax').text(selectedPrice + 'đ');

        // Cập nhật trạng thái kích cỡ
        $('.size-button').each(function() {
            if (selectedSizes.includes($(this).text())) {
                $(this).addClass('active');
            }
        });

        // Cập nhật trạng thái màu sắc
        $('.color-option').each(function() {
            const color = $(this).attr('class').match(/color-(\w+)/)[1];
            if (selectedColors.includes(color)) {
                $(this).addClass('active');
            }
        });

        // Cập nhật giá khi thay đổi thanh trượt
        $('#priceRange').on('input', function() {
            selectedPrice = $(this).val();
            $('#priceMax').text(selectedPrice + 'đ');
            applyFilters();
        });
    });

    // Xử lý chọn kích cỡ
    function toggleSize(size) {
        const button = $(event.target);
        if (selectedSizes.includes(size)) {
            selectedSizes = selectedSizes.filter(s => s !== size);
            button.removeClass('active');
        } else {
            selectedSizes.push(size);
            button.addClass('active');
        }
        applyFilters();
    }

    // Xử lý chọn màu sắc
    function toggleColor(color) {
        const option = $(event.target);
        if (selectedColors.includes(color)) {
            selectedColors = selectedColors.filter(c => c !== color);
            option.removeClass('active');
        } else {
            selectedColors.push(color);
            option.addClass('active');
        }
        applyFilters();
    }

    // Gửi yêu cầu lọc đến server bằng jQuery AJAX
    function applyFilters() {
        const category = new URLSearchParams(window.location.search).get('category') || '1';
        const page = new URLSearchParams(window.location.search).get('page') || '1';
        
        // Tạo URL với các tham số bộ lọc
        const url = `${window.location.pathname}?category=${category}&page=${page}` +
                    `&price=${selectedPrice}` +
                    `&sizes=${selectedSizes.join(',')}` +
                    `&colors=${selectedColors.join(',')}`;

        // Ghi log thông tin gửi đi
        console.log('Thông tin bộ lọc gửi đi:');
        console.log('Category:', category);
        console.log('Page:', page);
        console.log('Price:', selectedPrice);
        console.log('Sizes:', selectedSizes);
        console.log('Colors:', selectedColors);
        console.log('URL:', url);

        // Gửi yêu cầu AJAX bằng jQuery
        $.ajax({
            url: url,
            method: 'GET',
            success: function(data) {
                // Cập nhật danh sách sản phẩm
                const doc = new DOMParser().parseFromString(data, 'text/html');
                const newProductGrid = doc.querySelector('#productGrid');
                const newPagination = doc.querySelector('.pagination');

                $('#productGrid').html(newProductGrid.innerHTML);
                if (newPagination) {
                    const paginationContainer = $('.pagination');
                    if (paginationContainer.length) {
                        paginationContainer.html(newPagination.innerHTML);
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }

    // Xóa bộ lọc
    function resetFilters() {
        selectedSizes = [];
        selectedColors = [];
        selectedPrice = 1000000;
        $('#priceRange').val(selectedPrice);
        $('#priceMax').text(selectedPrice + 'đ');
        
        // Xóa trạng thái active
        $('.size-button').removeClass('active');
        $('.color-option').removeClass('active');
        
        applyFilters();
    }
    </script>
</body>
</html>