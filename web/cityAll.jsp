<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选择城市</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        .header h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 10px;
        }
        .header p {
            color: #666;
            font-size: 16px;
        }
        .section {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .section-title {
            font-size: 24px;
            margin-bottom: 25px;
            color: #333;
            border-left: 4px solid #6dbbff;
            padding-left: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .city-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        .city-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 25px 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }
        .city-card:hover {
            background: #22b5fa;
            color: white;
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(34, 181, 250, 0.3);
            border-color: #22b5fa;
        }
        .city-card:hover .city-image {
            transform: scale(1.1);
        }
        .city-card:hover .city-name {
            color: white;
        }
        .city-card:hover .city-province {
            color: rgba(255,255,255,0.9);
        }
        .city-image {
            width: 80px;
            height: 80px;
            margin: 0 auto 15px;
            border-radius: 50%;
            overflow: hidden;
            background: #e9ecef;
            transition: transform 0.3s ease;
            border: 3px solid white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .city-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .city-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
            transition: color 0.3s ease;
        }
        .city-province {
            color: #666;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
            grid-column: 1 / -1;
        }
        .empty-state h3 {
            margin-bottom: 15px;
            color: #999;
            font-size: 20px;
        }
        .empty-state p {
            font-size: 16px;
            margin-bottom: 20px;
        }
        .back-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .back-btn:hover {
            background: #5a6268;
            transform: translateX(-5px);
        }
        .search-box {
            margin-bottom: 25px;
            position: relative;
        }
        .search-box input {
            width: 100%;
            max-width: 400px;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            outline: none;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        .search-box input:focus {
            border-color: #22b5fa;
        }
        .search-box button {
            position: absolute;
            right: 5px;
            top: 5px;
            background: #22b5fa;
            border: none;
            padding: 7px 20px;
            border-radius: 20px;
            color: white;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s ease;
        }
        .search-box button:hover {
            background: #1a9cd8;
        }
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 30px 0;
            margin-top: 50px;
            border-radius: 12px;
        }
        @media (max-width: 768px) {
            .city-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
            }
            .city-card {
                padding: 20px 15px;
            }
            .city-image {
                width: 60px;
                height: 60px;
            }
            .city-name {
                font-size: 16px;
            }
            .city-province {
                font-size: 13px;
            }
            .header h1 {
                font-size: 28px;
            }
            .section-title {
                font-size: 22px;
            }
        }
        @media (max-width: 480px) {
            .container {
                padding: 15px;
            }
            .header,
            .section {
                padding: 20px;
            }
            .city-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body>
<div class="container">

    <a href="Home" class="back-btn">返回主页</a>

    <div class="header">
        <h1>选择目的地城市</h1>
        <p>选择一个城市，查看详细的旅游攻略、景点、酒店和游记</p>
    </div>

    <div class="section">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="搜索城市名称">
            <button type="button" onclick="searchCities()">搜索</button>
        </div>
    </div>

    <section class="section">
        <h2 class="section-title">🏙️ 所有城市</h2>
        <div class="city-grid" id="cityGrid">
            <c:choose>
                <c:when test="${empty cities}">
                    <div class="empty-state">
                        <h3>暂无城市数据</h3>
                        <p>请稍后再试或联系管理员</p>
                        <a href="Home" class="back-btn" style="margin-top: 15px;">返回首页</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${cities}" var="city">
                        <div class="city-card" onclick="viewCityStrategy(${city.id})">
                            <div class="city-image">
                                <img src="png/${city.coverImage}" alt="${city.name}">
                            </div>
                            <h3 class="city-name">${city.name}</h3>
                            <p class="city-province">${city.province}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- 底部 -->
    <footer class="footer">
        <p>到哪旅行网</p>
        <p>联系我们 | 关于我们 | 帮助中心 | 隐私政策</p>
    </footer>
</div>

<script>
    // 查看城市攻略
    function viewCityStrategy(cityId) {
        // 跳转到城市攻略页面
        window.location.href = 'QueryStrategyAll?id=' + cityId;
    }

    function searchCities() {
        var searchTerm = document.getElementById('searchInput').value.trim();
        window.location.href = 'QueryLikeHome?like=' + encodeURIComponent(searchTerm);
    }


    function filterCities() {
        var searchTerm = document.getElementById('searchInput').value.toLowerCase();
        var cityCards = document.querySelectorAll('.city-card');
        var visibleCount = 0;

        for (var i = 0; i < cityCards.length; i++) {
            var card = cityCards[i];
            var cityName = card.querySelector('.city-name').textContent.toLowerCase();
            if (cityName.indexOf(searchTerm) > -1) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        }

        // 如果没有匹配的城市，显示提示
        if (visibleCount === 0 && searchTerm) {
            if (!document.getElementById('noResults')) {
                var noResults = document.createElement('div');
                noResults.id = 'noResults';
                noResults.className = 'empty-state';
                noResults.innerHTML = '<h3>没有找到匹配的城市</h3><p>请尝试其他搜索关键词</p><button onclick="clearSearch()" style="margin-top: 15px; padding: 10px 20px; background: #22b5fa; color: white; border: none; border-radius: 6px; cursor: pointer;">清除搜索</button>';
                document.getElementById('cityGrid').appendChild(noResults);
            }
        } else {
            var noResults = document.getElementById('noResults');
            if (noResults) {
                noResults.remove();
            }
        }
    }

    // 清除搜索
    function clearSearch() {
        document.getElementById('searchInput').value = '';
        var cityCards = document.querySelectorAll('.city-card');
        for (var i = 0; i < cityCards.length; i++) {
            cityCards[i].style.display = 'block';
        }
        var noResults = document.getElementById('noResults');
        if (noResults) {
            noResults.remove();
        }
    }

    document.getElementById('searchInput').addEventListener('input', filterCities);
</script>
</body>
</html>
