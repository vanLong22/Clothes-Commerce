<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng | Fashion Shop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --primary: #5c6bc0;
            --primary-dark: #3f51b5;
            --primary-light: #7986cb;
            --secondary: #ff6f61;
            --success: #4caf50;
            --warning: #ff9800;
            --danger: #f44336;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --light-gray: #e9ecef;
            --border: #dee2e6;
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --hover-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: var(--dark);
            display: flex;
            height: 100vh;
            overflow: hidden;
            flex-direction: column;
        }
        

        .container {
            display: flex;
            flex: 1;
        }

        /* Main Content */
        .main-content {
            display: flex;
            flex: 1;
            padding: 20px;
        }

        .content-wrapper {
            flex: 1;
        }

        .content-area {
            background: white;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            animation: fadeInUp 0.5s ease;
        }

        .main-header {
            padding: 25px 30px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .main-title {
            font-size: 28px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .main-title i {
            background: rgba(255, 255, 255, 0.2);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stats {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.15);
            padding: 12px 24px;
            border-radius: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-width: 140px;
        }

        .stat-value {
            font-size: 22px;
            font-weight: 700;
        }

        .stat-label {
            font-size: 14px;
            opacity: 0.9;
        }

        /* Form Area */
        .form-section {
            padding: 30px;
            border-bottom: 1px solid var(--light-gray);
        }

        .form-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-title i {
            color: var(--primary);
        }

        .search-form {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .search-input-container {
            flex: 1;
            min-width: 300px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 14px 20px 14px 50px;
            border: 2px solid var(--light-gray);
            border-radius: 50px;
            font-size: 16px;
            transition: all 0.3s ease;
            outline: none;
            background: var(--light);
        }

        .search-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(92, 107, 192, 0.15);
        }

        .search-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            font-size: 18px;
        }

        .btn {
            padding: 14px 30px;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(45deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 4px 10px rgba(92, 107, 192, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(92, 107, 192, 0.4);
            background: linear-gradient(45deg, var(--primary-dark), var(--primary));
        }

        .btn-add {
            background: linear-gradient(45deg, var(--secondary), #ff4d40);
        }

        .btn-add:hover {
            background: linear-gradient(45deg, #ff4d40, var(--secondary));
        }

        /* Table */
        .table-section {
            padding: 0 30px 30px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        thead {
            background: linear-gradient(90deg, var(--dark), #343a59);
            color: white;
        }

        th {
            padding: 18px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 16px;
        }

        th:first-child {
            border-top-left-radius: 10px;
        }

        th:last-child {
            border-top-right-radius: 10px;
        }

        tbody tr {
            background: white;
            transition: all 0.3s ease;
            border-bottom: 1px solid var(--light-gray);
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8f9fe;
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--light-gray);
            font-size: 15px;
        }

        .user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(45deg, var(--warning), var(--danger));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 16px;
            margin-right: 12px;
        }

        .user-info-cell {
            display: flex;
            align-items: center;
        }

        .user-details {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-weight: 600;
            color: var(--dark);
            font-size: 16px;
        }

        .user-role {
            font-size: 13px;
            color: var(--gray);
            margin-top: 4px;
            background: var(--light);
            padding: 2px 8px;
            border-radius: 12px;
            display: inline-block;
            width: fit-content;
        }

        .user-role.admin {
            background: rgba(76, 175, 80, 0.15);
            color: var(--success);
        }

        .action-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            color: white;
            font-size: 16px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-edit {
            background: linear-gradient(45deg, var(--success), #2bbbad);
        }

        .btn-delete {
            background: linear-gradient(45deg, var(--danger), #ec0c38);
        }

        .btn-view {
            background: linear-gradient(45deg, var(--secondary), #00bcd4);
        }

        .btn-icon:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 8px;
            flex-wrap: wrap;
        }

        .pagination-button {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: white;
            border: 1px solid var(--light-gray);
            color: var(--dark);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .pagination-button:hover, .pagination-button.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            box-shadow: 0 4px 8px rgba(92, 107, 192, 0.3);
        }

        /* Modal */
        .modal {
		    display: none;
		    position: fixed;
		    z-index: 1000;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgba(0,0,0,0.4);
		}
		
		.modal-content {
		    background-color: #fefefe;
		    margin: 5% auto;
		    padding: 20px;
		    border: 1px solid #888;
		    width: 50%;
		    max-width: 600px;
		    border-radius: 5px;
		    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		}

        .close {
            color: #aaa;
            position: absolute;
            right: 25px;
            top: 20px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .close:hover {
            color: var(--dark);
            transform: rotate(90deg);
        }

        .modal-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-title i {
            background: rgba(92, 107, 192, 0.1);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: var(--primary);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid var(--light-gray);
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
            background: var(--light);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(92, 107, 192, 0.15);
            outline: none;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        .btn-cancel {
            background: var(--light-gray);
            color: var(--dark);
        }

        .btn-cancel:hover {
            background: #d1d3d8;
        }

        /* Animations */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 992px) {
            .content-wrapper {
                margin-left: 0;
            }
            
            .stats {
                justify-content: center;
                width: 100%;
            }
            
            .stat-item {
                flex: 1;
                min-width: 120px;
            }
        }

        @media (max-width: 768px) {
            .main-header {
                flex-direction: column;
                text-align: center;
                padding: 20px;
            }
            
            .main-title {
                justify-content: center;
            }
            
            .search-form {
                flex-direction: column;
            }
            
            .search-input-container {
                min-width: 100%;
            }
            
            .action-buttons {
                flex-wrap: wrap;
            }
            
            .modal-content {
                width: 95%;
                margin: 5% auto;
            }
        }
        
        @media (max-width: 576px) {
            .main-title {
                font-size: 22px;
            }
            
            .main-title i {
                width: 40px;
                height: 40px;
                font-size: 20px;
            }
            
            .form-section, .table-section {
                padding: 20px;
            }
            
            .form-title {
                font-size: 18px;
            }
            
            .pagination-button {
                width: 36px;
                height: 36px;
                font-size: 14px;
            }
            
            th, td {
                padding: 12px 15px;
                font-size: 14px;
            }
            
            .user-avatar {
                width: 36px;
                height: 36px;
                font-size: 14px;
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
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main-content">
            <div class="content-wrapper">
                <div class="content-area">
                    <!-- Header with Stats -->
                    <div class="main-header">
                        <div class="main-title">
                            <i class="fas fa-users"></i>
                            <span>Quản lý Người dùng</span>
                        </div>
                        <div class="stats">
                            <div class="stat-item">
                                <span class="stat-value">${totalCustomers}</span>
                                <span class="stat-label">Tổng Người dùng</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-value">${totalAdmins}</span>
                                <span class="stat-label">Quản trị viên</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Search Form -->
                    <div class="form-section">
                        <div class="form-title">
                            <i class="fas fa-search"></i>
                            <span>Tìm kiếm Người dùng</span>
                        </div>
                        <form class="search-form" action="${pageContext.request.contextPath}/admin/nguoidung" method="get">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="size" value="${size}">
                            <div class="search-input-container">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" name="search" value="${param.search}" 
                                       placeholder="Tìm kiếm theo username, email..." 
                                       class="search-input">
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Tìm kiếm
                            </button>
                            <button type="button" class="btn btn-primary btn-add" 
                                    onclick="document.getElementById('addUserModal').style.display='block'">
                                <i class="fas fa-plus"></i> Thêm Người Dùng
                            </button>
                        </form>
                    </div>
                    
                    <!-- User Table -->
                    <div class="table-section">
                        <table>
                            <thead>
                                <tr>
                                    <th>Avatar</th>
                                    <th>Thông tin</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Địa chỉ</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty users}">
                                        <tr>
                                            <td colspan="6" style="text-align: center; padding: 30px;">
                                                <i class="fas fa-user-slash" style="font-size: 48px; color: var(--light-gray); margin-bottom: 15px;"></i>
                                                <h3 style="color: var(--gray);">Không tìm thấy người dùng nào</h3>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="user" items="${users}">
                                            <tr>
                                                <td>
                                                    <div class="user-avatar">
                                                        ${fn:toUpperCase(fn:substring(user.username, 0, 1))}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="user-info-cell">
                                                        <div class="user-details">
                                                            <div class="user-name">${user.username}</div>
                                                            <div class="user-role ${user.role == 'admin' ? 'admin' : ''}">
                                                                ${user.role == 'admin' ? 'Quản trị viên' : 'Người dùng'}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${user.email}</td>
                                                <td>${user.phone}</td>
                                                <td>${user.address}</td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <button class="btn-icon btn-edit" 
                                                                onclick="openEditModal('${user.id}', '${user.username}', '${user.email}', '${user.phone}', '${user.address}', '${user.role}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn-icon btn-delete" 
                                                                onclick="openDeleteModal('${user.id}', '${user.username}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>

                        <!-- Pagination -->
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <a href="${pageContext.request.contextPath}/admin/nguoidung?page=${i}&size=${size}&search=${param.search}" 
                                   class="pagination-button ${i == currentPage ? 'active' : ''}">
                                    ${i}
                                </a>
                            </c:forEach>
                        </fsdiv>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('addUserModal')">×</span>
            <h2 class="modal-title"><i class="fas fa-user-plus"></i> Thêm Người Dùng</h2>
            <form action="${pageContext.request.contextPath}/admin/nguoidung/add" method="post">
                <div class="form-group">
                    <label class="form-label" for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label" for="address">Address:</label>
                    <input type="text" id="address" name="address" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label" for="role">Role:</label>
                    <select id="role" name="role" class="form-control">
                        <option value="user">Người dùng</option>
                        <option value="admin">Quản trị viên</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Thêm người dùng</button>
                    <button type="button" class="btn btn-cancel" onclick="closeModal('addUserModal')">Hủy bỏ</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editUserModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('editUserModal')">×</span>
            <h2 class="modal-title"><i class="fas fa-user-edit"></i> Sửa Người Dùng</h2>
            <form action="${pageContext.request.contextPath}/admin/nguoidung/edit" method="post">
                <input type="hidden" id="editUserId" name="id">
                <div class="form-group">
                    <label class="form-label" for="editUsername">Username:</label>
                    <input type="text" id="editUsername" name="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="editPassword">Password (để trống nếu không thay đổi):</label>
                    <input type="password" id="editPassword" name="password" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editEmail">Email:</label>
                    <input type="email" id="editEmail" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="editPhone">Phone:</label>
                    <input type="text" id="editPhone" name="phone" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editAddress">Address:</label>
                    <input type="text" id="editAddress" name="address" class="form-control">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editRole">Role:</label>
                    <select id="editRole" name="role" class="form-control">
	                    <option value="customer" ${role == 'customer' ? 'selected' : ''}>Người dùng</option>
	                    <option value="admin" ${role == 'admin' ? 'selected' : ''}>Quản trị viên</option>
	                </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    <button type="button" class="btn btn-cancel" onclick="closeModal('editUserModal')">Hủy bỏ</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete User Modal -->
    <div id="deleteUserModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('deleteUserModal')">×</span>
            <h2 class="modal-title"><i class="fas fa-exclamation-triangle"></i> Xác Nhận Xóa</h2>
            <p style="margin: 20px 0; font-size: 16px; line-height: 1.6;">
                Bạn có chắc muốn xóa người dùng <strong><span id="deleteUsername"></span></strong>?
                <br>
                <span style="color: var(--danger);">Hành động này không thể hoàn tác!</span>
            </p>
            <form id="deleteForm" action="${pageContext.request.contextPath}/admin/nguoidung/delete" method="post">
                <input type="hidden" id="deleteUserId" name="id">
                <div class="form-actions">
                    <button type="submit" class="btn btn-delete">Xóa vĩnh viễn</button>
                    <button type="button" class="btn btn-cancel" onclick="closeModal('deleteUserModal')">Hủy bỏ</button>
                </div>
            </form>
        </div>
    </div>

	<!--notification container -->
    <div id="toast"></div>
    
<script>
// Modal functions
function openEditModal(id, username, email, phone, address, role) {
    document.getElementById('editUserId').value = id;
    document.getElementById('editUsername').value = username;
    document.getElementById('editEmail').value = email;
    document.getElementById('editPhone').value = phone || '';
    document.getElementById('editAddress').value = address || '';
    document.getElementById('editRole').value = role;
    document.getElementById('editUserModal').style.display = 'block';
}

function openDeleteModal(id, username) {
    document.getElementById('deleteUserId').value = id;
    document.getElementById('deleteUsername').textContent = username;
    document.getElementById('deleteUserModal').style.display = 'block';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Close modal when clicking outside
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        document.querySelectorAll('.modal').forEach(modal => {
            modal.style.display = 'none';
        });
    }
}

// Add animation to table rows
document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('tbody tr');
    rows.forEach((row, index) => {
        row.style.animationDelay = `${index * 0.05}s`;
        row.classList.add('animated-row');
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

// Xử lý AJAX cho các thao tác
$(document).ready(function() {
    // Thêm người dùng
    $('#addUserModal form').submit(function(event) {
        event.preventDefault();
        var userData = {
            username: $('#username').val(),
            password: $('#password').val(),
            email: $('#email').val(),
            phone: $('#phone').val() || null,
            address: $('#address').val() || null,
            role: $('#role').val()
        };
        
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/nguoidung/add',
            contentType: 'application/json',
            data: JSON.stringify(userData),
            dataType: 'json',
            success: function(response) {
                showToast(response.message, response.success ? 'success' : 'error');
                if (response.success) {
                	sessionStorage.setItem('userAdded', 'true');
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                showToast('Đã xảy ra lỗi khi thêm người dùng: ' + error, 'error');
            }
        });
    });
    
 	// Hiển thị thông báo nếu vừa thêm người dùng
    if (sessionStorage.getItem('userAdded') === 'true') {
        showToast('Thêm người dùng thành công', 'success');
        sessionStorage.removeItem('userAdded');
    }

    // Sửa người dùng
    $('#editUserModal form').submit(function(event) {
        event.preventDefault();
        var userData = {
            id: parseInt($('#editUserId').val()),
            username: $('#editUsername').val(),
            password: $('#editPassword').val() || null,
            email: $('#editEmail').val(),
            phone: $('#editPhone').val() || null,
            address: $('#editAddress').val() || null,
            role: $('#editRole').val()
        };
        
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/nguoidung/edit',
            contentType: 'application/json',
            data: JSON.stringify(userData),
            dataType: 'json',
            success: function(response) {
                showToast(response.message, response.success ? 'success' : 'error');
                if (response.success) {
                	sessionStorage.setItem('userUpdated', 'true');
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                showToast('Đã xảy ra lỗi khi sửa người dùng: ' + error, 'error');
            }
        });
    });
    
	// Hiển thị thông báo nếu vừa cập nhật thông tin người dùng
    if (sessionStorage.getItem('userUpdated') === 'true') {
        showToast('Cập nhật thông tin người dùng thành công', 'success');
        sessionStorage.removeItem('userUpdated');
    }

    // Xóa người dùng
    $('#deleteForm').submit(function(event) {
        event.preventDefault();
        var userId = $('#deleteUserId').val();
        
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin/nguoidung/delete',
            data: { id: userId },
            dataType: 'json',
            success: function(response) {
                showToast(response.message, response.success ? 'success' : 'error');
                if (response.success) {
                	sessionStorage.setItem('userDeleted', 'true');
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                showToast('Đã xảy ra lỗi khi xóa người dùng: ' + error, 'error');
            }
        });
    });
    
 	// Hiển thị thông báo nếu vừa xóa người dùng
    if (sessionStorage.getItem('userDeleted') === 'true') {
        showToast('Xóa người dùng thành công.', 'success');
        sessionStorage.removeItem('userDeleted');
    }
});
</script>
</body>
</html>