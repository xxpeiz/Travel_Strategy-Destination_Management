<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${note.title}</title>
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
            max-width: 1000px;
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
        .note-detail {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .note-header {
            padding: 30px;
            border-bottom: 2px solid #f0f0f0;
        }
        .note-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        .note-meta {
            display: flex;
            gap: 20px;
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .note-cover {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            margin: 20px 0;
            border-radius: 8px;
        }
        .note-content {
            padding: 30px;
            font-size: 16px;
            line-height: 1.8;
        }
        .note-content p {
            margin-bottom: 20px;
        }
        .note-footer {
            padding: 20px 30px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .author-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .like-btn {
            background: #fff;
            border: 2px solid #e74c3c;
            color: #e74c3c;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-size: 14px;
            font-weight: bold;
        }
        .like-btn:hover {
            background: #e74c3c;
            color: white;
            transform: scale(1.05);
        }
        .like-btn.liked {
            background: #e74c3c;
            color: white;
        }
        .like-btn .heart {
            font-size: 16px;
            transition: transform 0.3s ease;
        }
        .like-btn.liked .heart {
            transform: scale(1.2);
        }
        .like-count {
            font-size: 14px;
            color: #666;
            margin-left: 5px;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .stats-info {
            display: flex;
            gap: 15px;
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }
        .stat-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            .note-header,
            .note-content {
                padding: 20px;
            }
            .note-title {
                font-size: 24px;
            }
            .note-meta {
                flex-direction: column;
                gap: 10px;
            }
            .note-footer {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            .action-buttons {
                width: 100%;
                justify-content: space-between;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <a href="javascript:history.back()" class="back-btn">返回</a>

    <c:choose>
        <c:when test="${empty note}">
            <div class="empty-state">
                <h3>游记不存在</h3>
                <p>请返回重新选择</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="note-detail">
                <!-- 游记头部 -->
                <div class="note-header">
                    <h1 class="note-title">${note.title}</h1>
                    <div class="note-meta">
                        <span>👤 ${note.username}</span>
                        <span>📍 ${note.cityname}</span>
                        <span>📅 ${note.createTime}</span>
                        <span>✅ ${note.status}</span>
                    </div>
                    <c:if test="${not empty note.coverImage}">
                        <img src="png/${note.coverImage}" alt="${note.title}" class="note-cover">
                    </c:if>
                </div>

                <!-- 游记内容 -->
                <div class="note-content">
                        ${note.content}
                </div>

                <!-- 游记底部 -->
                <div class="note-footer">
                    <div class="author-info">
                        <span>作者：${note.username}</span>
                    </div>
                    <div class="action-buttons">
                        <div>
                            <span>发布时间：${note.createTime}</span>
                        </div>
                        <!-- 点赞表单 -->
                        <form id="likeForm" method="post" action="LikeNote" style="display: inline;">
                            <input type="hidden" name="noteId" value="${note.id}">
                            <button type="submit" class="like-btn ${userLiked ? 'liked' : ''}" id="likeButton">
                                <span class="heart">❤️</span>
                                <span id="likeText">${userLiked ? '已点赞' : '点赞'}</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('游记详情页面加载完成');

        const likeForm = document.getElementById('likeForm');
        if (likeForm) {
            likeForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const likeButton = document.getElementById('likeButton');
                const isLiked = likeButton.classList.contains('liked');

                if (isLiked) {
                    this.action = 'UnlikeNote';
                } else {
                    this.action = 'LikeNote';
                }
                this.submit();
            });
        }
    });
</script>
</body>
</html>