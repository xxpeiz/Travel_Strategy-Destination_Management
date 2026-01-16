<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${city.name}旅游攻略 - 到哪旅行</title>
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
        }
        .city-header {
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }
        .city-info {
            flex: 1;
            min-width: 0; /* 防止flex项目溢出 */
        }
        .city-info h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 15px;
        }
        .city-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }
        .meta-item {
            background: #f0f7ff;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            color: #156eee;
            border: 1px solid #d1e7ff;
        }
        .city-description {
            color: #555;
            line-height: 1.8;
            margin-bottom: 20px;
            font-size: 15px;
        }
        .city-tips {
            background: #fff8e6;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #ffc107;
            font-size: 14px;
            line-height: 1.6;
        }
        .city-cover {
            flex-shrink: 0;
            width: 350px;
            height: 220px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .city-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        .section-title {
            font-size: 22px;
            margin-bottom: 20px;
            color: #333;
            border-left: 4px solid #6dbbff;
            padding-left: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .grid {
            display: grid;
            gap: 20px;
        }
        /* 热门景点 - 两列布局 */
        .attraction-grid {
            grid-template-columns: repeat(2, 1fr);
        }
        /* 推荐酒店 - 三列布局 */
        .hotel-grid {
            grid-template-columns: repeat(3, 1fr);
        }
        /* 旅行游记 - 两列布局 */
        .note-grid {
            grid-template-columns: repeat(2, 1fr);
        }
        .card {
            background: #f8f9fa;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid #e9ecef;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .card-img {
            height: 180px;
            overflow: hidden;
        }
        .card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .card:hover .card-img img {
            transform: scale(1.05);
        }
        .card-content {
            padding: 18px;
        }
        .card-title {
            font-size: 17px;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
            line-height: 1.4;
        }
        .card-desc {
            color: #666;
            font-size: 14px;
            margin-bottom: 12px;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .card-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            color: #888;
        }
        .rating {
            color: #ffc107;
            font-weight: bold;
        }
        .price {
            color: #ff6b6b;
            font-weight: bold;
            font-size: 16px;
        }
        .star-rating {
            color: #ffc107;
            font-size: 14px;
        }
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
            grid-column: 1 / -1;
        }
        .empty-state h3 {
            margin-bottom: 10px;
            color: #999;
        }
        .back-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
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
        .tag {
            display: inline-block;
            background: #e3f2fd;
            color: #1976d2;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            margin-right: 5px;
            margin-bottom: 5px;
        }
        /* 响应式设计 */
        @media (max-width: 1024px) {
            .hotel-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .city-header {
                flex-direction: column;
            }
            .city-cover {
                width: 100%;
                height: 200px;
            }
            .attraction-grid,
            .hotel-grid,
            .note-grid {
                grid-template-columns: 1fr;
            }
            .city-meta {
                gap: 10px;
            }
            .meta-item {
                font-size: 13px;
                padding: 5px 10px;
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
            .city-info h1 {
                font-size: 26px;
            }
            .section-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 返回按钮 -->
    <a href="Home" class="back-btn">返回主页</a>
    <a href="QueryCityAll" class="back-btn">返回上一页</a>

    <!-- 城市信息头部 -->
    <div class="header">
        <div class="city-header">
            <div class="city-info">
                <h1>${city.name}旅游攻略</h1>
                <div class="city-meta">
                    <span class="meta-item">📍 ${city.province}</span>
                    <span class="meta-item">🌤️ ${city.climate}</span>
                    <span class="meta-item">📅 ${city.bestSeason}</span>
                </div>
                <div class="city-description">
                    ${city.description}
                </div>
                <div class="city-tips">
                    <strong>💡 旅行贴士：</strong>${city.travelTips}
                </div>
            </div>
            <div class="city-cover">
                <img src="png/${city.coverImage}" alt="${city.name}">
            </div>
        </div>
    </div>

    <!-- 热门景点 -->
    <section class="section">
        <h2 class="section-title">🏛️ 热门景点</h2>
        <div class="grid attraction-grid">
            <c:choose>
                <c:when test="${empty attractions}">
                    <div class="empty-state">
                        <h3>暂无景点信息</h3>
                        <p>该城市暂无景点数据</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${attractions}" var="attraction">
                        <div class="card" onclick="viewAttractionDetail(${attraction.id})">
                            <div class="card-img">
                                <img src="png/${attraction.image}" alt="${attraction.name}">
                            </div>
                            <div class="card-content">
                                <h3 class="card-title">${attraction.name}</h3>
                                <p class="card-desc">${attraction.description}</p>
                                <div class="card-meta">
                                    <span class="rating">⭐ ${attraction.rating}分</span>
                                    <span>📍 ${attraction.address}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- 推荐酒店 -->
    <section class="section">
        <h2 class="section-title">🏨 推荐酒店</h2>
        <div class="grid hotel-grid">
            <c:choose>
                <c:when test="${empty hotels}">
                    <div class="empty-state">
                        <h3>暂无酒店信息</h3>
                        <p>该城市暂无酒店数据</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${hotels}" var="hotel">
                        <div class="card" onclick="viewHotelDetail(${hotel.id})">
                            <div class="card-img">
                                <img src="png/${hotel.image}" alt="${hotel.name}">
                            </div>
                            <div class="card-content">
                                <h3 class="card-title">${hotel.name}</h3>
                                <div class="card-meta">
                                        <span class="star-rating">
                                            <c:forEach begin="1" end="${hotel.starRating}">★</c:forEach>
                                        </span>
                                    <span class="price">¥${hotel.price}</span>
                                </div>
                                <p class="card-desc">${hotel.address}</p>
                                <div class="card-meta">
                                    <span>📞 ${hotel.phone}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- 旅行游记 -->
    <section class="section">
        <h2 class="section-title">📝 旅行游记</h2>
        <div class="grid note-grid">
            <c:choose>
                <c:when test="${empty notes}">
                    <div class="empty-state">
                        <h3>暂无游记</h3>
                        <p>该城市暂无用户分享的游记</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${notes}" var="note">
                        <div class="card" onclick="viewNoteDetail(${note.id})">
                            <div class="card-img">
                                <img src="png/${note.coverImage}" alt="${note.title}">
                            </div>
                            <div class="card-content">
                                <h3 class="card-title">${note.title}</h3>
                                <p class="card-desc">${note.summary}</p>
                                <div class="card-meta">
                                    <span>👤 ${note.username}</span>
                                    <span>📅 ${note.createTime}</span>
                                </div>
                                <div style="margin-top: 10px;">
                                    <span class="tag">${note.status}</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</div>

<script>
    // 查看景点详情
    function viewAttractionDetail(attractionId) {
        window.location.href = 'QueryAttractionsByCity?id=' + attractionId;
    }

    // 查看酒店详情
    function viewHotelDetail(hotelId) {
        window.location.href = 'QueryHotelById?id=' + hotelId;
    }

    // 查看游记详情
    function viewNoteDetail(noteId) {
        window.location.href = 'QueryNoteById?id=' + noteId;
    }

    // 页面加载完成后执行
    document.addEventListener('DOMContentLoaded', function() {
        console.log('城市攻略页面加载完成');
        console.log('城市:', '${city.name}');
        console.log('景点数量:', ${empty attractions ? 0 : attractions.size()});
        console.log('酒店数量:', ${empty hotels ? 0 : hotels.size()});
        console.log('游记数量:', ${empty notes ? 0 : notes.size()});
    });
</script>
</body>
</html>