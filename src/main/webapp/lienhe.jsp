<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên Hệ</title>
	<link rel="stylesheet" href="styles.css">
	<link rel="stylesheet" href="lienhe.css">
	<style type="text/css">
		<%@include file="static/css/lienhe.css" %>
	</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
    <div class="container-lienhe">
        <img src="assets//img_lienhe//map.png" alt="Map" class="map">

        <div class="contact-section">
            <div class="contact-form">
				<h2>GỬI YÊU CẦU</h2>
				<form method="POST" action="lienhe.php"  >
					<label for="name">Tên</label>
					<input type="text" id="name" name="name" required>
					<label for="phone">Số Điện Thoại</label>
					<input type="text" id="phone" name="phone" required>
					<label for="address">Địa Chỉ</label>
					<input type="text" id="address" name="address">
					<label for="email">Email</label>
					<input type="email" id="email" name="email" required>
					<label for="message">Tin Nhắn</label>
					<textarea id="message" name="message" rows="4"></textarea>
					<button type="submit" name="contact">Gửi</button>
				</form>
			</div>
            <div class="contact-info">
                <h2>THÔNG TIN LIÊN HỆ</h2>
                <p><strong>Quảng Trị:</strong> <br> Hải An - Hải Lăng - Quảng Trị<br>034 695 8242</p>
                <p><strong>Đà Nẵng:</strong> <br> Hải Châu - Đà Nẵng<br>+84 695 824 252</p>
                <p><strong>TP.Hồ Chí Minh:</strong> <br> Q8 - TP.Hồ Chí Minh<br>+84 695 824 252</p>
            </div>
        </div>
    </div>

	
	<jsp:include page="footer.jsp"></jsp:include>
	
</body>
</html>
    