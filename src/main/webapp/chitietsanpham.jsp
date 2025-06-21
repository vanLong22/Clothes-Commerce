<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Áo Sơ Mi Nam Cao Cấp - FashionBrand</title>
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1f2937;
            --text-color: #4b5563;
            --background-color: #f7fafc;
            --spacing-md: 16px;
            --spacing-lg: 24px;
        }
        body {
            background-color: var(--background-color);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            margin-top: 90px;
            color: var(--text-color);
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .product-section {
            display: flex;
            flex-wrap: wrap;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 24px;
            gap: 32px;
        }
        .gallery, .product-info {
            flex: 1;
            min-width: 300px;
        }
        .gallery img {
            width: 90%;
            margin: 0 auto;
            display: block;
            height: auto;
            object-fit: cover;
            border-radius: 12px;
            transition: transform 0.3s;
        }
        .gallery img:hover {
            transform: scale(1.05);
        }
        .thumbnail-grid {
            display: grid;
            grid-template-columns: repeat(4, 60px);
            gap: 8px;
            margin-top: 16px;
        }
        .thumbnail {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
        }
        .thumbnail.active {
            border: 2px solid var(--primary-color);
        }
        .thumbnail:hover {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .product-info h1 {
            font-size: 32px;
            font-weight: bold;
            color: var(--secondary-color);
        }
        .rating {
            color: #f59e0b;
            margin: 8px 0;
        }
        .stock {
            padding: 4px 8px;
            border-radius: 9999px;
            font-size: 14px;
        }
        .stock.in-stock {
            background: #d1fae5;
            color: #065f46;
        }
        .stock.out-stock {
            background: #fee2e2;
            color: #991b1b;
        }
        .price {
            font-size: 28px;
            font-weight: bold;
            color: var(--secondary-color);
        }
        .old-price {
            font-size: 20px;
            color: #6b7280;
            text-decoration: line-through;
            margin-left: 16px;
        }
        .discount {
            background: #fee2e2;
            color: #991b1b;
            padding: 2px 8px;
            border-radius: 9999px;
            font-size: 14px;
            margin-left: 16px;
        }
        .color-option, .size-option, .quantity {
            margin-bottom: 24px;
        }
        .color-circle {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px;
            border: 1px solid #e2e8f0;
            cursor: pointer;
        }
        .color-circle.active {
            border: 2px solid var(--primary-color);
            padding: 2px;
        }
        .size-btn {
            padding: 8px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            background: #fff;
            cursor: pointer;
        }
        .size-btn.active {
            background: var(--primary-color);
            color: #fff;
            border-color: var(--primary-color);
        }
        .size-btn:hover {
            border-color: var(--primary-color);
            background: #eff6ff;
        }
        .quantity {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .quantity input {
            width: 60px;
            text-align: center;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 8px;
        }
        .quantity button {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 1px solid #e2e8f0;
            background: #fff;
            cursor: pointer;
            font-size: 16px;
        }
        .quantity button:hover {
            background: #eff6ff;
        }
        .btn {
            padding: 16px 32px;
            border-radius: 8px;
            color: #fff;
            border: none;
            cursor: pointer;
            width: 48%;
            margin-right: 4%;
            font-size: 16px;
        }
        .btn.add-cart {
            background: #4677f2;
        }
        .btn.buy-now {
            background: #35d447;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .description {
            margin-top: 16px;
            border-top: 1px solid #e2e8f0;
            padding-top: 16px;
            color: #6b7280;
        }
        .bottom-section {
            display: flex;
            gap: 24px;
            margin-top: 48px;
        }
        .reviews {
            flex: 2;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 24px;
        }
        .related-products {
            flex: 1;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 24px;
         }
        .reviews h2, .related-products h2 {
            font-size: 20px;
            font-weight: bold;
            color: var(--secondary-color);
            margin-bottom: 16px;
        }
        .review-item {
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 16px;
            margin-bottom: 16px;
        }
        .review-item p {
            font-size: 14px;
            line-height: 1.5;
        }
        .avatar {
            width: 32px;
            height: 32px;
            background: #dbeafe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-weight: bold;
            font-size: 12px;
        }
        .review-form {
            border-top: 1px solid #e2e8f0;
            padding-top: 16px;
            margin-top: 16px;
        }
        .review-form textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            resize: vertical;
        }
        .review-form button {
            padding: 8px 16px;
            background: var(--primary-color);
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 8px;
        }
        .review-form button:hover {
            background: #1d4ed8;
        }
        .product-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: box-shadow 0.3s;
            margin-bottom: 24px;
            width: 70%;
        }
        .product-card:hover {
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
        }
        .product-card img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }
        .product-card div {
            padding: 12px;
        }
        @media (max-width: 768px) {
            .product-section, .bottom-section {
                flex-direction: column;
            }
            .gallery, .product-info, .reviews, .related-products {
                width: 100%;
            }
            .thumbnail-grid {
                grid-template-columns: repeat(4, 1fr);
            }
            .btn {
                width: 100%;
                margin-bottom: 12px;
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

    <div class="container">
        <!-- Main Product Section -->
        <div class="product-section">
            <!-- Image Gallery -->
            <div class="gallery">
                <img src="${pageContext.request.contextPath}${productList[0].image}" alt="Main product">
                <div class="thumbnail-grid">
                    <div class="thumbnail active">
                        <img src="https://storage.googleapis.com/a1aa/image/3DUSB3hViSIwGBR6mVdF9N2Boyij6ZqfGFkMu8pGKls.jpg">
                    </div>
                    <div class="thumbnail">
                        <img src="https://storage.googleapis.com/a1aa/image/2FiP2jbrDjpaCCFRilkUXkK262f0aQBvLtS6s3Sa2_s.jpg">
                    </div>
                    <div class="thumbnail">
                        <img src="https://storage.googleapis.com/a1aa/image/CHo85XypPSlMu5kmm7gx5LH56SL1nu_ITCq5kgYaYZ4.jpg">
                    </div>
                    <div class="thumbnail">
                        <img src="https://storage.googleapis.com/a1aa/image/OSSQx1NptrN4fKxSYAqfWSHd6I9ayrZhXLIoqHGDuqw.jpg">
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="product-info">
                <h1>${productList[0].name}</h1>
                <div style="display: flex; align-items: center; gap: 16px;">
                    <div class="rating">★★★★☆ (120 đánh giá)</div>
                    <span class="stock ${productList[0].quantity > 0 ? 'in-stock' : 'out-stock'}">
                        Đã bán ${totalProductIdSold } sản phẩm
                    </span>
                </div>

                <div style="margin-top: 16px;">
                    <span class="price">${productList[0].price} đ</span>
                    <span class="old-price">900.000đ</span>
                    <span class="discount">-22%</span>
                </div>

                <!-- Color Option -->
				<div class="color-option">
				    <h3 style="font-size: 14px; font-weight: 500;">Màu sắc</h3>
				    <div style="display: flex; gap: 8px; margin-top: 8px;">
				        <c:forEach var="color" items="${colorList}">
				            <c:if test="${color.name == 'Đen'}">
				                <div class="color-circle active" style="background: #000;" data-variant-id="${color.id}" data-name="Đen"></div>
				            </c:if>
				            <c:if test="${color.name == 'Trắng'}">
				                <div class="color-circle" style="background: #fff;" data-variant-id="${color.id}" data-name="Trắng"></div>
				            </c:if>
				            <c:if test="${color.name == 'Đỏ'}">
				                <div class="color-circle" style="background: #ef4444;" data-variant-id="${color.id}" data-name="Đỏ"></div>
				            </c:if>
				            <c:if test="${color.name == 'Nâu'}">
				                <div class="color-circle" style="background: #6b7280;" data-variant-id="${color.id}" data-name="Nâu"></div>
				            </c:if>
				        </c:forEach>
				    </div>
				</div>
				
				<!-- Size Option -->
				<div class="size-option">
				    <h3 style="font-size: 14px; font-weight: 500;">Kích cỡ</h3>
				    <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; margin-top: 8px;">
				        <c:forEach var="size" items="${sizeList}">
				            <c:if test="${size.name == 'S'}"><button class="size-btn" data-variant-id="${size.id}" data-name="S">S</button></c:if>
				            <c:if test="${size.name == 'M'}"><button class="size-btn" data-variant-id="${size.id}" data-name="M">M</button></c:if>
				            <c:if test="${size.name == 'L'}"><button class="size-btn" data-variant-id="${size.id}" data-name="L">L</button></c:if>
				            <c:if test="${size.name == 'XL'}"><button class="size-btn" data-variant-id="${size.id}" data-name="XL">XL</button></c:if>
				            <c:if test="${size.name == 'XXL'}"><button class="size-btn" data-variant-id="${size.id}" data-name="XXL">XXL</button></c:if>
				        </c:forEach>
				    </div>
				</div>

                <div class="quantity">
                    <h3 style="font-size: 14px; font-weight: 500;">Số lượng</h3>
                    <div>
                        <button onclick="changeQuantity(-1)">-</button>
                        <input id="quantity" type="number" value="1" min="1" max="${productList[0].quantity}">
                        <button onclick="changeQuantity(1)">+</button>
                    </div>
                    <span style="font-size: 14px; color: #6b7280;">Còn ${productList[0].quantity} sản phẩm</span>
                </div>

                <div style="display: flex; gap: 16px; margin-top: 16px;">
                    <button class="btn add-cart" onclick="addToCart(${productList[0].id})">Thêm vào giỏ hàng</button>
                    <button class="btn buy-now">Mua ngay</button>
                </div>

                <div class="description">
                    <h3 style="font-size: 14px; font-weight: 500;">Mô tả sản phẩm</h3>
                    <p>${productList[0].description}</p>
                </div>
            </div>
        </div>

        <!-- Bottom Section with Reviews and Related Products -->
        <div class="bottom-section">
            <!-- Reviews Section (Left) -->
            <div class="reviews">
                <h2>Đánh giá sản phẩm</h2>
                <c:forEach var="comment" items="${commentList}">
				    <div class="review-item">
				        <div style="display: flex; gap: 12px;">
				            <div class="avatar"><c:out value="${fn:substring(comment.username, 0, 2)}"/></div>
				            <div>
				                <h4 style="font-weight: 500; color: var(--secondary-color); font-size: 14px;"><c:out value="${comment.username}"/></h4>
				                <div style="display: flex; gap: 8px; font-size: 12px; color: #6b7280;">
				                    
				                    <span>• <fmt:formatDate value="${comment.createAt}" pattern="dd/MM/yyyy"/></span>
				                </div>
				                <p><c:out value="${comment.content}"/></p>
				            </div>
				        </div>
				    </div>
				</c:forEach>

                <!-- Review Form -->
                <form class="review-form">
                    <h3 style="font-size: 14px; font-weight: 500; color: var(--secondary-color);">Viết đánh giá của bạn</h3>
                    <div style="margin-top: 8px;">
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <span style="font-size: 12px; color: var(--text-color);">Đánh giá:</span>
                            <span class="rating" style="cursor: pointer;">☆☆☆☆☆</span>
                        </div>
                        <textarea rows="4" placeholder="Nhập đánh giá của bạn..." style="margin-top: 8px;"></textarea>
                        <button type="submit">Gửi đánh giá</button>
                    </div>
                </form>
            </div>

            <!-- Related Products (Right) -->
            <div class="related-products">
			    <h2>Sản phẩm liên quan</h2>
			    <c:forEach var="product" items="${allProduct}" varStatus="status">
			        <c:if test="${status.index < 3}">
			            <div class="product-card">
			                <img src="${pageContext.request.contextPath}${product.image}" alt="${product.name}">
			                <div>
			                    <h3 style="font-size: 14px; font-weight: 500; color: var(--secondary-color);">${product.name}</h3>
			                    <p style="font-weight: 500; color: var(--primary-color); margin-top: 8px;">${product.price}đ</p>
			                </div>
			            </div>
			        </c:if>
			    </c:forEach>
			</div>
        </div>
    </div>

    <!--notification container -->
    <div id="toast"></div>

	<jsp:include page="footer.jsp"></jsp:include>

    <script>
	    $(document).ready(function() {
	        $(".buy-now").click(function() {
	            const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
	            const userId = localStorage.getItem("userId");
	
	            if (!isLoggedIn && !userId) {
	                showToast("Cần đăng nhập tài khoản.", 'error');
	                return;
	            }
	
	            const productId = ${productList[0].id};
	            const quantity = parseInt($("#quantity").val());
	            const color = $(".color-circle.active").data("name") || "default";
	            const size = $(".size-btn.active").data("name") || "default";
	
	            if (quantity <= 0 || quantity > ${productList[0].quantity}) {
	                showToast("Số lượng không hợp lệ!", 'error');
	                return;
	            }
	            
	            if (color === "default") {
	                showToast("Vui lòng chọn màu sắc!", 'error');
	                return;
	            }
	            if (size === "default") {
	                showToast("Vui lòng chọn kích cỡ!", 'error');
	                return;
	            }
	
	            const params = new URLSearchParams();
	            params.append('productId', productId);
	            params.append('quantity', quantity);
	            params.append('color', color);
	            params.append('size', size);
	            params.append('userId', userId);
	
	            const url = '${pageContext.request.contextPath}/thanhtoan?' + params.toString();
	            window.location.href = url;
	        });
	    });
    
    	/*
	    $(document).ready(function() {
	        // Function to handle the "Buy Now" button click
	        $(".buy-now").click(function() {
	        	// Kiểm tra trạng thái đăng nhập
                const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
                const userId = localStorage.getItem("userId");
                
                if (!isLoggedIn || !userId) {
                    showToast("Cần đăng nhập tài khoản.", 'success');
                    return;
                }
	        	
	            // thu thập dữ liệu
	            const productId = ${productList[0].id}; 
	            const quantity = parseInt($("#quantity").val()); 
	            const unitPrice = parseFloat(${productList[0].price}); 
	            const totalPrice = quantity * unitPrice;             
	            const color = $(".color-circle.active").data("variant-id") || "default"; 
	            const size = $(".size-btn.active").data("variant-id") || "default";              
	
	            // Validate quantity
	            if (quantity <= 0 || quantity > ${productList[0].quantity}) {
	                alert("Số lượng không hợp lệ!");
	                return;
	            }
	
	            // Prepare order data
	            const orderData = {
	                userId: userId,
	                totalPrice: totalPrice,
	                status: "pending", // Default status
	            };
	
	            // Step 1: Create the order
	            $.ajax({
	                url: "${pageContext.request.contextPath}/order",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify(orderData),
	                success: function(orderId) {
	                    if (orderId > 0) {
	                        // Step 2: Create the order detail
	                        const orderDetailData = {
	                            orderId: orderId,
	                            productId: productId,
	                            quantity: quantity,
	                            color: color,
	                            size: size,
	                            unitPrice: unitPrice,
	                        };
	
	                        $.ajax({
	                            url: "${pageContext.request.contextPath}/order/detail",
	                            type: "POST",
	                            contentType: "application/json",
	                            data: JSON.stringify(orderDetailData),
	                            success: function(result) {
	                                if (result > 0) {
	                                    // Step 3: Update the product quantity
	                                    $.ajax({
	                                        url: "${pageContext.request.contextPath}/order/updateQuantity",
	                                        type: "POST",
	                                        contentType: "application/json",
	                                        data: JSON.stringify({
	                                            productId: productId,
	                                            quantity: quantity
	                                        }),
	                                        success: function(updateResult) {
	                                            if (updateResult > 0) {
	                                                //alert("Đặt hàng thành công!");
	                                                showToast("Đặt hàng thành công.", 'success');
	                                                // Update the displayed quantity on the page
	                                                const currentQuantity = ${productList[0].quantity} - quantity;
	                                                $(".quantity span").text(`Còn ${currentQuantity} sản phẩm`);
	                                                $("#quantity").attr("max", currentQuantity);
	                                                if (currentQuantity <= 0) {
	                                                    $(".stock").text("Hết hàng").removeClass("in-stock").addClass("out-stock");
	                                                    $(".buy-now, .add-cart").prop("disabled", true);
	                                                }
	                                                window.location.href = `${pageContext.request.contextPath}/thanhtoan.jsp?productId=${productId}&quantity=${quantity}&color=${color}&size=${size}`;
	                                            } else {
	                                                alert("Lỗi khi cập nhật số lượng sản phẩm!");
	                                            }
	                                        },
	                                        error: function() {
	                                            alert("Lỗi khi cập cập nhật số lượng sản phẩm!");
	                                        }
	                                    });
	                                } else {
	                                    alert("Lỗi khi tạo chi tiết đơn hàng!");
	                                }
	                            },
	                            error: function() {
	                                alert("Lỗi khi tạo chi tiết đơn hàng!");
	                            }
	                        });
	                    } else {
	                        alert("Lỗi khi tạo đơn hàng nha !");
	                    }
	                },
	                error: function() {
	                    alert("Lỗi khi tạo đơn hàng nha!");
	                }
	            });
	        });
	    });
    	*/
    
	    $(document).ready(function() {
	        // Hàm thay đổi số lượng
	        function changeQuantity(delta) {
	            const quantityInput = $('#quantity');
	            let quantity = parseInt(quantityInput.val()) + delta;
	            if (quantity < 1) quantity = 1;
	            if (quantity > parseInt(quantityInput.attr('max'))) quantity = parseInt(quantityInput.attr('max'));
	            quantityInput.val(quantity);
	        }
	
	        // Hàm thêm sản phẩm vào giỏ hàng
	        function addToCart(productId) {
	        	// Kiểm tra trạng thái đăng nhập
                const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
                const userId = localStorage.getItem("userId");
                
                if (!isLoggedIn || !userId) {
                	showToast("Cần đăng nhập tài khoản.", 'success');
                    return;
                }
                
	            const quantity = parseInt($('#quantity').val());
	            const selectedColor = $('.color-circle.active');
	            const selectedSize = $('.size-btn.active');
	
	            // Kiểm tra xem đã chọn màu và kích cỡ chưa
	            if (!selectedColor.length || !selectedSize.length) {
	                showToast('Vui lòng chọn màu sắc và kích cỡ!', 'error');
	                return;
	            }
	
	            const colorId = parseInt(selectedColor.data('variant-id')); // Lấy colorId
	            const sizeId = parseInt(selectedSize.data('variant-id'));   // Lấy sizeId
	            const variantId = colorId + sizeId; // Giả sử variantId là tổ hợp colorId và sizeId (cần logic thực tế)
	
	            const cartData = {
	                userId: userId,
	                productId: productId,
	                colorId: colorId,
	                sizeId: sizeId,
	                variantId: variantId,
	                quantity: quantity,
	                createAt: new Date().toISOString() // Gửi createAt dưới dạng ISO
	            };
	
	            $.ajax({
	                url: '${pageContext.request.contextPath}/giohang/them',
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify(cartData),
	                success: function(data) {
	                    if (data.status === 'success') {
	                        showToast(data.message, 'success');
	                    } else {
	                        showToast(data.message, 'error');
	                    }
	                },
	                error: function() {
	                    showToast('Đã xảy ra lỗi khi thêm vào giỏ hàng!', 'error');
	                }
	            });
	        }
	
	        // Logic chọn màu sắc
	        $('.color-circle').on('click', function() {
	            $('.color-circle').removeClass('active');
	            $(this).addClass('active');
	        });
	
	        // Logic chọn kích cỡ
	        $('.size-btn').on('click', function() {
	            $('.size-btn').removeClass('active');
	            $(this).addClass('active');
	        });
	
	        // Gắn sự kiện cho nút thay đổi số lượng
	        $('button[onclick="changeQuantity(-1)"]').on('click', function() {
	            changeQuantity(-1);
	        });
	        $('button[onclick="changeQuantity(1)"]').on('click', function() {
	            changeQuantity(1);
	        });
	
	        // Gắn sự kiện cho nút "Thêm vào giỏ hàng"
	        $('.add-cart').on('click', function() {
	            const productId = $(this).attr('onclick').match(/\d+/)[0]; // Lấy productId từ onclick
	            addToCart(parseInt(productId));
	        });
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
	    
	 	/************** bình luận **********************/
		$(document).ready(function() {
			// Hàm thêm bình luận mới vào giao diện
			function appendNewComment(comment) {
			    // Định dạng ngày tháng
			    const formattedDate = new Date(comment.createAt).toLocaleDateString('vi-VN', {
			        day: '2-digit',
			        month: '2-digit',
			        year: 'numeric'
			    });

			    const reviewItem = `
			        <div class="review-item">
			            <div style="display: flex; gap: 12px;">
			                <div class="avatar">${comment.username.substring(0, 2)}</div>
			                <div>
			                    <h4 style="font-weight: 500; color: var(--secondary-color); font-size: 14px;">${comment.username}</h4>
			                    <div style="display: flex; gap: 8px; font-size: 12px; color: #6b7280;">
			                        <span>• ${formattedDate}</span>
			                    </div>
			                    <p>${comment.content}</p>
			                </div>
			            </div>
			        </div>
			    `;
			    
			    // Thêm bình luận vào đầu danh sách
			    $('.reviews .review-item').first().before(reviewItem);
			}

			// Xử lý form bình luận
			$('.review-form').on('submit', function(e) {
			    e.preventDefault();
			    
			    // Kiểm tra đăng nhập
			    const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
			    const userId = localStorage.getItem("userId");
			    
			    if (!isLoggedIn || !userId) {
			        showToast("Cần đăng nhập tài khoản.", 'error');
			        return;
			    }
			    
			    const content = $(this).find('textarea').val();
			    const productId = ${productList[0].id};
			    const rating = $(this).find('.rating').data('rating') || 0;
			    
			    if (!content.trim()) {
			        showToast('Vui lòng nhập nội dung đánh giá', 'error');
			        return;
			    }

			    $.ajax({
			        url: '${pageContext.request.contextPath}/comment/them',
			        type: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify({
			            productId: productId,
			            userId: userId,
			            content: content,
			            rating: rating
			        }),
			        success: function(response) {
			            if (response.status === 'success') {
			                // Xóa nội dung textarea
			                $('.review-form textarea').val('');
			                
			                // Thêm bình luận mới vào giao diện
			                appendNewComment({
			                    username: localStorage.getItem("username"),
			                    content: content,
			                    createAt: new Date().toISOString()
			                });
			                location.reload();
			                
			                showToast('Đã thêm bình luận thành công!', 'success');
			            } else {
			                showToast('Có lỗi xảy ra: ' + (response.message || 'Vui lòng thử lại'), 'error');
			            }
			        },
			        error: function(xhr) {
			            showToast('Có lỗi xảy ra: ' + (xhr.responseJSON?.message || 'Vui lòng thử lại'), 'error');
			        }
			    });
			});
		});
	</script>
</body>
</html>