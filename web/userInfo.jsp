<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心 - 到哪旅行</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .user-center {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 30px;
            margin-top: 20px;
        }
        .sidebar {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .user-avatar {
            text-align: center;
            margin-bottom: 30px;
        }
        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #007bff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            margin: 0 auto 15px;
        }
        .user-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .user-email {
            color: #666;
            font-size: 14px;
        }
        .nav-menu {
            list-style: none;
        }
        .nav-menu li {
            margin-bottom: 10px;
        }
        .nav-menu a {
            display: block;
            padding: 12px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        .nav-menu a:hover, .nav-menu a.active {
            background: #007bff;
            color: white;
        }
        .content {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .section {
            display: none;
        }
        .section.active {
            display: block;
        }
        .section-title {
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .info-item {
            margin-bottom: 20px;
        }
        .info-label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
        .info-value {
            color: #333;
        }
        .edit-btn, .publish-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 14px;
            transition: background 0.3s ease;
        }
        .edit-btn:hover, .publish-btn:hover {
            background: #0056b3;
        }
        .publish-btn {
            background: #28a745;
        }
        .publish-btn:hover {
            background: #218838;
        }
        .item-list {
            display: grid;
            gap: 15px;
        }
        .item-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #007bff;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .item-card:hover {
            transform: translateX(5px);
            background: #e7f3ff;
        }
        .item-title {
            font-weight: bold;
            margin-bottom: 8px;
            font-size: 16px;
        }
        .item-meta {
            color: #666;
            font-size: 14px;
            display: flex;
            gap: 15px;
        }
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }
        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }
        .logout-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 30px;
            width: 100%;
            transition: background 0.3s ease;
        }
        .logout-btn:hover {
            background: #c82333;
        }
        .back-btn {
            background: #c4c4c4;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 30px;
            width: 100%;
            transition: background 0.3s ease;
        }
        .back-btn:hover {
            background: #908e8e;
        }
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        .note-status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            margin-left: 10px;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-approved {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }
        .form-hint {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
        }
        .file-upload {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .file-name {
            color: #666;
            font-size: 14px;
        }

        input[type="file"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background: white;
        }
        @media (max-width: 768px) {
            .user-center {
                grid-template-columns: 1fr;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- 显示成功/错误消息 -->
    <c:if test="${not empty success}">
        <div class="success-message">
                ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error-message">
                ${error}
        </div>
    </c:if>

    <div class="user-center">
        <!-- 侧边栏 -->
        <div class="sidebar">
            <div class="user-avatar">
                <div class="avatar">
                    ${sessionScope.userInfo.username.substring(0,1).toUpperCase()}
                </div>
                <div class="user-name">${sessionScope.userInfo.username}</div>
            </div>
            <ul class="nav-menu">
                <li><a href="#" onclick="showSection('publish')">发布游记</a></li>
                <li><a href="#" onclick="showSection('myNotes')">我的游记</a></li>
                <li><a href="#" onclick="showSection('likes')">我的点赞</a></li>
                <li><a href="#" onclick="showSection('collections')">我的收藏</a></li>
                <li><a href="#" onclick="showSection('edit')">修改信息</a></li>
            </ul>
            <button class="back-btn" onclick="backHome()">返回主页</button>
            <button class="logout-btn" onclick="logout()">退出登录</button>
        </div>

        <div class="content">
            <!-- 发布游记 -->
            <div class="section active" id="publish-section">
                <h2 class="section-title">发布游记</h2>
                <form id="publishForm" method="post" action="PublishNote" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">游记标题 *</label>
                        <input type="text" id="title" name="title" placeholder="请输入游记标题" maxlength="200" required>
                    </div>
                    <div class="form-group">
                        <label for="cityname">所在城市 *</label>
                        <input type="text" id="cityname" name="cityname" placeholder="请输入城市名称" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <label for="summary">内容摘要</label>
                        <textarea id="summary" name="summary" placeholder="请输入游记摘要"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="content">游记内容 *</label>
                        <textarea id="content" name="content" placeholder="请输入详细的游记内容" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="pic">选择图片：</label>
                        <div class="file-upload">
                            <input type="file" id="pic" name="pic" onchange="document.getElementById('fileName').textContent = this.files[0]?.name || '未选择文件'">

                        </div>
                    </div>
                    <button type="submit" class="publish-btn" onclick="publishNote()">发布游记</button>
                </form>
            </div>

            <!-- 我的游记 -->
            <div class="section" id="myNotes-section">
                <h2 class="section-title">我的游记</h2>
                <div class="item-list">
                    <c:choose>
                        <c:when test="${not empty myNotes}">
                            <c:forEach items="${myNotes}" var="note">
                                <div class="item-card" onclick="viewNote(${note.id})">
                                    <div class="item-title">
                                            ${note.title}
                                        <span class="note-status status-${note.status == '已通过' ? 'approved' : note.status == '待审核' ? 'pending' : 'rejected'}">
                                                ${note.status}
                                        </span>
                                    </div>
                                    <div class="item-meta">
                                        <span>城市: ${note.cityname}</span>
                                        <span>时间: ${note.createTime}</span>
                                    </div>
                                    <c:if test="${not empty note.summary}">
                                        <div style="color: #666; font-size: 14px; margin-top: 8px;">
                                                ${note.summary}
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <h3>暂无游记</h3>
                                <p>您还没有发布过任何游记</p>
                                <button type="button" class="publish-btn" onclick="showSection('publish')" style="margin-top: 15px;">立即发布</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 我的点赞 -->
            <div class="section" id="likes-section">
                <h2 class="section-title">我的点赞</h2>
                <div class="item-list">
                    <c:choose>
                        <c:when test="${not empty likedNotes}">
                            <c:forEach items="${likedNotes}" var="note">
                                <div class="item-card" onclick="viewNote(${note.id})">
                                    <div class="item-title">${note.title}</div>
                                    <div class="item-meta">
                                        <span>作者: ${note.username}</span>
                                        <span>城市: ${note.cityname}</span>
                                        <span>时间: ${note.createTime}</span>
                                    </div>
                                    <c:if test="${not empty note.summary}">
                                        <div style="color: #666; font-size: 14px; margin-top: 8px;">
                                                ${note.summary}
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <h3>暂无点赞内容</h3>
                                <p>您还没有点赞过任何游记</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 我的收藏 -->
            <div class="section" id="collections-section">
                <h2 class="section-title">我的收藏</h2>
                <div class="item-list">
                    <c:choose>
                        <c:when test="${not empty collectedAttractions}">
                            <c:forEach items="${collectedAttractions}" var="attraction">
                                <div class="item-card" onclick="viewAttraction(${attraction.id})">
                                    <div class="item-title">${attraction.name}</div>
                                    <div class="item-meta">
                                        <span>地址: ${attraction.address}</span>
                                        <span>评分: ⭐ ${attraction.rating}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <h3>暂无收藏内容</h3>
                                <p>您还没有收藏过任何景点</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 修改信息 -->
            <div class="section" id="edit-section">
                <h2 class="section-title">修改个人信息</h2>
                <form id="editForm" method="post" action="UpdateUser">
                    <div class="form-group">
                        <label for="username">用户名</label>
                        <input type="text" id="username" name="username" value="${sessionScope.userInfo.username}" required>
                    </div>
                    <div class="form-group">
                        <label for="password">新密码（为空不修改）</label>
                        <input type="password" id="password" name="password" placeholder="输入新密码">
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">确认新密码</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="再次输入新密码">
                    </div>
                    <button type="button" class="edit-btn" onclick="updateProfile()">保存修改</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    document.addEventListener('DOMContentLoaded', function() {
        showSection('publish');
    });

    function showSection(section) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.querySelectorAll('.nav-menu a').forEach(a => a.classList.remove('active'));

        document.getElementById(section + '-section').classList.add('active');
        event.target.classList.add('active');
    }

    function viewNote(noteId) {
        window.location.href = 'QueryNoteById?id=' + noteId;
    }

    function viewAttraction(attractionId) {
        window.location.href = 'QueryAttractionsByCity?id=' + attractionId;
    }

    function publishNote() {
        const form = document.getElementById('publishForm');
        const title = document.getElementById('title').value.trim();
        const cityname = document.getElementById('cityname').value.trim();
        const content = document.getElementById('content').value.trim();

        if (!title) {
            alert('请输入游记标题');
            return;
        }

        if (!cityname) {
            alert('请输入所在城市');
            return;
        }

        if (!content) {
            alert('请输入游记内容');
            return;
        }

        form.submit();

    }

    function updateProfile() {
        const form = document.getElementById('editForm');
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (!username) {
            alert('用户名不能为空');
            return;
        }

        if (password && password !== confirmPassword) {
            alert('两次输入的密码不一致');
            return;
        }

        if (password && password.length < 6) {
            alert('密码长度不能少于6位');
            return;
        }

        form.submit();
    }
    function backHome() {
            location.href = 'Home';
    }
    function logout() {
        if (confirm('确定要退出登录吗？')) {
            window.location.href = 'logout.jsp';
        }
    }
</script>
</body>
</html>