<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>酒店详情 - ${hotels.name}</title>
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

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
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
        }

        .back-btn:hover {
            background: #5a6268;
        }

        .hotel-detail {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .hotel-gallery {
            position: relative;
            height: 400px;
            overflow: hidden;
        }

        .hotel-main-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .hotel-info-section {
            padding: 30px;
        }

        .hotel-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .hotel-title h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }

        .hotel-location {
            color: #666;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 5px;
        }

        .hotel-rating {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .stars {
            color: #ffc107;
            font-size: 18px;
        }

        .rating-score {
            background: #007bff;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: bold;
        }

        .hotel-price {
            text-align: right;
        }

        .price {
            font-size: 32px;
            font-weight: bold;
            color: #ff6b6b;
        }

        .price-unit {
            font-size: 14px;
            color: #999;
        }

        .hotel-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin: 30px 0;
        }

        .detail-section {
            margin-bottom: 25px;
        }

        .detail-section h3 {
            font-size: 18px;
            color: #333;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #f0f0f0;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
            padding: 8px 0;
        }

        .detail-icon {
            width: 20px;
            text-align: center;
            color: #007bff;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 6px;
        }

        .contact-info {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .contact-info h4 {
            margin-bottom: 15px;
            color: #1976d2;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background: #0056b3;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        @media (max-width: 768px) {
            .hotel-details {
                grid-template-columns: 1fr;
            }

            .hotel-header {
                flex-direction: column;
                gap: 15px;
            }

            .hotel-price {
                text-align: left;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>酒店详情</h1>
        <a href="javascript:history.back()" class="back-btn">返回上一页</a>
    </div>

    <c:choose>
        <c:when test="${empty hotels}">
            <div style="text-align: center; padding: 60px 20px;">
                <h3>酒店信息不存在</h3>
                <p>请返回酒店列表重新选择</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="hotel-detail">
                <div class="hotel-gallery">
                    <img src="png/${hotels.image}" alt="${hotels.name}" class="hotel-main-image">
                </div>

                <!-- 酒店信息 -->
                <div class="hotel-info-section">
                    <div class="hotel-header">
                        <div class="hotel-title">
                            <h1>${hotels.name}</h1>
                            <div class="hotel-location">
                                <span>📍</span>
                                <span>${hotels.address}</span>
                            </div>
                        </div>
                        <div class="hotel-rating">
                            <div class="stars">
                                <c:forEach begin="1" end="${hotels.starRating}">★</c:forEach>
                            </div>
                            <span class="rating-score">${hotels.starRating}.0</span>
                        </div>
                    </div>

                    <div class="hotel-price">
                        <div class="price">¥${hotels.price}</div>
                        <div class="price-unit">每晚</div>
                    </div>

                    <div class="hotel-details">
                        <!-- 基本信息 -->
                        <div class="detail-section">
                            <h3>基本信息</h3>
                            <div class="detail-item">
                                <span class="detail-icon">🏨</span>
                                <span><strong>酒店名称：</strong>${hotels.name}</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">🏠</span>
                                <span><strong>详细地址：</strong>${hotels.address}</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">⭐</span>
                                <span><strong>酒店星级：</strong>
                                    <c:forEach begin="1" end="${hotels.starRating}">★</c:forEach>
                                    (${hotels.starRating}星)
                                </span>
                            </div>
                        </div>

                        <!-- 联系方式 -->
                        <div class="detail-section">
                            <h3>联系方式</h3>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span><strong>联系电话：</strong>${hotels.phone}</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">💰</span>
                                <span><strong>参考价格：</strong>¥${hotels.price} 元/晚</span>
                            </div>
                        </div>
                    </div>

                    <!-- 设施服务 -->
                    <div class="detail-section">
                        <h3>设施服务</h3>
                        <div class="features-grid">
                            <div class="feature-item">
                                <span>📶</span>
                                <span>免费WiFi</span>
                            </div>
                            <div class="feature-item">
                                <span>🅿️</span>
                                <span>停车场</span>
                            </div>
                            <div class="feature-item">
                                <span>🍽️</span>
                                <span>餐厅</span>
                            </div>
                            <div class="feature-item">
                                <span>🏊</span>
                                <span>游泳池</span>
                            </div>
                            <div class="feature-item">
                                <span>💪</span>
                                <span>健身房</span>
                            </div>
                            <div class="feature-item">
                                <span>🛎️</span>
                                <span>24小时前台</span>
                            </div>
                        </div>
                    </div>

                    <!-- 联系信息 -->
                    <div class="contact-info">
                        <h4>📞 预订咨询</h4>
                        <p>如需预订或了解更多信息，请直接联系酒店：</p>
                        <p><strong>电话：</strong>${hotels.phone}</p>
                        <p><strong>地址：</strong>${hotels.address}</p>
                    </div>

                    <div class="action-buttons">
                        <button class="btn btn-primary" onclick="contactHotel()">联系酒店</button>
                        <button class="btn btn-secondary" onclick="shareHotel()">分享酒店</button>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function contactHotel() {
        const phone = '${hotels.phone}';
        if (phone) {
            alert(`请联系酒店：${hotels.phone}`);
        } else {
            alert('该酒店暂未提供联系电话');
        }
    }

    function shareHotel() {
        const hotelName = '${hotels.name}';
        const hotelUrl = window.location.href;
        if (navigator.share) {
            navigator.share({
                title: hotelName,
                text: '推荐这家酒店：' + hotelName,
                url: hotelUrl
            });
        } else {
            navigator.clipboard.writeText(hotelUrl).then(function() {
                alert('酒店链接已复制到剪贴板！');
            });
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        console.log('酒店详情页面加载完成');
    });
</script>
</body>
</html>
