<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }

        .admin-header {
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            opacity: 0.95;
        }
        .admin-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 50px;
            height: 70px;
        }
        .admin-logo {
            font-size: 24px;
            font-weight: bold;
            color: #156eee;
        }
        .admin-title {
            font-size: 20px;
            color: #333;
        }
        .admin-user-area {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .admin-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #156eee, #22b5fa);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .admin-container {
            display: flex;
            margin-top: 70px;
            min-height: calc(100vh - 70px);
        }
        .admin-sidebar {
            width: 220px;
            background: linear-gradient(180deg, #2c3e50 0%, #1a252f 100%);
            color: white;
            padding: 20px 0;
            position: fixed;
            height: calc(100vh - 70px);
            overflow-y: auto;
        }
        .admin-menu {
            margin-top: 20px;
        }
        .admin-menu-item {
            padding: 15px 25px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            text-decoration: none;
            border-left: 4px solid transparent;
        }
        .admin-menu-item:hover {
            background-color: rgba(52, 152, 219, 0.1);
            border-left: 4px solid #3498db;
        }
        .admin-menu-item.active {
            background-color: rgba(52, 152, 219, 0.2);
            border-left: 4px solid #3498db;
        }
        .menu-icon {
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        .admin-content {
            flex: 1;
            padding: 30px;
            margin-left: 220px;
            width: calc(100% - 220px);
        }

        .admin-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            border-top: 4px solid #156eee;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .stat-card h3 {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
        }
        .stat-trend {
            font-size: 14px;
            color: #2ecc71;
            margin-top: 5px;
        }

        .admin-section {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            display: none;
        }
        .admin-section.active {
            display: block;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .section-title {
            font-size: 20px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-title::before {
            content: '';
            width: 4px;
            height: 20px;
            background: #156eee;
            border-radius: 2px;
        }

        .admin-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #156eee, #22b5fa);
            color: white;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #0d5dc5, #1a9de0);
            transform: translateY(-2px);
        }
        .btn-success {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
        }
        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #d68910);
            color: white;
        }
        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .admin-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .admin-table th {
            background: linear-gradient(135deg, #156eee, #22b5fa);
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: 500;
        }
        .admin-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        .admin-table tr:hover {
            background-color: #f8f9fa;
        }
        .status-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-approved {
            background: #d4edda;
            color: #155724;
        }
        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            outline: none;
            border-color: #156eee;
            box-shadow: 0 0 0 2px rgba(21, 110, 238, 0.1);
        }
        .form-textarea {
            min-height: 120px;
            resize: vertical;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .action-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            border: 1px solid #f0f0f0;
        }
        .action-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: #156eee;
        }
        .action-icon {
            font-size: 28px;
            margin-bottom: 10px;
            color: #156eee;
        }

        @media (max-width: 768px) {
            .admin-nav {
                padding: 0 20px;
            }
            .admin-sidebar {
                width: 60px;
            }
            .admin-content {
                margin-left: 60px;
                width: calc(100% - 60px);
                padding: 20px;
            }
            .admin-menu-item span:not(.menu-icon) {
                display: none;
            }
            .admin-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<header class="admin-header">
    <nav class="admin-nav">
        <div class="admin-logo">到哪旅行网</div>
        <div class="admin-title">后台管理系统</div>
        <div class="admin-user-area">
            <div class="admin-avatar">${sessionScope.userInfo.username.charAt(0)}</div>
            <span>管理员：${sessionScope.userInfo.username}</span>
            <a href="logout.jsp" class="admin-btn btn-danger">退出</a>
        </div>
    </nav>
</header>

<div class="admin-container">
    <aside class="admin-sidebar">
        <div class="admin-menu">
            <a href="AdminUserList?section=users" class="admin-menu-item">
                <span class="menu-icon">👥</span>
                <span>用户管理</span>
            </a>
            <a href="AdminAttractionList?section=attractions" class="admin-menu-item">
                <span class="menu-icon">📝</span>
                <span>景点管理</span>
            </a>
            <a href="AdminCityList?section=cities" class="admin-menu-item">
                <span class="menu-icon">🏙️</span>
                <span>城市管理</span>
            </a>
            <a href="AdminHotelList?section=hotels" class="admin-menu-item">
                <span class="menu-icon">🏨</span>
                <span>酒店管理</span>
            </a>
            <a href="AdminNoteReview?section=notes" class="admin-menu-item">
                <span class="menu-icon">✍️</span>
                <span>游记审核</span>
            </a>
        </div>
    </aside>

    <main class="admin-content">

        <!-- 用户管理 -->
        <section id="users" class="admin-section">
            <div class="section-header">
                <h2 class="section-title">用户管理</h2>
            </div>
            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty userList}">
                        <tr>
                            <td colspan="4" style="text-align: center; color: #666; padding: 30px;">
                                暂无用户数据
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.password}</td>
                                <td>
                                    <a href="AdminUpdateUser?id=${user.id}"
                                       class="admin-btn btn-warning btn-small">编辑</a>
                                    <a href="DeleteUser?id=${user.id}"
                                       class="admin-btn btn-danger btn-small">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

        <!-- 景点管理 -->
        <section id="attractions" class="admin-section">
            <div class="section-header">
                <h2 class="section-title">景点管理</h2>
                <button class="admin-btn btn-primary" onclick="showAddAttractionForm()">+ 添加景点</button>
            </div>

            <div id="addAttractionForm" style="display: none; background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                <h3>添加景点</h3>
                <form action="AdminAddAttraction" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label">景点名称</label>
                        <input type="text" name="name" class="form-control" placeholder="请输入景点名称" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">所属城市</label>
                        <select name="cityId" class="form-control" required>
                            <option value="">选择城市</option>
                            <c:forEach items="${cityList}" var="city">
                                <option value="${city.id}">${city.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">景点描述</label>
                        <textarea name="description" class="form-control form-textarea"
                                  placeholder="请输入景点描述" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">详细地址</label>
                        <input type="text" name="address" class="form-control" placeholder="请输入详细地址">
                    </div>
                    <div class="form-group">
                        <label class="form-label">评分</label>
                        <input type="number" name="rating" class="form-control"
                               placeholder="请输入评分（0-5分）" min="0" max="5" step="0.1" value="0">
                    </div>
                    <div class="form-group">
                        <label class="form-label">景点图片</label>
                        <input type="file" name="image" class="form-control">
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="admin-btn btn-success">添加景点</button>
                        <button type="button" class="admin-btn btn-danger" onclick="hideAddAttractionForm()">取消</button>
                    </div>
                </form>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>景点名称</th>
                    <th>所在城市</th>
                    <th>地址</th>
                    <th>评分</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty attractionList}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #666; padding: 30px;">
                                暂无景点数据
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${attractionList}" var="attraction">
                            <tr>
                                <td>${attraction.id}</td>
                                <td>${attraction.name}</td>
                                <td>
                                    <c:forEach items="${cityList}" var="city">
                                        <c:if test="${city.id == attraction.cityId}">${city.name}</c:if>
                                    </c:forEach>
                                </td>
                                <td>${attraction.address}</td>
                                <td>${attraction.rating}</td>
                                <td>
                                    <a href="AdminUpdateAttraction?id=${attraction.id}"
                                       class="admin-btn btn-warning btn-small">编辑</a>
                                    <a href="AdminDeleteAttraction?id=${attraction.id}"
                                       class="admin-btn btn-danger btn-small">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

        <!-- 城市管理 -->
        <section id="cities" class="admin-section">
            <div class="section-header">
                <h2 class="section-title">城市管理</h2>
                <button class="admin-btn btn-primary" onclick="showAddCityForm()">+ 添加城市</button>
            </div>

            <div id="addCityForm" style="display: none; background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                <h3>添加城市</h3>
                <form action="AdminAddCity" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label">城市名称</label>
                        <input type="text" name="name" class="form-control" placeholder="请输入城市名称" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">所属省份</label>
                        <input type="text" name="province" class="form-control" placeholder="请输入省份名称" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">城市描述</label>
                        <textarea name="description" class="form-control form-textarea"
                                  placeholder="请输入城市描述" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">最佳旅游季节</label>
                        <input type="text" name="bestSeason" class="form-control" placeholder="如：春、夏季">
                    </div>
                    <div class="form-group">
                        <label class="form-label">气候特点</label>
                        <input type="text" name="climate" class="form-control" placeholder="如：温带季风气候">
                    </div>
                    <div class="form-group">
                        <label class="form-label">旅行贴士</label>
                        <textarea name="travelTips" class="form-control form-textarea"
                                  placeholder="请输入旅行注意事项" rows="2"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">是否推荐</label>
                        <select name="isRecommended" class="form-control">
                            <option value="0">不推荐</option>
                            <option value="1">推荐</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">封面图片</label>
                        <input type="file" name="coverImage" class="form-control" accept="image/*">
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="admin-btn btn-success">添加城市</button>
                        <button type="button" class="admin-btn btn-danger" onclick="hideAddCityForm()">取消</button>
                    </div>
                </form>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>城市名称</th>
                    <th>所属省份</th>
                    <th>最佳季节</th>
                    <th>是否推荐</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty cityList}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #666; padding: 30px;">
                                暂无城市数据
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${cityList}" var="city">
                            <tr>
                                <td>${city.id}</td>
                                <td>${city.name}</td>
                                <td>${city.province}</td>
                                <td>${city.bestSeason}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${city.isRecommended == 1}">
                                            <span class="status-badge status-approved">推荐</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">普通</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="AdminUpdateCity?id=${city.id}"
                                       class="admin-btn btn-warning btn-small">编辑</a>
                                    <a href="AdminDeleteCity?id=${city.id}"
                                       class="admin-btn btn-danger btn-small">删除</a>
                                    <c:choose>
                                        <c:when test="${city.isRecommended == 1}">
                                            <a href="AdminCancelRecommendCity?id=${city.id}"
                                               class="admin-btn btn-secondary btn-small">取消推荐</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="AdminRecommendCity?id=${city.id}"
                                               class="admin-btn btn-success btn-small">设为推荐</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

        <!-- 酒店管理 -->
        <section id="hotels" class="admin-section">
            <div class="section-header">
                <h2 class="section-title">酒店管理</h2>
                <button class="admin-btn btn-primary" onclick="showAddHotelForm()">+ 添加酒店</button>
            </div>

            <div id="addHotelForm" style="display: none; background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                <h3>添加酒店</h3>
                <form action="AdminAddHotel" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label">酒店名称</label>
                        <input type="text" name="name" class="form-control" placeholder="请输入酒店名称" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">所属城市</label>
                        <select name="cityName" class="form-control" required>
                            <option value="">选择城市</option>
                            <c:forEach items="${cityList}" var="city">
                                <option value="${city.name}">${city.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">详细地址</label>
                        <input type="text" name="address" class="form-control" placeholder="请输入详细地址">
                    </div>
                    <div class="form-group">
                        <label class="form-label">联系电话</label>
                        <input type="text" name="phone" class="form-control" placeholder="请输入联系电话">
                    </div>
                    <div class="form-group">
                        <label class="form-label">价格（元/晚）</label>
                        <input type="number" name="price" class="form-control"
                               placeholder="请输入价格" min="0" step="0.01">
                    </div>
                    <div class="form-group">
                        <label class="form-label">星级</label>
                        <select name="starRating" class="form-control">
                            <option value="1">★</option>
                            <option value="2">★★</option>
                            <option value="3" selected>★★★</option>
                            <option value="4">★★★★</option>
                            <option value="5">★★★★★</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">酒店图片</label>
                        <input type="file" name="image" class="form-control">
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="admin-btn btn-success">添加酒店</button>
                        <button type="button" class="admin-btn btn-danger" onclick="hideAddHotelForm()">取消</button>
                    </div>
                </form>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>酒店名称</th>
                    <th>所在城市</th>
                    <th>地址</th>
                    <th>价格</th>
                    <th>星级</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty hotelList}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: #666; padding: 30px;">
                                暂无酒店数据
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${hotelList}" var="hotel">
                            <tr>
                                <td>${hotel.id}</td>
                                <td>${hotel.name}</td>
                                <td>
                                    <c:forEach items="${cityList}" var="city">
                                        <c:if test="${city.id == hotel.cityId}">${city.name}</c:if>
                                    </c:forEach>
                                </td>
                                <td>${hotel.address}</td>
                                <td>¥${hotel.price}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${hotel.starRating == 1}">★</c:when>
                                        <c:when test="${hotel.starRating == 2}">★★</c:when>
                                        <c:when test="${hotel.starRating == 3}">★★★</c:when>
                                        <c:when test="${hotel.starRating == 4}">★★★★</c:when>
                                        <c:when test="${hotel.starRating == 5}">★★★★★</c:when>
                                        <c:otherwise>${hotel.starRating}星</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="AdminUpdateHotel?id=${hotel.id}"
                                       class="admin-btn btn-warning btn-small">编辑</a>
                                    <a href="AdminDeleteHotel?id=${hotel.id}"
                                       class="admin-btn btn-danger btn-small">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

        <!-- 游记审核 -->
        <section id="notes" class="admin-section">

            <!-- 消息提示 -->
            <c:if test="${not empty sessionScope.successMsg}">
                <div style="background: #d4edda; color: #155724; padding: 12px 20px;
                    border-radius: 5px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                    ✅ ${sessionScope.successMsg}
                    <c:remove var="successMsg" scope="session"/>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div style="background: #f8d7da; color: #721c24; padding: 12px 20px;
                    border-radius: 5px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
                    ❌ ${sessionScope.errorMsg}
                    <c:remove var="errorMsg" scope="session"/>
                </div>
            </c:if>

            <div class="section-header">
                <h2 class="section-title">游记审核</h2>
                <div class="btn-group">
                    <button class="admin-btn btn-success"
                            onclick="batchOperation('approve')">批量通过</button>

                    <button class="admin-btn btn-danger"
                            onclick="batchOperation('reject')">批量拒绝</button>
                </div>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>ID</th>
                    <th>游记标题</th>
                    <th>作者</th>
                    <th>城市</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty noteList}">
                        <tr>
                            <td colspan="8" style="text-align: center; color: #666; padding: 30px;">
                                暂无游记数据
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${noteList}" var="note">
                            <tr>
                                <td><input type="checkbox" class="note-checkbox" value="${note.id}"></td>
                                <td>${note.id}</td>
                                <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis;">
                                        ${note.title}
                                </td>
                                <td>${note.username}</td>
                                <td>${note.cityname}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${note.status == '待审核'}">
                                            <span class="status-badge status-pending">待审核</span>
                                        </c:when>
                                        <c:when test="${note.status == '已通过'}">
                                            <span class="status-badge status-approved">已通过</span>
                                        </c:when>
                                        <c:when test="${note.status == '已拒绝'}">
                                            <span class="status-badge status-rejected">已拒绝</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge">${note.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${note.status == '待审核'}">
                                        <a href="AdminApproveNote?id=${note.id}"
                                           class="admin-btn btn-success btn-small">通过</a>
                                        <a href="AdminRejectNote?id=${note.id}"
                                           class="admin-btn btn-danger btn-small">拒绝</a>
                                    </c:if>
                                    <a href="ViewNote?id=${note.id}" target="_blank"
                                       class="admin-btn btn-primary btn-small">预览</a>
                                    <a href="AdminDeleteNote?id=${note.id}"
                                       class="admin-btn btn-danger btn-small">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>

    </main>
</div>


<script>
        function getUrlParam(name) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }

        document.addEventListener('DOMContentLoaded', function() {
            const sectionParam = getUrlParam('section');
            const sectionId = sectionParam || 'users';

            document.querySelectorAll('.admin-section').forEach(section => {
                section.style.display = 'none';
            });

            // 显示对应的section
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                targetSection.style.display = 'block';
            }

            // 设置菜单激活状态
            document.querySelectorAll('.admin-menu-item').forEach(item => {
                item.classList.remove('active');
                // 如果链接包含当前section参数，则激活
                if (item.href.includes(`section=${sectionId}`)) {
                    item.classList.add('active');
                }
            });
        });

    function showAddAttractionForm() {
        document.getElementById('addAttractionForm').style.display = 'block';
    }

    function hideAddAttractionForm() {
        document.getElementById('addAttractionForm').style.display = 'none';
    }
    function showAddCityForm() {
        document.getElementById('addCityForm').style.display = 'block';
    }

    function hideAddCityForm() {
        document.getElementById('addCityForm').style.display = 'none';
    }
    function showAddHotelForm() {
        document.getElementById('addHotelForm').style.display = 'block';
    }
    function hideAddHotelForm() {
        document.getElementById('addHotelForm').style.display = 'none';
    }

        function batchOperation(type) {
            var checkboxes = document.querySelectorAll('.note-checkbox:checked');
            var ids = [];
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].value) {
                    ids.push(checkboxes[i].value);
                }
            }

            if (ids.length === 0) {
                alert('请选择要操作的游记');
                return false;
            }

            var actionName = type === 'approve' ? '通过' : '拒绝';
            if (confirm('确定要' + actionName + '选中的 ' + ids.length + ' 条游记吗？')) {
                var url = type === 'approve' ? 'AdminBatchApproveNote' : 'AdminBatchRejectNote';
                window.location.href = url + '?noteIds=' + ids.join(',') + '&section=notes';
            }
            return false;
        }
        function getSelectedNoteIds() {
            const checkboxes = document.querySelectorAll('.note-checkbox:checked');
            const ids = [];
            checkboxes.forEach(checkbox => {
                ids.push(checkbox.value);
            });
            return ids;
        }

        document.getElementById('selectAll')?.addEventListener('change', function(e) {
            const checkboxes = document.querySelectorAll('.note-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = e.target.checked;
            });
        });
</script>
</body>
</html>
