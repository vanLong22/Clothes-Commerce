<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theo dõi Đơn hàng - ShopName</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Helvetica Neue', sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 20px;
        }

        .order-header {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .checkmark {
            font-size: 4rem;
            color: #4CAF50;
            margin-bottom: 1rem;
        }

        .progress-steps {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin: 2rem 0;
            padding: 2rem 0;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 1;
            width: 25%;
        }

        .step-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .step.active .step-icon {
            background: #4CAF50;
            color: white;
        }

        .step::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 3px;
            background: #ddd;
            top: 60%;
            left: 0;
            z-index: -1;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }

        .card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .product-list {
            list-style: none;
        }

        .product-item {
            display: flex;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }

        .product-item img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 1rem;
        }

        .countdown {
            font-size: 1.5rem;
            color: #4CAF50;
            text-align: center;
            padding: 1rem;
        }

        .support-section {
            text-align: center;
            margin: 2rem 0;
        }

        @media (max-width: 768px) {
            .progress-steps {
                flex-direction: column;
            }

            .step {
                width: 100%;
                margin-bottom: 2rem;
            }

            .step::after {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="order-header">
            <i class="fas fa-check-circle checkmark"></i>
            <h1>Cảm ơn bạn đã đặt hàng!</h1>
            <p>Mã đơn hàng: #123456</p>
            <div class="countdown" id="countdown">Giao hàng dự kiến trong: 24:00:00</div>
        </div>

        <div class="progress-steps">
            <div class="step active">
                <div class="step-icon"><i class="fas fa-shopping-cart"></i></div>
                <span>Đơn hàng đã đặt</span>
            </div>
            <div class="step">
                <div class="step-icon"><i class="fas fa-check"></i></div>
                <span>Xác nhận</span>
            </div>
            <div class="step">
                <div class="step-icon"><i class="fas fa-shipping-fast"></i></div>
                <span>Đang giao hàng</span>
            </div>
            <div class="step">
                <div class="step-icon"><i class="fas fa-box-open"></i></div>
                <span>Hoàn thành</span>
            </div>
        </div>

        <div class="order-details">
            <div class="card">
                <h2>Chi tiết đơn hàng</h2>
                <ul class="product-list">
                    <li class="product-item">
                        <img src="product1.jpg" alt="Product 1">
                        <div>
                            <h3>Tên sản phẩm 1</h3>
                            <p>Số lượng: 1</p>
                            <p>250,000₫</p>
                        </div>
                    </li>
                    <!-- Thêm các sản phẩm khác -->
                </ul>
                <div class="total">
                    <h3>Tổng cộng: 500,000₫</h3>
                </div>
            </div>

            <div class="card">
                <h2>Thông tin giao hàng</h2>
                <p>Người nhận: Nguyễn Văn A</p>
                <p>Địa chỉ: 123 Đường ABC, Quận XYZ, TP.HCM</p>
                <p>SĐT: 0909 123 456</p>
                <p>Phương thức thanh toán: COD</p>
            </div>
        </div>

        <div class="support-section">
            <p>Mọi thắc mắc vui lòng liên hệ <a href="tel:0909123456">0909 123 456</a></p>
            <button class="support-btn">Hỗ trợ khẩn cấp</button>
        </div>
    </div>

    <script>
        // Countdown timer
        let countdownTime = 24 * 60 * 60; // 24 giờ

        function updateCountdown() {
            const hours = Math.floor(countdownTime / 3600);
            const minutes = Math.floor((countdownTime % 3600) / 60);
            const seconds = countdownTime % 60;

            document.getElementById('countdown').innerHTML = 
                `Giao hàng dự kiến trong: ${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

            if (countdownTime <= 0) {
                clearInterval(timer);
                document.getElementById('countdown').innerHTML = "Đơn hàng đã được giao thành công!";
            } else {
                countdownTime--;
            }
        }

        let timer = setInterval(updateCountdown, 1000);

        // Simulate status updates
        const steps = document.querySelectorAll('.step');
        let currentStep = 0;

        function updateStatus() {
            if (currentStep < steps.length) {
                steps[currentStep].classList.add('active');
                currentStep++;
            }
        }

        // Simulate automatic status updates every 5 seconds
        setInterval(() => {
            if (currentStep < steps.length) {
                updateStatus();
            }
        }, 5000);
    </script>
</body>
</html>