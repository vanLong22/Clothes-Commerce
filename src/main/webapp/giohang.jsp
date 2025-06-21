<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style type="text/css">
        /* CSS tổng thể */
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .heading {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .heading:after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: #6c5ce7;
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        /* Bảng giỏ hàng */
        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .table th, .table td {
            padding: 1.25rem;
            text-align: center;
            vertical-align: middle;
        }

        .table thead th {
            background: #6c5ce7;
            color: white;
            font-weight: 600;
            border-bottom: none;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(108, 92, 231, 0.1);
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e9ecef;
        }

        /* Input số lượng */
        .quantity-input {
            width: 100px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid #dee2e6;
        }

        .quantity-input input {
            width: 50px;
            text-align: center;
            border: none;
            padding: 0.5rem;
            font-size: 1rem;
            outline: none;
        }

        .quantity-input button {
            width: 30px;
            border: none;
            background: #f8f9fa;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .quantity-input button:hover {
            background: #6c5ce7;
            color: white;
        }

        /* Nút hành động */
        .action-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
            font-weight: 500;
        }

        .remove-btn {
            background: #ff7675;
            color: white;
        }

        .remove-btn:hover {
            background: #d63031;
            transform: scale(1.05);
        }

        /* Tổng cộng */
        .total-section {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            margin: 2rem 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .total-price {
            font-size: 1.5rem;
            color: #2d3748;
            font-weight: 700;
            text-align: right;
        }

        .text-primary {
            color: #6c5ce7;
        }

        /* Nhóm nút */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .btn-continue {
            background: linear-gradient(135deg, #6c5ce7 0%, #a8a4e6 100%);
            color: white;
            border: none;
        }

        .btn-checkout {
            background: linear-gradient(135deg, #00b894 0%, #55efc4 100%);
            color: white;
            border: none;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 92, 231, 0.25);
        }

        /* Empty cart */
        .empty-cart {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .empty-cart-icon {
            font-size: 3rem;
            color: #a5b1c2;
            margin-bottom: 1rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .heading {
                font-size: 2rem;
            }

            .table thead {
                display: none;
            }

            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }

            .table tr {
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                padding: 1rem;
            }

            .table td {
                text-align: right;
                position: relative;
                padding-left: 50%;
                padding-top: 0.75rem;
                padding-bottom: 0.75rem;
            }

            .table td:before {
                content: attr(data-label);
                position: absolute;
                left: 1rem;
                width: calc(50% - 1rem);
                text-align: left;
                font-weight: 600;
                color: #6c5ce7;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
                width: 100%;
            }
            
            .product-image {
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <div class="container">
        <h1 class="heading">Giỏ hàng của bạn</h1>
        
        <c:choose>
            <c:when test="${empty carts}">
                <div class="empty-cart">
                    <div class="empty-cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3>Giỏ hàng của bạn đang trống</h3>
                    <p>Hãy khám phá cửa hàng và thêm sản phẩm vào giỏ hàng!</p>
                    <a href="${pageContext.request.contextPath}/danhmuc" class="btn btn-continue" style="margin-top: 1rem;">
                        <i class="fas fa-store"></i> Mua sắm ngay
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="table">
				    <thead>
				        <tr>
				            <th><input type="checkbox" id="select-all" checked> Chọn</th> <!-- Checkbox chọn tất cả -->
				            <th>Hình ảnh</th>
				            <th>Tên sản phẩm</th>
				            <th>Màu sắc</th>
				            <th>Kích thước</th>
				            <th>Số lượng</th>
				            <th>Tổng cộng</th>
				            <th>Hành động</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:set var="totalPrice" value="0" />
				        <c:forEach var="cart" items="${carts}">
				            <tr id="cart-row-${cart.id}" data-color-id="${cart.colorId}" data-size-id="${cart.sizeId}">
				                <td data-label="Chọn">
				                    <input type="checkbox" class="select-item" checked data-price="${cart.productPrice * cart.quantity}">
				                </td>
				                <td data-label="Hình ảnh">
				                    <c:choose>
				                        <c:when test="${not empty cart.productImage}">
				                            <img src="${pageContext.request.contextPath}${cart.productImage}" 
				                                 alt="${cart.productName}" 
				                                 class="product-image">
				                        </c:when>
				                        <c:otherwise>
				                            <img src="${pageContext.request.contextPath}/path/to/default-image.jpg" 
				                                 alt="Default Image" 
				                                 class="product-image">
				                        </c:otherwise>
				                    </c:choose>
				                </td>
				                <td data-label="Tên sản phẩm">
				                    <c:out value="${cart.productName}" default="N/A" />
				                </td>
				                <td data-label="Màu sắc">
				                    <select class="color-select">
				                        <c:choose>
				                            <c:when test="${not empty colors}">
				                                <c:forEach var="color" items="${colors}">
				                                    <option value="${color.id}" ${color.id == cart.colorId ? 'selected' : ''}>
				                                        <c:out value="${color.name}" />
				                                    </option>
				                                </c:forEach>
				                            </c:when>
				                            <c:otherwise>
				                                <option value="">Không có màu</option>
				                            </c:otherwise>
				                        </c:choose>
				                    </select>
				                </td>
				                <td data-label="Kích thước">
				                    <select class="size-select">
				                        <c:choose>
				                            <c:when test="${not empty sizes}">
				                                <c:forEach var="size" items="${sizes}">
				                                    <option value="${size.id}" ${size.id == cart.sizeId ? 'selected' : ''}>
				                                        <c:out value="${size.name}" />
				                                    </option>
				                                </c:forEach>
				                            </c:when>
				                            <c:otherwise>
				                                <option value="">Không có kích thước</option>
				                            </c:otherwise>
				                        </c:choose>
				                    </select>
				                </td>
				                <td data-label="Số lượng">
				                    <div class="quantity-input">
				                        <c:choose>
				                            <c:when test="${cart.productQuantity < cart.quantity}">
				                                <span style="color: red;">Sản phẩm hết hàng</span>
				                            </c:when>
				                            <c:otherwise>
				                                <button type="button" class="minus-btn">-</button>
				                                <input type="number" value="${cart.quantity}" min="1" class="quantity-input-field">
				                                <button type="button" class="plus-btn">+</button>
				                            </c:otherwise>
				                        </c:choose>
				                    </div>
				                </td>
				                <td data-label="Tổng cộng" class="item-total">
				                    <c:out value="${cart.productPrice * cart.quantity}đ" default="0đ" />
				                </td>
				                <td data-label="Hành động">
				                    <button class="action-btn remove-btn" 
				                            onclick="removeFromCart(${cart.id})">
				                        <i class="fas fa-trash"></i> Xóa
				                    </button>
				                </td>
				            </tr>
				            <c:set var="totalPrice" value="${totalPrice + (cart.productPrice * cart.quantity)}" />
				        </c:forEach>
				    </tbody>
				</table>
    
                <div class="total-section">
                    <div class="total-price">
                        Tổng cộng: <span class="text-primary" id="total-price">${totalPrice}đ</span>
                    </div>
                </div>
    
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/danhmuc" class="btn btn-continue">
                        <i class="fas fa-arrow-left"></i>
                        Tiếp tục mua sắm
                    </a>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-checkout">
                        <i class="fas fa-credit-card"></i>
                        Thanh toán
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
        
    <script>
	    function updateTotal() {
	        let total = 0;
	        $('.select-item:checked').each(function() {
	            let row = $(this).closest('tr');
	            let itemTotalText = row.find('.item-total').text().replace('đ', '').trim();
	            let itemTotal = parseFloat(itemTotalText) || 0;
	            total += itemTotal;
	        });
	        $('#total-price').text(total + 'đ');
	    }
	
	    function updateSelectAll() {
	        let allChecked = $('.select-item').length === $('.select-item:checked').length;
	        $('#select-all').prop('checked', allChecked);
	    }
	
	    $(document).ready(function() {
	        // Thêm sự kiện cho checkbox
	        $('.select-item').on('change', function() {
	            updateTotal();
	            updateSelectAll();
	        });
	
	        $('#select-all').on('change', function() {
	            let isChecked = $(this).is(':checked');
	            $('.select-item').prop('checked', isChecked);
	            updateTotal();
	        });
	
	        // Hàm cập nhật giỏ hàng qua AJAX
	        function updateCart(cartId, quantity, colorId, sizeId, action) {
	            cartId = parseInt(cartId);
	            quantity = parseInt(quantity) || 1;
	            colorId = parseInt(colorId) || 0;
	            sizeId = parseInt(sizeId) || 0;
	
	            console.log('Sending data:', { action, cartId, quantity, colorId, sizeId });
	
	            $.ajax({
	                url: '${pageContext.request.contextPath}/giohang/updateAjax',
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                    action: action,
	                    cartId: cartId,
	                    quantity: quantity,
	                    colorId: colorId,
	                    sizeId: sizeId
	                }),
	                success: function(response) {
	                    if (response.success) {
	                        if (action === 'remove') {
	                            $('#cart-row-' + cartId).remove();
	                        } else {
	                            var row = $('#cart-row-' + cartId);
	                            row.find('.quantity-input input').val(quantity);
	                            row.find('.item-total').text(response.itemTotal + 'đ');
	                        }
	                        updateTotal(); // Cập nhật tổng tiền sau khi thay đổi
	                    } else {
	                        alert('Có lỗi xảy ra: ' + response.message);
	                    }
	                },
	                error: function(xhr) {
	                    alert('Có lỗi xảy ra khi gửi yêu cầu: ' + xhr.statusText);
	                }
	            });
	        }
	
	        // Sự kiện cho nút tăng/giảm số lượng
	        $('.quantity-input button').on('click', function() {
	            var input = $(this).siblings('input');
	            var currentQuantity = parseInt(input.val());
	            var newQuantity = currentQuantity + ($(this).text() === '+' ? 1 : -1);
	            if (newQuantity < 1) newQuantity = 1;
	            input.val(newQuantity);
	            
	            var row = $(this).closest('tr');
	            var cartId = row.attr('id').split('-')[2];
	            var colorId = row.find('.color-select').val();
	            var sizeId = row.find('.size-select').val();
	            
	            updateCart(cartId, newQuantity, colorId, sizeId, 'update');
	        });
	
	        // Sự kiện cho select box màu sắc
	        $('.color-select').on('change', function() {
	            var row = $(this).closest('tr');
	            var cartId = row.attr('id').split('-')[2];
	            var quantity = row.find('.quantity-input input').val();
	            var colorId = $(this).val();
	            var sizeId = row.find('.size-select').val();
	            
	            updateCart(cartId, quantity, colorId, sizeId, 'update');
	        });
	
	        // Sự kiện cho select box kích thước
	        $('.size-select').on('change', function() {
	            var row = $(this).closest('tr');
	            var cartId = row.attr('id').split('-')[2];
	            var quantity = row.find('.quantity-input input').val();
	            var colorId = row.find('.color-select').val();
	            var sizeId = $(this).val();
	            
	            updateCart(cartId, quantity, colorId, sizeId, 'update');
	        });
	    });
	
	    // Hàm xóa sản phẩm khỏi giỏ hàng
	    function removeFromCart(cartId) {
	        if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/giohang/delete/' + cartId,
	                type: 'DELETE',
	                success: function(response) {
	                    $('#cart-row-' + cartId).fadeOut(100, function() {
	                        $(this).remove();
	                        updateTotal(); // Cập nhật tổng tiền sau khi xóa
	                    });
	                },
	                error: function(xhr, status, error) {
	                    alert('Đã xảy ra lỗi khi xóa sản phẩm: ' + error);
	                }
	            });
	        }
	    }
	
	</script>
    
    <script>
	    /*
	    $(document).ready(function() {
	        // Hàm chung để gửi yêu cầu AJAX cập nhật giỏ hàng
	        function updateCart(cartId, quantity, colorId, sizeId, action) {
			    cartId = parseInt(cartId);
			    quantity = parseInt(quantity) || 1;
			    colorId = parseInt(colorId) || 0;
			    sizeId = parseInt(sizeId) || 0;
			
			    console.log('Sending data:', { action, cartId, quantity, colorId, sizeId });
			
			    $.ajax({
			        url: '${pageContext.request.contextPath}/giohang/updateAjax',
			        type: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify({
			            action: action,
			            cartId: cartId,
			            quantity: quantity,
			            colorId: colorId,
			            sizeId: sizeId
			        }),
			        success: function(response) {
			            if (response.success) {
			                if (action === 'remove') {
			                    $('#cart-row-' + cartId).remove();
			                } else {
			                    var row = $('#cart-row-' + cartId);
			                    row.find('.quantity-input input').val(quantity);
			                    row.find('.item-total').text(response.itemTotal + 'đ');
			                    $('#total-price').text(response.totalPrice + 'đ');
			                }
			            } else {
			                alert('Có lỗi xảy ra: ' + response.message);
			            }
			        },
			        error: function(xhr) {
			            alert('Có lỗi xảy ra khi gửi yêu cầu: ' + xhr.statusText);
			        }
			    });
			}
	
	        // Sự kiện cho nút tăng/giảm số lượng
	        $('.quantity-input button').on('click', function() {
	            var input = $(this).siblings('input');
	            var currentQuantity = parseInt(input.val());
	            var newQuantity = currentQuantity + ($(this).text() === '+' ? 1 : -1);
	            if (newQuantity < 1) newQuantity = 1;
	            input.val(newQuantity);
	            
	            var row = $(this).closest('tr');
	            var cartId = row.attr('id').split('-')[2];
	            var colorId = row.find('.color-select').val();
	            var sizeId = row.find('.size-select').val();
	            
	            updateCart(cartId, newQuantity, colorId, sizeId, 'update');
	        });
	        
	    	
	
	        // Sự kiện cho select box màu sắc
	        $('.color-select').on('change', function() {
	            var row = $(this).closest('tr');
	            var cartId = row.attr('id').split('-')[2];
	            var quantity = row.find('.quantity-input input').val();
	            var colorId = $(this).val();
	            var sizeId = row.find('.size-select').val();
	            
	            updateCart(cartId, quantity, colorId, sizeId, 'update');
	        });
	
	        // Sự kiện cho select box kích thước
	        $('.size-select').on('change', function() {
	            var row = $(this).closest('tr');
	            var cartId = row.attr('id').split('-')[2];
	            var quantity = row.find('.quantity-input input').val();
	            var colorId = row.find('.color-select').val();
	            var sizeId = $(this).val();
	            
	            updateCart(cartId, quantity, colorId, sizeId, 'update');
	        });

	    });
	    
        function removeFromCart(cartId) {
            if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/giohang/delete/' + cartId,
                    type: 'DELETE',
                    success: function(response) {
                    	$('#cart-row-' + cartId).fadeOut(100, function() {
                            $(this).remove();
                            updateTotalPrice();
                        });
                    },
                    error: function(xhr, status, error) {
                        alert('Đã xảy ra lỗi khi xóa sản phẩm: ' + error);
                    }
                });
            }
        }

        */
    </script>    
</body>
</html>