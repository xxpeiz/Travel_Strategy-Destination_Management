<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${attraction.name} - 景点详情</title>
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
        .attraction-detail {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .attraction-header {
            padding: 30px;
            border-bottom: 2px solid #f0f0f0;
        }
        .attraction-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        .attraction-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 14px;
        }
        .rating {
            color: #ffc107;
            font-weight: bold;
            font-size: 18px;
        }
        .attraction-cover {
            width: 100%;
            height: 400px;
            border-radius: 8px;
            overflow: hidden;
            margin: 20px 0;
        }
        .attraction-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .attraction-content {
            padding: 30px;
        }
        .content-section {
            margin-bottom: 30px;
        }
        .section-title {
            font-size: 20px;
            color: #333;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #6dbbff;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .description {
            font-size: 16px;
            line-height: 1.8;
            color: #555;
        }
        .description p {
            margin-bottom: 15px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .info-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #6dbbff;
        }
        .info-card h4 {
            color: #333;
            margin-bottom: 10px;
            font-size: 16px;
        }
        .info-card p {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
        }
        .map-container {
            height: 300px;
            background: #f8f9fa;
            border-radius: 8px;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: #fff;
            border: 2px solid #007bff;
            color: #007bff;
        }
        .btn-primary:hover {
            background: #007bff;
            color: white;
            transform: translateY(-2px);
        }
        .btn-primary.collected {
            background: #007bff;
            color: white;
        }
        .btn-secondary {
            background: #28a745;
            color: white;
        }
        .btn-secondary:hover {
            background: #1e7e34;
            transform: translateY(-2px);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            .attraction-header,
            .attraction-content {
                padding: 20px;
            }
            .attraction-title {
                font-size: 26px;
            }
            .attraction-cover {
                height: 250px;
            }
            .attraction-meta {
                flex-direction: column;
                gap: 10px;
            }
            .action-buttons {
                flex-direction: column;
            }
            .btn {
                width: 100%;
                justify-content: center;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <a href="QueryStrategyAll?id=${cityId}" class="back-btn">返回攻略</a>

    <c:choose>
        <c:when test="${empty attraction}">
            <div class="empty-state">
                <h3>景点不存在</h3>
                <p>请返回重新选择</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="attraction-detail">
                <!-- 景点头部信息 -->
                <div class="attraction-header">
                    <h1 class="attraction-title">${attraction.name}</h1>
                    <div class="attraction-meta">
                        <div class="meta-item">
                            <span class="rating">⭐ ${attraction.rating}分</span>
                        </div>
                        <div class="meta-item">
                            <span>📍 ${attraction.address}</span>
                        </div>
                    </div>

                    <div class="attraction-cover">
                        <img src="png/${attraction.image}" alt="${attraction.name}">
                    </div>
                </div>

                <!-- 景点主要内容 -->
                <div class="attraction-content">
                    <!-- 景点描述 -->
                    <div class="content-section">
                        <h2 class="section-title">📖 景点介绍</h2>
                        <div class="description">
                            <c:choose>
                                <c:when test="${not empty attraction.description}">
                                    <p>${attraction.description}</p>
                                </c:when>
                                <c:otherwise>
                                    <p style="color: #999; font-style: italic;">暂无景点介绍</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- 详细信息 -->
                    <div class="content-section">
                        <h2 class="section-title">ℹ️ 详细信息</h2>
                        <div class="info-grid">
                            <div class="info-card">
                                <h4>景点评分</h4>
                                <p>⭐ ${attraction.rating} 分</p>
                            </div>
                        </div>
                    </div>


                    <!-- 操作按钮 -->
                    <div class="action-buttons">
                        <!-- 收藏表单 -->
                        <form id="collectForm" method="post" action="CollectAttraction" style="display: inline;">
                            <input type="hidden" name="attractionId" value="${attraction.id}">
                            <button type="submit" class="btn btn-primary ${collected ? 'collected' : ''}" id="collectButton">
                                <span>${collected ? '★ 已收藏' : '☆ 收藏景点'}</span>
                            </button>
                        </form>
                        <button class="btn btn-secondary" onclick="shareAttraction()">
                            📤 分享景点
                        </button>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('景点详情页面加载完成');

        const collectForm = document.getElementById('collectForm');
        if (collectForm) {
            collectForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const collectButton = document.getElementById('collectButton');
                const isCollected = collectButton.classList.contains('collected');

                if (isCollected) {
                    this.action = 'UncollectAttraction';
                } else {
                    this.action = 'CollectAttraction';
                }

                // 提交表单
                this.submit();
            });
        }
    });

    function shareAttraction() {
        const attractionName = '${attraction.name}';
        const attractionDescription = '${attraction.description}';
        const currentUrl = window.location.href;

        const shareData = {
            title: attractionName + ' - 旅游景点',
            text: attractionDescription,
            url: currentUrl
        };

        if (navigator.share) {
            navigator.share(shareData)
                .then(() => console.log('分享成功'))
                .catch(error => console.log('分享失败', error));
        } else {
            const shareText = '推荐景点：' + shareData.title + ' - ' + (shareData.text || '');
            const encodedText = encodeURIComponent(shareText);
            const shareUrl = 'https://twitter.com/intent/tweet?text=' + encodedText;
            window.open(shareUrl, '_blank');
        }
    }
</script>
</body>
</html>