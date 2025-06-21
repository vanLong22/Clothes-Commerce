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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Đặt Hàng - FashionBrand</title>
    <style>
        :root {
            --primary: #2A5C8D;
            --secondary: #F5A623;
            --light: #F8F9FA;
            --dark: #2C3E50;
            --success: #28A745;
            --danger: #DC3545;
        }

        body {
            background: var(--light);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin-top: 90px;
        }

        .order-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 15px;
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 2rem;
        }

        .order-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .product-card {
            display: flex;
            gap: 1.5rem;
            padding: 1rem;
            border-bottom: 2px solid var(--light);
        }

        .product-image {
            width: 120px;
            height: 120px;
            border-radius: 8px;
            object-fit: cover;
        }

        .payment-methods {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
        }

        .payment-method {
            padding: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .payment-method.active {
            border-color: var(--primary);
            background: rgba(42, 92, 141, 0.05);
        }

        .order-summary {
            position: sticky;
            top: 100px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin: 1rem 0;
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
        }

        .total-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary);
        }

        .confirm-btn {
            width: 100%;
            padding: 1rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: opacity 0.3s ease;
        }

        .address-card {
            background: var(--light);
            border-radius: 8px;
            padding: 1.5rem;
            position: relative;
            margin-top: 1rem;
        }

        .address-info p {
            margin: 0.5rem 0;
            color: var(--dark);
        }

        .change-address-btn {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: none;
            border: none;
            color: var(--primary);
            cursor: pointer;
            font-weight: 600;
        }

        .add-address-btn {
            position: absolute;
            top: 1rem;
            right: 6rem;
            background: none;
            border: none;
            color: var(--primary);
            cursor: pointer;
            font-weight: 600;
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

        @media (max-width: 768px) {
            .order-container {
                grid-template-columns: 1fr;
            }
            
            .order-summary {
                position: static;
            }
        }

        .address-list {
            max-height: 60vh;
            overflow-y: auto;
        }

        .address-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .address-item:hover {
            background-color: #f8f9fa;
        }

        .address-content {
            flex: 1;
            margin-right: 1rem;
        }

        .select-address-btn {
            padding: 0.5rem 1rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="order-container">
        <!-- Left Column -->
        <div>
            <!-- Product Section -->
            <div class="order-card">
                <h2>Thông tin sản phẩm</h2>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}${product[0].image}" 
                         alt="${product[0].name}" 
                         class="product-image">
                    <div>
                        <h3>${product[0].name}</h3>
                        <p>Màu sắc: <strong>${color}</strong></p>
                        <p>Kích thước: <strong>${size}</strong></p>
                        <p>Số lượng: <strong>${quantity}</strong></p>
                        <p>Đơn giá: <fmt:formatNumber value="${product[0].price}" type="number"/> đ</p>
                    </div>
                </div>
            </div>

            <!-- Receiver Info -->
            <c:if test="${address != null && not empty address}">
                <div class="order-card">
                    <h2>Thông tin nhận hàng</h2>
                    <div class="address-card">
                        <button class="change-address-btn" onclick="showAddressModal()">Thay đổi</button>
                        <button class="add-address-btn" onclick="initializeAddressChange()">Tạo địa chỉ mới</button>
                        <div class="address-info">
                            <c:forEach var="addr" items="${address}">
                                <c:if test="${addr.isDefault}">
                                	<c:set var="addressId" value="${addr.id}" />
                                    <p>Tên người nhận hàng: <strong>${addr.name}</strong></p>
                                    <p>Số điện thoại: <strong>${addr.phone}</strong></p>
                                    <p>Địa chỉ: <strong>${addr.addressLine}</strong></p>
                                    <p class="text-muted">Ghi chú: ${not empty addr.note ? addr.note : 'Không có'}</p>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Modal chứa tất cả địa chỉ -->
                <div class="modal-overlay" id="addressListModal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3>Chọn địa chỉ giao hàng</h3>
                            <button class="modal-close" onclick="closeAddressListModal()">×</button>
                        </div>
                        <div class="address-list">
                            <c:forEach var="addr" items="${address}">
                                <div class="address-item" 
                                     data-id="${addr.id}"
                                     data-name="${addr.name}"
                                     data-phone="${addr.phone}"
                                     data-address="${addr.addressLine}"
                                     data-note="${addr.note}">
                                    <div class="address-content">
                                        <p><strong data-name>${addr.name}</strong></p>
                                        <p data-phone>${addr.phone}</p>
                                        <p data-address>${addr.addressLine}</p>
                                        <c:if test="${not empty addr.note}">
                                            <p class="text-muted" data-note>${addr.note}</p>
                                        </c:if>
                                    </div>
                                    <button class="select-address-btn">Chọn</button>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="modal-buttons">
                            <button class="btn btn-secondary" onclick="closeAddressListModal()">Đóng</button>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${address == null || empty address}">
                <div class="order-card">
                    <h2>Thông tin nhận hàng</h2>
                    <div class="form-group">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="address" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Ghi chú</label>
                        <textarea class="form-control" id="note" rows="3"></textarea>
                    </div>
                    <div class="modal-buttons">
		                <button class="btn btn-primary" onclick="saveAddress()">Lưu</button>
		            </div>
                </div>
            </c:if>

            <!-- Payment Methods -->
            <div class="order-card">
                <h2>Phương thức thanh toán</h2>
                <div class="payment-methods">
                    <div class="payment-method active" data-method="cod">
                        <i class="fas fa-money-bill-wave"></i>
                        <p>COD</p>
                        <small>Thanh toán khi nhận hàng</small>
                    </div>
                    <div class="payment-method" data-method="bank">
                        <i class="fas fa-university"></i>
                        <p>Chuyển khoản</p>
                        <small>Thanh toán qua VNPAY</small>
                    </div>
                    <div class="payment-method" data-method="wallet">
                        <i class="fas fa-wallet"></i>
                        <p>Ví điện tử</p>
                        <small>Thanh toán qua VNPAY</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Order Summary -->
        <div class="order-summary">
            <div class="order-card">
                <h2>Tóm tắt đơn hàng</h2>
                <div class="summary-item">
                    <span>Tạm tính:</span>
                    <span><fmt:formatNumber value="${product[0].price * quantity}" type="number"/> đ</span>
                </div>
                <div class="summary-item">
                    <span>Giảm giá:</span>
                    <span>0 đ</span>
                </div>
                <div class="summary-item">
                    <span>Phí vận chuyển:</span>
                    <span>0 đ</span>
                </div>
                <div class="summary-item total-price">
                    <span>Tổng cộng:</span>
                    <span><fmt:formatNumber value="${product[0].price * quantity}" type="number"/> đ</span>
                </div>
                <button class="confirm-btn" onclick="confirmOrder()">XÁC NHẬN ĐẶT HÀNG</button>
            </div>
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
    <c:set var="amount" value="${product[0].price * quantity}" />

    <script>
    $(document).ready(function() {
        // Payment method selection
        $('.payment-method').click(function() {
            $('.payment-method').removeClass('active');
            $(this).addClass('active');
        });

        // Address modal handling
        window.initializeAddressChange = function() {
            $('#modalName').val('');
            $('#modalPhone').val('');
            $('#modalAddress').val('');
            $('#modalNote').val('');
            $('#addressModal').addClass('show');
        };

        window.showAddressModal = function() {
            $('#addressListModal').addClass('show');
        };

        window.closeAddressListModal = function() {
            $('#addressListModal').removeClass('show');
        };

        window.closeAddressModal = function() {
            $('#addressModal').removeClass('show');
        };

        // Save address
        window.saveAddress = function() {
            const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
            const userId = localStorage.getItem("userId");
            if (!isLoggedIn || !userId) {
                showToast("Vui lòng đăng nhập để lưu địa chỉ.", 'error');
                return;
            }

            const name = $('#modalName').val();
            const phone = $('#modalPhone').val();
            const address = $('#modalAddress').val();
            const note = $('#modalNote').val();

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
                        showToast('Địa chỉ đã được lưu.', 'success');
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

        // Select address
        $('.select-address-btn').on('click', function() {
            const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
            const userId = localStorage.getItem("userId");
            if (!isLoggedIn || !userId) {
                showToast("Vui lòng đăng nhập để chọn địa chỉ.", 'error');
                return;
            }

            const addressItem = $(this).parent();
            const data = {
                userId: parseInt(userId),
                addressId: addressItem.data('id')
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/capnhatdiachimacdinhgiaohang',
                method: 'POST',
                data: data,
                success: function(result) {
                    location.reload();
                },
                error: function() {
                    showToast('Lỗi khi chọn địa chỉ.', 'error');
                }
            });
        });

        // Order confirmation
        window.confirmOrder = function() {
            const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
            const userId = localStorage.getItem("userId");
            if (!isLoggedIn || !userId) {
                showToast("Vui lòng đăng nhập để đặt hàng.", 'error');
                return;
            }
			
            const addressId = ${addressId};
            const productId = ${product[0].id};
            const quantity = ${quantity};
            const unitPrice = ${product[0].price};
            const totalPrice = quantity * unitPrice;
            const color = "${color}";
            const size = "${size}";
            const paymentMethod = $('.payment-method.active').data('method');
            const paymentStatus = paymentMethod === 'cod' ? 'Pending' : 'Pending';

            if (quantity <= 0 || quantity > ${product[0].quantity}) {
                showToast("Số lượng sản phẩm không hợp lệ.", 'error');
                return;
            }

            const orderData = {
                userId: parseInt(userId),
                addressId: addressId,
                totalPrice: totalPrice,
                status: paymentStatus
            };

            createOrderWithPayment(orderData, userId, totalPrice, status, addressId, productId, quantity, color, size, unitPrice, paymentMethod);
        };

        function createOrderWithPayment(orderData, userId, totalPrice, status, addressId, productId, quantity, color, size, unitPrice, paymentMethod) {
            $.ajax({
                url: "${pageContext.request.contextPath}/donhang",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(orderData),
                success: function(orderId) {
                    if (orderId > 0) {
                        const orderDetailData = {
                            orderId: orderId,
                            productId: productId,
                            quantity: quantity,
                            color: color,
                            size: size,
                            unitPrice: unitPrice
                        };

                        $.ajax({
                            url: "${pageContext.request.contextPath}/donhang/chitiet",
                            type: "POST",
                            contentType: "application/json",
                            data: JSON.stringify(orderDetailData),
                            success: function(result) {
                                if (result > 0) {
                                    $.ajax({
                                        url: "${pageContext.request.contextPath}/donhang/capnhatsoluong",
                                        type: "POST",
                                        contentType: "application/json",
                                        data: JSON.stringify({
                                            productId: productId,
                                            quantity: quantity
                                        }),
                                        success: function(updateResult) {
                                            if (updateResult > 0) {
                                                const paymentData = {
                                                    userId: parseInt(userId),
                                                    orderId: orderId,
                                                    discount: 0,
                                                    method: paymentMethod === 'cod' ? 'COD' : 
                                                            paymentMethod === 'bank' ? 'Bank Transfer' : 'Wallet',
                                                    status: paymentMethod === 'cod' ? 'Pending' : 'Pending'
                                                };

                                                $.ajax({
                                                    url: "${pageContext.request.contextPath}/thongtinthanhtoan",
                                                    type: "POST",
                                                    contentType: "application/json",
                                                    data: JSON.stringify(paymentData),
                                                    success: function(paymentResult) {
                                                        if (paymentResult > 0) {
                                                            if (paymentMethod === 'bank' || paymentMethod === 'wallet') {
                                                                $.ajax({
                                                                    url: '${pageContext.request.contextPath}/api/payment/create_payment',
                                                                    method: 'GET',
                                                                    data: { amount: totalPrice, orderId: orderId, addressId: addressId },
                                                                    dataType: 'json', // Đảm bảo parse JSON
                                                                    success: function(response) {
                                                                        if (response.status === 'Ok' && response.url) {
                                                                            showToast("Đang chuyển hướng đến VNPAY...", 'success');
                                                                            window.location.href = response.url;
                                                                        } else {
                                                                            showToast('Không thể tạo thanh toán VNPAY. Lỗi: ' + (response.message || 'Không rõ'), 'error');
                                                                        }
                                                                    },
                                                                    error: function(xhr, status, error) {
                                                                        showToast('Lỗi khi tạo thanh toán VNPAY: ' + error, 'error');
                                                                    }
                                                                });
                                                            } else {
                                                                showToast("Đặt hàng thành công!", 'success');
                                                                setTimeout(() => {
                                                                    window.location.href = "${pageContext.request.contextPath}/xacnhanthanhtoan?orderId=" + orderId + "&addressId=" + addressId;
                                                                }, 2000);
                                                            }
                                                        } else {
                                                            showToast("Lỗi khi lưu thông tin thanh toán.", 'error');
                                                        }
                                                    },
                                                    error: function() {
                                                        showToast("Lỗi khi lưu thông tin thanh toán.", 'error');
                                                    }
                                                });
                                            } else {
                                                showToast("Lỗi khi cập nhật số lượng sản phẩm.", 'error');
                                            }
                                        },
                                        error: function() {
                                            showToast("Lỗi khi cập nhật số lượng sản phẩm.", 'error');
                                        }
                                    });
                                } else {
                                    showToast("Lỗi khi tạo chi tiết đơn hàng.", 'error');
                                }
                            },
                            error: function() {
                                showToast("Lỗi khi tạo chi tiết đơn hàng.", 'error');
                            }
                        });
                    } else {
                        showToast("Lỗi khi tạo đơn hàng.", 'error');
                    }
                },
                error: function() {
                    showToast("Lỗi khi tạo đơn hàng.", 'error');
                }
            });
        }

        // Toast notification
        function showToast(message, type) {
            const toast = $('<div>').addClass(`toast ${type} show`).text(message);
            $('#toast').append(toast);
            setTimeout(() => {
                toast.removeClass('show');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
    });
</script>
</body>
</html>