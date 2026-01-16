<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.model.City" %>
<%
    City city = (City) request.getAttribute("city");
    if (city == null) {
        response.sendRedirect("AdminCityList");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑城市 - 后台管理</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg,#e4ffff 0%, #d5f2fc 100%);
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
            max-width: 700px;
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

        .city-id {
            position: absolute;
            top: 20px;
            right: 30px;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            z-index: 1;
            backdrop-filter: blur(10px);
        }

        .edit-content {
            padding: 40px;
            max-height: 70vh;
            overflow-y: auto;
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
            color: #4facfe;
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
            border-color: #4facfe;
            background: white;
            box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.1);
        }

        .form-textarea {
            min-height: 100px;
            resize: vertical;
            line-height: 1.5;
        }

        .form-select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%234facfe' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
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
            background: #f0f7ff;
            border-radius: 8px;
        }

        .current-image i {
            color: #4facfe;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
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
            box-shadow: 0 12px 30px rgba(79, 172, 254, 0.4);
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

            .city-id {
                position: relative;
                top: 0;
                right: 0;
                display: inline-block;
                margin-top: 10px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 15px;
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
        <h2>编辑城市信息</h2>
        <p>修改城市资料</p>
        <div class="city-id">
            <i class="fas fa-hashtag"></i> ID: #${city.id}
        </div>
    </div>

    <div class="edit-content">
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                    ${error}
            </div>
        </c:if>

        <form action="AdminUpdateCity" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${city.id}">

            <div class="form-grid">
                <div class="form-group">
                    <label for="name">
                        <i class="fas fa-city"></i> 城市名称
                    </label>
                    <input type="text"
                           id="name"
                           name="name"
                           value="${city.name}"
                           class="form-input"
                           required
                           placeholder="请输入城市名称">
                </div>

                <div class="form-group">
                    <label for="province">
                        <i class="fas fa-map"></i> 所属省份
                    </label>
                    <input type="text"
                           id="province"
                           name="province"
                           value="${city.province}"
                           class="form-input"
                           required
                           placeholder="请输入省份名称">
                </div>
            </div>

            <div class="form-group">
                <label for="description">
                    <i class="fas fa-align-left"></i> 城市描述
                </label>
                <textarea id="description"
                          name="description"
                          class="form-textarea"
                          placeholder="请输入城市描述"
                          rows="3">${city.description}</textarea>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="bestSeason">
                        <i class="fas fa-sun"></i> 最佳旅游季节
                    </label>
                    <input type="text"
                           id="bestSeason"
                           name="bestSeason"
                           value="${city.bestSeason}"
                           class="form-input">
                </div>

                <div class="form-group">
                    <label for="climate">
                        <i class="fas fa-temperature-high"></i> 气候特点
                    </label>
                    <input type="text"
                           id="climate"
                           name="climate"
                           value="${city.climate}"
                           class="form-input">
                </div>
            </div>

            <div class="form-group">
                <label for="travelTips">
                    <i class="fas fa-lightbulb"></i> 旅行贴士
                </label>
                <textarea id="travelTips"
                          name="travelTips"
                          class="form-textarea"
                          placeholder="请输入旅行注意事项"
                          rows="2">${city.travelTips}</textarea>
            </div>

            <div class="form-group">
                <label for="isRecommended">
                    <i class="fas fa-star"></i> 推荐状态
                </label>
                <select id="isRecommended" name="isRecommended" class="form-select">
                    <option value="0" ${city.isRecommended == 0 ? 'selected' : ''}>
                        🌟 普通城市
                    </option>
                    <option value="1" ${city.isRecommended == 1 ? 'selected' : ''}>
                        ⭐ 推荐城市
                    </option>
                </select>
            </div>

            <div class="form-group">
                <label for="coverImage">
                    <i class="fas fa-image"></i> 封面图片
                </label>
                <input type="file"
                       id="coverImage"
                       name="coverImage"
                       class="form-input">
                <c:if test="${not empty city.coverImage}">
                    <div class="current-image">
                        <i class="fas fa-image"></i>
                        当前图片：<span style="color: #4facfe;">${city.coverImage}</span>
                    </div>
                </c:if>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-save">
                    <i class="fas fa-save"></i> 保存修改
                </button>
                <a href="AdminCityList?section=cities" class="btn btn-cancel">
                    <i class="fas fa-times"></i> 返回列表
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const name = document.getElementById('name').value.trim();
        const province = document.getElementById('province').value.trim();

        if (!name || !province) {
            e.preventDefault();
            alert('请填写必填字段（城市名称和所属省份）！');
            return;
        }

    });

    const inputs = document.querySelectorAll('.form-input, .form-textarea, .form-select');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentNode.style.transform = 'translateY(-2px)';
        });

        input.addEventListener('blur', function() {
            this.parentNode.style.transform = 'translateY(0)';
        });
    });
</script>
</body>
</html>