<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>游记详情 - ${note.title}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            line-height: 1.6;
            background-color: #f5f7fa;
            color: #333;
        }

        .note-container {
            max-width: 800px; 
            margin: 20px auto;
            padding: 0 20px;
        }

        .note-header {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .note-title {
            font-size: 24px;
            font-weight: bold;
            color: #156eee;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .note-meta {
            display: flex;
            gap: 15px;
            color: #666;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }


        .note-images {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            text-align: center;
        }

        .image-item {
            display: inline-block;
            max-width: 100%;
        }

        .note-image {
            max-width: 500px;
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }

        .note-image:hover {
            transform: scale(1.02);
        }

        .no-image {
            color: #999;
            padding: 40px;
            font-style: italic;
        }

        .note-content {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .content-body {
            font-size: 15px;
            line-height: 1.7;
        }

        .content-body p {
            margin-bottom: 18px;
        }

        .content-body img {
            max-width: 100%;
            height: auto;
            border-radius: 6px;
            margin: 12px 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
            padding-top: 18px;
            border-top: 1px solid #eee;
        }

        .btn {
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s;
        }

        .btn-back {
            background-color: #156eee;
            color: white;
        }

        .btn-back:hover {
            background-color: #0d5dc5;
        }

        .btn-approve {
            background-color: #28a745;
            color: white;
        }

        .btn-approve:hover {
            background-color: #218838;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }


        @media (max-width: 768px) {
            .note-container {
                max-width: 100%;
                padding: 0 15px;
            }

            .note-header {
                padding: 18px;
            }

            .note-title {
                font-size: 20px;
                margin-bottom: 10px;
            }

            .note-images {
                padding: 15px;
            }

            .note-image {
                max-width: 100%;
            }

            .note-content {
                padding: 20px;
            }

            .note-meta {
                flex-wrap: wrap;
                gap: 10px;
                font-size: 12px;
            }

            .action-buttons {
                flex-wrap: wrap;
                gap: 8px;
            }

            .btn {
                padding: 7px 15px;
                font-size: 12px;
            }

            .content-body {
                font-size: 14px;
                line-height: 1.6;
            }
        }

        @media (max-width: 480px) {
            .note-image {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="note-container">
    <div class="note-header">
        <h1 class="note-title">${note.title}</h1>

        <div class="note-meta">
            <div class="meta-item">👤 作者：${note.username}</div>
            <div class="meta-item">📍 城市：${note.cityname}</div>
        </div>

        <div style="display: flex; align-items: center; margin-top: 8px;">
            <span style="font-size: 13px;">状态：</span>
            <span class="note-status
                    <c:choose>
                        <c:when test="${note.status == '待审核'}">status-pending</c:when>
                        <c:when test="${note.status == '已通过'}">status-approved</c:when>
                        <c:when test="${note.status == '已拒绝'}">status-rejected</c:when>
                    </c:choose>">
                ${note.status}
            </span>
        </div>
    </div>

    <div class="note-images">
        <c:choose>
            <c:when test="${not empty note.coverImage}">
                <div class="image-item">
                    <img src="png/${note.coverImage}"
                         alt="${note.title} 封面图片"
                         class="note-image">
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-image">
                    🖼️ 暂无图片
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="note-content">
        <div class="content-body">
            ${note.content}
        </div>

        <div class="action-buttons">
            <c:if test="${sessionScope.userInfo.role == '管理员'}">
                <c:if test="${note.status == '待审核'}">
                    <a href="AdminApproveNote?id=${note.id}&section=notes"
                       class="btn btn-approve">✅ 审核通过</a>
                    <a href="AdminRejectNote?id=${note.id}&section=notes"
                       class="btn btn-reject">❌ 审核拒绝</a>
                </c:if>
            </c:if>
            <a href="AdminNoteReview?section=notes" class="btn btn-back">返回列表</a>
        </div>
    </div>
</div>
</body>
</html>