<%-- sidebar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style type="text/css">
    <%@ include file="/static/css/sidebar.css" %>
</style>

<div class="sidebar">
    <div class="sidebar-content">
        <div class="home-container">
            <!--<form action="${pageContext.request.contextPath}/admin/trangchu" method=get>
                <button type="submit" class="home-button">
                    <i class="fas fa-home"></i>
                    <span>Trang Chủ</span>
                </button>
            </form>
            -->
            <a href="${pageContext.request.contextPath}/admin/trangchu" class="home-button">
		        <i class="fas fa-home"></i>
		        <span>Trang Chủ</span>
		    </a>
            
        </div>
        
        <ul>
            <li class="dropdown ${pageToShow == 'danhmuc' || pageToShow == 'themdanhmuc' ? 'open active' : ''}">
                <a href="#" class="dropdown-toggle">
                    <i class="fas fa-list"></i>
                    <span>Danh Mục</span>
                </a>
                <ul>
                    <li class="${pageToShow == 'themdanhmuc' ? 'active' : ''}">
                        <form action="${pageContext.request.contextPath}/admin/themdanhmuc" method="get">
                            <button type="submit" >
                                <i class="fas fa-plus-circle"></i>
                                <span>Thêm Danh Mục</span>
                            </button>
                        </form>
                    </li>
                    <li class="${pageToShow == 'danhmuc' ? 'active' : ''}">
                        <form action="${pageContext.request.contextPath}/admin/danhmucsanpham" method="get">
                            <button type="submit">
                                <i class="fas fa-th-list"></i>
                                <span>Danh Sách Danh Mục</span>
                            </button>
                        </form>
                    </li>
                </ul>
            </li>
            
            <li class="dropdown ${pageToShow == 'sanpham' || pageToShow == 'themsanpham' ? 'open active' : ''}">
                <a href="#" class="dropdown-toggle">
                    <i class="fas fa-tshirt"></i>
                    <span>Sản Phẩm</span>
                </a>
                <ul>
                    <li class="${pageToShow == 'themsanpham' ? 'active' : ''}">
                        <form action="${pageContext.request.contextPath}/admin/themsanpham" method="get">
                            <button type="submit">
                                <i class="fas fa-plus-circle"></i>
                                <span>Thêm Sản Phẩm</span>
                            </button>
                        </form>
                    </li>
                    <li class="${pageToShow == 'sanpham' ? 'active' : ''}">
                        <form action="${pageContext.request.contextPath}/admin/danhsachsanpham" method="get">
                            <button type="submit" >
                                <i class="fas fa-th-list"></i>
                                <span>Danh Sách Sản Phẩm</span>
                            </button>
                        </form>
                    </li>
                </ul>
            </li>
            
            <li class="${pageToShow == 'nguoidung' ? 'active' : ''}">
                <form action="${pageContext.request.contextPath}/admin/nguoidung" method="get">
                    <button type="submit" >
                        <i class="fas fa-users"></i>
                        <span>Người Dùng</span>
                    </button>
                </form>
            </li>
            
            <li class="${pageToShow == 'baiviet' ? 'active' : ''}">
                <form action="${pageContext.request.contextPath}/admin/baiviet" method="get">
                    <button type="submit">
                        <i class="fas fa-newspaper"></i>
                        <span>Bài Viết</span>
                    </button>
                </form>
            </li>
            
            <li class="${pageToShow == 'hoadon' ? 'active' : ''}">
                <form action="${pageContext.request.contextPath}/admin/hoadon" method="get">
                    <button type="submit">
                        <i class="fas fa-file-invoice"></i>
                        <span>Hóa Đơn</span>
                    </button>
                </form>
            </li>
            
            <li class="${pageToShow == 'thongke' ? 'active' : ''}">
                <form action="${pageContext.request.contextPath}/admin/thongke" method="get">
                    <button type="submit">
                        <i class="fas fa-chart-bar"></i>
                        <span>Thống Kê</span>
                    </button>
                </form>
            </li>
        </ul>
    </div>
    
    <div class="sidebar-footer">
        <button class="logout-button" onclick="location.href='/admin/logout'">
            <i class="fas fa-sign-out-alt"></i>
            <span>Đăng Xuất</span>
        </button>
        <div class="version">Version 2.0</div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Dropdown toggle functionality
        document.querySelectorAll('.sidebar .dropdown-toggle').forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const parentLi = this.parentElement;
                parentLi.classList.toggle('open');
                
                // Close other dropdowns
                document.querySelectorAll('.sidebar .dropdown').forEach(li => {
                    if (li !== parentLi) {
                        li.classList.remove('open');
                    }
                });
            });
        });

        // Active state for sidebar items
        const sidebarLinks = document.querySelectorAll('.sidebar ul li a, .sidebar ul li button');
        sidebarLinks.forEach(link => {
            link.addEventListener('click', function() {
                sidebarLinks.forEach(l => l.parentElement.classList.remove('active'));
                this.parentElement.classList.add('active');
                
                const parentLi = this.closest('.dropdown');
                if (parentLi) {
                    parentLi.querySelectorAll('ul li').forEach(sibling => {
                        if (sibling !== this.parentElement) {
                            sibling.classList.remove('active');
                        }
                    });
                }
            });
        });
    });
</script>