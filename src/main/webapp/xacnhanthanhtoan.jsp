<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Thanh toán thành công - FashionBrand</title>
    <style>
        :root {
            --primary: #2A5C8D;
            --secondary: #F5A623;
            --success: #28A745;
            --light: #F8F9FA;
            --dark: #2C3E50;
        }

        .success-container {
            max-width: 800px;
            margin: 100px auto;
            padding: 2rem;
            text-align: center;
        }

        .success-icon {
            font-size: 4rem;
            color: var(--success);
            margin-bottom: 1.5rem;
            animation: bounce 1s ease;
        }

        .success-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            margin: 2rem 0;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            text-align: left;
            margin: 2rem 0;
        }

        .detail-group {
            background: var(--light);
            padding: 1.5rem;
            border-radius: 8px;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.8rem 2rem;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-outline {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: white;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-30px); }
            60% { transform: translateY(-15px); }
        }

        @media (max-width: 768px) {
            .order-details {
                grid-template-columns: 1fr;
            }
            
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="success-container">
        <i class="fas fa-check-circle success-icon"></i>
        <h1>Thanh toán thành công!</h1>
        <p>Cảm ơn bạn đã mua sắm tại FashionBrand</p>

        <div class="success-card">
            <h2>Thông tin đơn hàng</h2>
            <div class="order-details">
                <div class="detail-group">
                    <h3>Mã đơn hàng</h3>
                    <p>#DH${infoOrder.orderId}</p>
                </div>
                <div class="detail-group">
                    <h3>Ngày đặt hàng</h3>
                    <p><fmt:formatDate value="${infoOrder.createAt}"  /></p>
                </div>
                <div class="detail-group">
                    <h3>Tổng thanh toán</h3>
                    <p><fmt:formatNumber value="${infoOrder.totalPrice}" type="number"/> đ</p>
                </div>
                <div class="detail-group">
                    <h3>Phương thức thanh toán</h3>
                    <p>${infoOrder.method}</p>
                </div>
            </div>

            <div class="delivery-info">
                <h3>📦 Thông tin vận chuyển</h3>
                <p>Đơn hàng dự kiến sẽ được giao trong 3-5 ngày làm việc</p>
                <p>Người nhận: ${address.name}</p>
                <p>Địa chỉ: ${address.addressLine}</p>
            </div>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/thongtincanhan" class="btn btn-primary">
                    <i class="fas fa-clipboard-list"></i> Xem đơn hàng
                </a>
                <a href="${pageContext.request.contextPath}/trang-chu" class="btn btn-outline">
                    <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                </a>
            </div>
        </div>

        <div class="support-info">
            <p>📞 Cần hỗ trợ? Gọi ngay <strong>1900 1888</strong> (7:30 - 22:00)</p>
            <p>hoặc Email: <a href="mailto:support@fashionbrand.com">support@fashionbrand.com</a></p>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>