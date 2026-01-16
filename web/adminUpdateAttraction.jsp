<%@ page import="com.model.Attraction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Attraction attraction = (Attraction) request.getAttribute("attraction");
    if (attraction == null) {
        response.sendRedirect("AdminAttractionList");
        return;
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑景点 - 后台管理</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e4ffff 0%, #d5f2fc 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .edit-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 600px;
            overflow: hidden;
        }

        .edit-header {
            background: linear-gradient(135deg, #aab7f6 0%, #e1cfff 100%);
            color: white;
            padding: 35px 40px;
            position: relative;
            overflow: hidden;
        }

        .edit-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-size: cover;
            opacity: 0.3;
        }

        .edit-header h2 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }

        .edit-header p {
            opacity: 0.9;
            font-size: 16px;
            position: relative;
            z-index: 1;
        }

        .attraction-id {
            position: absolute;
            top: 20px;
            right: 30px;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            z-index: 1;
        }

        .edit-content {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group label i {
            color: #667eea;
            font-size: 16px;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 16px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
            font-family: inherit;
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .form-textarea {
            min-height: 120px;
            resize: vertical;
            line-height: 1.5;
        }

        .form-select {
            cursor: pointer;
            appearance: none;
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 20px;
            padding-right: 50px;
        }

        .current-image {
            margin-top: 8px;
            font-size: 14px;
            color: #666;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            background: #f0f4ff;
            border-radius: 8px;
        }

        .current-image i {
            color: #667eea;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #eaeaea;
        }

        .btn {
            flex: 1;
            padding: 18px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-save {
            background: linear-gradient(135deg, #7f97f5 0%, #a674f8 100%);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .btn-save:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.4);
        }

        .btn-save::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .btn-save:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        .btn-cancel {
            background: #f8f9fa;
            color: #666;
            border: 2px solid #e1e5e9;
        }

        .btn-cancel:hover {
            background: #e9ecef;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .error-message {
            background: #fee;
            border-left: 4px solid #ff6b6b;
            padding: 16px 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            color: #c33;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideIn 0.3s ease;
        }

        .file-hint {
            font-size: 13px;
            color: #888;
            margin-top: 8px;
            display: block;
            font-style: italic;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(-10px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @media (max-width: 768px) {
            .edit-container {
                margin: 10px;
                border-radius: 15px;
            }

            .edit-header {
                padding: 25px 20px;
            }

            .edit-content {
                padding: 25px 20px;
            }

            .attraction-id {
                position: relative;
                top: 0;
                right: 0;
                display: inline-block;
                margin-top: 10px;
            }

            .form-actions {
                flex-direction: column;
            }

            .form-input,
            .form-select,
            .form-textarea {
                padding: 14px 16px;
            }
        }
    </style>
</head>
<body>
<div class="edit-container">
    <div class="edit-header">
        <h2>编辑景点信息</h2>
        <p>修改景点资料</p>
        <div class="attraction-id">
            <i class="fas fa-hashtag"></i> ID: #${attraction.id}
        </div>
    </div>

    <div class="edit-content">
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                    ${error}
            </div>
        </c:if>

        <form action="AdminUpdateAttraction" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${attraction.id}">

            <div class="form-group">
                <label for="name">
                    <i class="fas fa-landmark"></i> 景点名称
                </label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${attraction.name}"
                       class="form-input"
                       required
                       placeholder="请输入景点名称">
            </div>

            <div class="form-group">
                <label for="cityName">
                    <i class="fas fa-city"></i> 所属城市
                </label>
                <select id="cityName" name="cityName" class="form-select" required>
                    <option value="">请选择城市</option>
                    <c:forEach items="${cityList}" var="city">
                        <option value="${city.name}"
                            ${city.id == attraction.cityId ? 'selected' : ''}>
                            🏙️ ${city.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="description">
                    <i class="fas fa-align-left"></i> 景点描述
                </label>
                <textarea id="description"
                          name="description"
                          class="form-textarea"
                          placeholder="请输入详细的景点描述"
                          required>${attraction.description}</textarea>
            </div>

            <div class="form-group">
                <label for="address">
                    <i class="fas fa-map-marker-alt"></i> 详细地址
                </label>
                <input type="text"
                       id="address"
                       name="address"
                       value="${attraction.address}"
                       class="form-input"
                       placeholder="请输入详细地址（可选）">
            </div>

            <div class="form-group">
                <label for="rating">
                    <i class="fas fa-star"></i> 评分
                </label>
                <input type="number"
                       id="rating"
                       name="rating"
                       value="${attraction.rating}"
                       class="form-input"
                       min="0"
                       max="5"
                       step="0.1"
                       placeholder="0-5分">
            </div>

            <div class="form-group">
                <label for="image">
                    <i class="fas fa-image"></i> 景点图片
                </label>
                <input type="file"
                       id="image"
                       name="image"
                       class="form-input">
                <c:if test="${not empty attraction.image}">
                    <div class="current-image">
                        <i class="fas fa-image"></i>
                        当前图片：<span style="color: #667eea;">${attraction.image}</span>
                    </div>
                </c:if>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-save">
                    <i class="fas fa-save"></i> 保存修改
                </button>
                <a href="AdminAttractionList?section=attractions" class="btn btn-cancel">
                    <i class="fas fa-times"></i> 返回列表
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // 表单验证
    document.querySelector('form').addEventListener('submit', function(e) {
        const name = document.getElementById('name').value.trim();
        const cityName = document.getElementById('cityName').value;
        const description = document.getElementById('description').value.trim();
        const rating = document.getElementById('rating').value;

        if (!name || !cityName || !description) {
            e.preventDefault();
            alert('请填写必填字段！');
            return;
        }

        if (rating) {
            const ratingNum = parseFloat(rating);
            if (ratingNum < 0 || ratingNum > 5) {
                e.preventDefault();
                alert('评分必须在0-5之间！');
                return;
            }
        }
    });

    document.getElementById('rating').addEventListener('input', function() {
        let value = parseFloat(this.value);
        if (isNaN(value)) return;

        if (value < 0) this.value = 0;
        if (value > 5) this.value = 5;

        this.value = Math.round(value * 10) / 10;
    });

</script>
</body>
</html>
