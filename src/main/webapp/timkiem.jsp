
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Tìm Kiếm - Mua Sắm Quần Áo</title>
    
    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .search-results {
            padding: 50px 0;
        }
        .search-results h2 {
            font-weight: 600;
            color: #333;
            margin-bottom: 30px;
        }
        .sidebar {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }
        .filter-heading {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }
        .label {
            font-size: 1rem;
            font-weight: 500;
            color: #555;
            display: block;
            margin-bottom: 10px;
        }
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            border: none;
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
            color: #666;
        }
        .product-card .price {
            font-size: 1.3rem;
            color: #ff6f61;
            font-weight: 500;
        }
        .product-card .quantity {
            font-size: 0.9rem;
            color: #999;
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
        .badge {
            font-size: 0.9rem;
            padding: 5px 10px;
        }
        .no-results {
            text-align: center;
            padding: 50px 0;
            color: #666;
        }
        .no-results i {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 20px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }
        .page-item {
            list-style: none;
        }
        .page-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 2.5rem;
            height: 2.5rem;
            border-radius: 50%;
            font-size: 0.875rem;
            font-weight: 500;
            color: #4f46e5;
            background-color: #fff;
            border: 1px solid #e5e7eb;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .page-link:hover {
            background-color: #e0e7ff;
            border-color: #4f46e5;
            color: #4f46e5;
        }
        .page-item.active .page-link {
            background-color: #4f46e5;
            color: #fff;
            border-color: #4f46e5;
        }
        .page-item.disabled .page-link {
            color: #9ca3af;
            background-color: #f3f4f6;
            border-color: #e5e7eb;
            cursor: not-allowed;
        }
        .price-range-values {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .size-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        .size-button {
            padding: 8px;
            border: 1px solid #ccc;
            background: #fff;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .size-button:hover {
            background: #f0f0f0;
        }
        .color-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }
        .color-option {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            border: 1px solid #ccc;
        }
        .color-red { background-color: red; }
        .color-blue { background-color: blue; }
        .color-black { background-color: black; }
        .color-white { background-color: white; }
        @media (max-width: 576px) {
            .product-card img {
                height: 200px;
            }
            .product-card .card-title {
                font-size: 1rem;
            }
            .product-card .price {
                font-size: 1.1rem;
            }
            .sidebar {
                margin-bottom: 20px;
            }
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp"></jsp:include>

    <main>
        <section class="search-results">
            <div class="container">
                <h2 class="text-center">Kết Quả Tìm Kiếm</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-4">
                        <div class="sidebar">
                            <div class="filter-section">
                                <h3 class="filter-heading">Bộ lọc</h3>
                                
                                <!-- Price Filter -->
                                <div class="mb-6">
                                    <label class="label">Khoảng giá</label>
                                    <input type="range" class="price-range" min="0" max="1000000" step="100000" value="1000000" id="price-filter">
                                    <div class="price-range-values">
                                        <span>0đ</span>
                                        <span id="max-price">1.000.000đ</span>
                                    </div>
                                </div>

                                <!-- Size Filter -->
                                <div class="mb-6">
                                    <label class="label">Kích cỡ</label>
                                    <div class="size-grid">
                                        <button class="size-button" data-size="S">S</button>
                                        <button class="size-button" data-size="M">M</button>
                                        <button class="size-button" data-size="L">L</button>
                                        <button class="size-button" data-size="XL">XL</button>
                                    </div>
                                </div>

                                <!-- Color Filter -->
                                <div class="mb-6">
                                    <label class="label">Màu sắc</label>
                                    <div class="color-grid">
                                        <div class="color-option color-red" data-color="red"></div>
                                        <div class="color-option color-blue" data-color="blue"></div>
                                        <div class="color-option color-black" data-color="black"></div>
                                        <div class="color-option color-white" data-color="white"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-8">
                        <div class="row g-4">
                            <c:choose>
                                <c:when test="${not empty products}">
                                    <c:forEach var="product" items="${products}">
                                        <div class="col-md-4 col-sm-6">
                                            <div class="product-card card h-100 border-0 shadow-sm">
                                                <div class="position-relative">
                                                    <a href="${pageContext.request.contextPath}/chitietsanpham?id=${product.id}">
                                                        <img src="${pageContext.request.contextPath}${product.image}" 
                                                             class="card-img-top" 
                                                             alt="${product.name}">
                                                    </a>
                                                    <span class="badge bg-danger position-absolute top-0 start-0 m-2">
                                                        -20%
                                                    </span>
                                                </div>
                                                <div class="card-body d-flex flex-column">
                                                    <h5 class="card-title text-truncate">${product.name}</h5>
                                                    <p class="card-text text-muted flex-grow-1">
                                                        ${product.description}
                                                    </p>
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="price fw-bold text-primary">
                                                            ${product.price} VND
                                                        </span>
                                                        <span class="quantity text-muted">
                                                            Còn: ${product.quantity}
                                                        </span>
                                                    </div>
                                                    <div class="d-flex gap-2">
                                                        <a href="#" class="btn btn-primary flex-grow-1">
                                                            Mua ngay
                                                        </a>
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
                                    <div class="no-results">
                                        <i class="fas fa-search"></i>
                                        <p>Không tìm thấy sản phẩm nào phù hợp.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" 
                                           href="<c:url value='/timkiem?q=${query}&page=1&size=5'/>" 
                                           aria-label="First">««</a>
                                    </li>
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" 
                                               href="<c:url value='/timkiem?q=${query}&page=${currentPage - 1}&size=5'/>" 
                                               aria-label="Previous">«</a>
                                        </li>
                                    </c:if>
                                    <c:forEach 
                                        begin="${currentPage - 2 > 0 ? currentPage - 2 : 1}" 
                                        end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" 
                                        var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" 
                                               href="<c:url value='/timkiem?q=${query}&page=${i}&size=5'/>">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" 
                                               href="<c:url value='/timkiem?q=${query}&page=${currentPage + 1}&size=5'/>" 
                                               aria-label="Next">»</a>
                                        </li>
                                    </c:if>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" 
                                           href="<c:url value='/timkiem?q=${query}&page=${totalPages}&size=5'/>" 
                                           aria-label="Last">»»</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>