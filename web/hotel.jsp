<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>酒店列表</title>
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
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .search-section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        .search-form {
            display: flex;
            gap: 15px;
            justify-content: center;
            align-items: end;
            max-width: 500px;
            margin: 0 auto;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .form-group label {
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        .form-group input {
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
        }
        .search-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .search-btn:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,123,255,0.3);
        }
        .hotel-list {
            display: grid;
            gap: 20px;
        }
        .hotel-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 20px;
            align-items: start;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .hotel-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .hotel-image {
            margin-left: 100px;
            width: 55%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .hotel-card:hover .hotel-image {
            transform: scale(1.05);
        }
        .hotel-content {
            margin-left: 25px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .hotel-name {
            margin-left: 25px;
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .hotel-card:hover .hotel-name {
            color: #007bff;
        }
        .hotel-info {
            margin-left: 25px;
            color: #666;
            margin-bottom: 5px;
        }
        .hotel-rating {
            margin-left: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .price {
            margin-left: 25px;
            font-size: 24px;
            font-weight: bold;
            color: #ff6b6b;
            margin-top: 10px;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .back-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }
        .back-btn:hover {
            background: #5a6268;
        }
        .search-results-info {
            margin-bottom: 20px;
            padding: 15px;
            background: #e7f3ff;
            border-radius: 8px;
            border-left: 4px solid #007bff;
        }
        @media (max-width: 768px) {
            .hotel-card {
                grid-template-columns: 1fr;
            }
            .search-form {
                flex-direction: column;
            }
            .hotel-image {
                margin-left: 0;
                width: 100%;
            }
            .hotel-content,
            .hotel-name,
            .hotel-info,
            .hotel-rating,
            .price {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <a href="Home" class="back-btn">返回主页</a>

    <!-- 搜索区域 -->
    <section class="search-section">
        <h1 style="margin-bottom: 20px; color: #333;">酒店查询</h1>
        <form class="search-form" id="searchForm">
            <div class="form-group">
                <input type="text" id="cityName" name="cityName" placeholder="输入城市名称" value="${param.cityName}">
            </div>
            <button type="button" class="search-btn" onclick="searchHotels()">搜索酒店</button>
        </form>
    </section>

    <!-- 搜索结果信息 -->
    <c:if test="${not empty hotels}">
        <div class="search-results-info">
            <strong>在 "${searchedCityName}" 找到 ${hotels.size()} 家酒店</strong>
        </div>
    </c:if>

    <!-- 酒店列表 -->
    <section class="hotel-list">
        <c:choose>
            <c:when test="${empty hotels}">
                <div class="empty-state">
                    <c:choose>
                        <c:when test="${not empty param.cityName}">
                            <h3>未找到相关酒店</h3>
                            <p>请检查城市名称是否正确，或尝试其他城市</p>
                        </c:when>
                        <c:otherwise>
                            <h3>请输入目的地搜索酒店</h3>
                            <p>在搜索框中输入城市名称开始搜索</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${hotels}" var="hotel">
                    <div class="hotel-card" onclick="viewHotelDetail(${hotel.id})">
                        <div class="hotel-content">
                            <h3 class="hotel-name">${hotel.name}</h3>
                            <div class="hotel-info">🏠 ${hotel.address}</div>
                            <div class="hotel-info">📍 ${hotel.cityName}</div>
                            <div class="hotel-info">📞 ${hotel.phone}</div>
                            <div class="hotel-rating">
                                <span>⭐ ${hotel.starRating}星级</span>
                            </div>
                            <div class="price">¥${hotel.price} /晚</div>
                        </div>
                        <div>
                            <img src="png/${hotel.image}" alt="${hotel.name}" class="hotel-image"
                                 onerror="this.src='images/default-hotel.jpg'">
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </section>
</div>

<script>
    function viewHotelDetail(hotelId) {
        window.location.href = 'QueryHotelById?id=' + hotelId;
    }

    function searchHotels() {
        const cityName = document.getElementById('cityName').value.trim();
        window.location.href = 'SearchHotels?cityName=' + encodeURIComponent(cityName);
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('cityName').focus();
        const cityName = '${param.cityName}';
        if (cityName) {
            console.log('搜索城市:', cityName);
        }
    });
</script>
</body>
</html>