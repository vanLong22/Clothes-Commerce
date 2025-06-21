<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Footer</title>
    <style>
        .footer {
            background-color: #111827;
            color: #fff;
            padding: 3rem 0;
            margin-top: 2rem;
        }

        .footer-container {
            max-width: 1280px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            padding: 0 1.5rem;
        }

        .footer-section {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .footer-heading {
            font-size: 1.125rem;
            font-weight: 600;
            color: #fff;
        }

        .footer-text {
            font-size: 0.875rem;
            color: #d1d5db;
            margin: 0;
        }

        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .footer-link {
            font-size: 0.875rem;
            color: #d1d5db;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-link:hover {
            color: #4f46e5;
        }

        .newsletter-form {
            display: flex;
            gap: 0.5rem;
        }

        .newsletter-input {
            padding: 0.5rem;
            border-radius: 0.375rem;
            border: none;
            outline: none;
            font-size: 0.875rem;
            flex: 1;
        }

        .newsletter-button {
            padding: 0.5rem 1rem;
            background-color: #4f46e5;
            color: #fff;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .newsletter-button:hover {
            background-color: #4338ca;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid #374151;
            margin-top: 2rem;
        }

        @media (max-width: 640px) {
            .footer-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <footer class="footer">
        <div class="footer-container">
            <!-- About Section -->
            <div class="footer-section">
                <h4 class="footer-heading">Về Chúng Tôi</h4>
                <p class="footer-text">
                    Fashion Store - Cung cấp thời trang nam và nữ chất lượng cao, phong cách hiện đại, giá cả hợp lý.
                </p>
            </div>

            <!-- Quick Links -->
            <div class="footer-section">
                <h4 class="footer-heading">Liên Kết Nhanh</h4>
                <ul class="footer-links">
                    <li><a href="/" class="footer-link">Trang Chủ</a></li>
                    <li><a href="/danhmuc" class="footer-link">Sản Phẩm</a></li>
                    <li><a href="/khuyenmai" class="footer-link">Khuyến Mãi</a></li>
                    <li><a href="/lienhe" class="footer-link">Liên Hệ</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="footer-section">
                <h4 class="footer-heading">Liên Hệ</h4>
                <p class="footer-text">Email: support@fashionstore.com</p>
                <p class="footer-text">Điện thoại: 0123 456 789</p>
                <p class="footer-text">Địa chỉ: 123 Đường Thời Trang, TP. Hồ Chí Minh</p>
            </div>

            <!-- Newsletter -->
            <div class="footer-section">
                <h4 class="footer-heading">Đăng Ký Nhận Tin</h4>
                <form class="newsletter-form">
                    <input type="email" placeholder="Nhập email của bạn" class="newsletter-input" required>
                    <button type="submit" class="newsletter-button">Đăng Ký</button>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <p class="footer-text">© <%= java.time.Year.now().getValue() %> Fashion Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>