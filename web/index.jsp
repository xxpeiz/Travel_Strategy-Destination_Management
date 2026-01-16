
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>到哪旅行攻略网</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }

        .header { background: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.1); position: fixed; width: 100%; top: 0; z-index: 1000;opacity: 80% }
        .nav { display: flex; justify-content: space-between; align-items: center; padding: 0 50px; height: 70px; }
        .logo { font-size: 24px; font-weight: bold; color: #156eee; }
        .nav-links a { margin: 0 15px; text-decoration: none; color: #333; font-weight: 500; }
        .nav-links a:hover { color: #7fccef; }
        .user-area { display: flex; align-items: center; gap: 10px; }

        .banner {
            position: relative;
            overflow: hidden;
            height: 500px;
        }

        .carousel-box {
            width: 100%;
            height: 100%;
            overflow: hidden;
            position: relative;
        }

        .carousel-imgBox {
            display: flex;
            width: 400%;
            height: 100%;
            transition: transform 1s ease;
        }

        .carousel-imgBox img {
            width: 25%;
            height: 100%;
            object-fit: cover;
            flex-shrink: 0;
        }

        .banner-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            z-index: 2;
        }

        .banner-content h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .banner-content p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .search-box {
            width: 400px;
            position: relative;
            margin: 0 auto;
        }

        .search-box input {
            width: 100%;
            padding: 12px 20px;
            border: none;
            border-radius: 25px;
            outline: none;
            font-size: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }

        .search-box button {
            position: absolute;
            right: 5px;
            top: 5px;
            background: #0475c1;
            border: none;
            padding: 7px 20px;
            border-radius: 20px;
            color: white;
            cursor: pointer;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .banner {
                height: 300px;
            }

            .banner-content h1 {
                font-size: 32px;
            }

            .banner-content p {
                font-size: 14px;
            }

            .search-box {
                width: 300px;
            }

            .nav {
                padding: 0 20px;
            }
        }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .section { margin-bottom: 50px; }
        .section-title { font-size: 24px; margin-bottom: 20px; color: #333; border-left: 4px solid #6dbbff; padding-left: 10px; }

        .card-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }
        .card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .card:hover { transform: translateY(-5px); }
        .card-img { height: 200px; background: #ddd; background-size: cover; background-position: center; }
        .card-content { padding: 15px; }
        .card-title { font-size: 16px; font-weight: bold; margin-bottom: 10px; }
        .card-desc { font-size: 14px; color: #666; margin-bottom: 10px; }
        .card-meta { display: flex; justify-content: space-between; font-size: 12px; color: #999; }

        .city-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; }
        .city-card { background: white; border-radius: 8px; padding: 20px; text-align: center; cursor: pointer; transition: all 0.3s; }
        .city-card:hover { background: #22b5fa; color: white; }

        .footer { background: #333; color: white; text-align: center; padding: 30px 0; margin-top: 50px; }
    </style>
</head>
<body>
<!-- 头部导航 -->
<header class="header">
    <nav class="nav">
        <div class="logo">到哪旅行网</div>
        <div class="nav-links">
            <a href="Home">首页</a>
            <a onclick="navToPage('QueryCityAll')">旅游攻略</a>
            <a onclick="navToPage('QueryhotelAll')">酒店详情</a>
            <a onclick="navToPage('UserInfo')">个人中心</a>
        </div>
        <div class="user-area">
            <c:if test="${empty sessionScope.userInfo}">
                <a href="login.jsp">登录</a> | <a href="signup.jsp">注册</a>
            </c:if>
            <c:if test="${not empty sessionScope.userInfo}">
                <span>👋欢迎，${sessionScope.userInfo.username}</span>
                <a href="logout.jsp">退出</a>
            </c:if>
        </div>
    </nav>
</header>

<!-- 轮播图区域 -->
<div class="banner">
    <div class="carousel-box">
        <div class="carousel-imgBox" id="carouselImgBox" >
            <img src="png/bj.png" alt="北京">
            <img src="png/sh.png" alt="上海">
            <img src="png/xa.png" alt="西安">
            <img src="png/hz.png" alt="杭州">
        </div>
    </div>

    <!-- 原有内容（在轮播图上层显示） -->
    <div class="banner-content">
        <h1>发现世界的美好</h1>
        <p>专业的旅行攻略，真实的用户分享，让你的旅行更精彩</p>
        <div class="search-box">
            <input type="text" name="like" placeholder="搜索目的地" style="font-size: 15px" id="searchInput">
            <button type="button" onclick="checkLoginBeforeAction('QueryLikeHome?like=' + encodeURIComponent(document.getElementById('searchInput').value.trim()))">搜索🔍</button>
        </div>
    </div>
</div>


<!-- 主要内容区域 -->
<div class="container">
    <!-- 热门推荐城市 -->
    <section class="section">
        <h2 class="section-title">热门推荐城市</h2>
        <div class="city-grid">
            <c:choose>
                <c:when test="${empty hotCities}">
                    <p style="grid-column: 1/-1; text-align: center; color: #666;">暂无推荐城市</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${hotCities}" var="city">
                        <div class="city-card" onclick="checkLoginBeforeAction('QueryStrategyAll?id=${city.id}')">
                            <div style="width: 80px; height: 80px; margin: 0 auto 10px; border-radius: 50%; overflow: hidden; background: #f0f0f0;">
                                <img src="png/${city.coverImage}" alt="${city.name}" style="width: 100%; height: 100%; object-fit: cover;">
                            </div>
                            <h3>${city.name}</h3>
                            <p>${city.province}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- 精选旅行游记-->
    <section class="section">
        <h2 class="section-title">精选旅行游记</h2>
        <div class="city-grid">
            <c:choose>
                <c:when test="${empty notes}">
                    <p style="grid-column: 1/-1; text-align: center; color: #666;">暂无精选游记</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${notes}" var="note">
                        <div class="city-card" onclick="checkLoginBeforeAction('QueryNoteById?id=${note.id}')">
                            <div style="width: 200px; height: 80px; margin: 0 auto 10px; border-radius: 8px; overflow: hidden; background: #f0f0f0;">
                                <img src="png/${note.coverImage}" alt="${note.title}" style="width: 100%; height: 100%; object-fit: cover;">
                            </div>
                            <h3>${note.title}</h3>
                            <p>${note.cityname} · ${note.username}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- 当季推荐 -->
    <section class="section">
        <h2 class="section-title">当季酒店推荐</h2>
        <div class="city-grid">
            <c:choose>
                <c:when test="${empty hotels}">
                    <p style="grid-column: 1/-1; text-align: center; color: #666;">暂无酒店推荐</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${hotels}" var="hotel">
                        <div class="city-card" onclick="checkLoginBeforeAction('QueryHotelById?id=${hotel.id}')">
                            <div style="width: 80px; height: 80px; margin: 0 auto 10px; border-radius: 8px; overflow: hidden; background: #f0f0f0;">
                                <img src="png/${hotel.image}" alt="${hotel.name}" style="width: 100%; height: 100%; object-fit: cover;">
                            </div>
                            <h3>${hotel.name}</h3>
                            <p style="color: #ff6b6b; font-weight: bold; margin-top: 5px;">¥${hotel.price}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

</div>


<footer class="footer">
    <p>到哪旅行网</p>
    <p>联系我们 | 关于我们 | 帮助中心 | 隐私政策</p>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function(){
        const imgBox = document.getElementById("carouselImgBox");
        if (!imgBox) return;

        imgBox.style.transform = 'translateX(-0%)';

        setTimeout(() => imgBox.style.transform = 'translateX(-25%)', 5000);

        setTimeout(() => imgBox.style.transform = 'translateX(-50%)', 10000);

        setTimeout(() => imgBox.style.transform = 'translateX(-75%)', 15000);

    });
</script>

<script>
    // 导航到页面（检查登录状态）
    function navToPage(pageUrl) {
        <c:choose>
        <c:when test="${not empty sessionScope.userInfo}">
        // 已登录，直接跳转
        window.location.href = pageUrl;
        </c:when>
        <c:otherwise>
        // 未登录，直接跳转到登录页面
        window.location.href = 'login.jsp';
        </c:otherwise>
        </c:choose>
    }

    // 检查登录状态的函数（用于内容点击）
    function checkLoginBeforeAction(targetUrl) {
        <c:choose>
        <c:when test="${not empty sessionScope.userInfo}">
        // 已登录，直接跳转
        window.location.href = targetUrl;
        </c:when>
        <c:otherwise>
        // 未登录，直接跳转到登录页面
        window.location.href = 'login.jsp';
        </c:otherwise>
        </c:choose>
    }

    // 搜索功能
    function handleSearch(e) {
        const keyword = document.getElementById('searchInput').value;
        if (keyword.trim()) {
            <c:choose>
            <c:when test="${not empty sessionScope.userInfo}">
            // 已登录，执行搜索
            location.href = 'QueryLikeHome?like=' + encodeURIComponent(keyword);
            </c:when>
            <c:otherwise>
            // 未登录，直接跳转到登录页面
            window.location.href = 'login.jsp';
            </c:otherwise>
            </c:choose>
        }
    }
</script>
</body>
</html>