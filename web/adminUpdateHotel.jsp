<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.model.Hotel" %>
<%@ page import="java.math.BigDecimal" %>
<%
    Hotel hotel = (Hotel) request.getAttribute("hotel");
    if (hotel == null) {
        response.sendRedirect("AdminHotelList");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑酒店 - 后台管理</title>
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

        .hotel-id {
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
            color: #6a11cb;
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
            border-color: #6a11cb;
            background: white;
            box-shadow: 0 0 0 4px rgba(106, 17, 203, 0.1);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
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
            background: #f3e6ff;
            border-radius: 8px;
        }

        .current-image i {
            color: #6a11cb;
        }

        .star-rating-display {
            display: flex;
            gap: 2px;
            margin-top: 5px;
        }

        .star {
            color: #ffd700;
            font-size: 18px;
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
            background: linear-gradient(135deg,#7f97f5 0%, #a674f8 100%);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .btn-save:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(106, 17, 203, 0.4);
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

            .hotel-id {
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
            .form-select {
                padding: 14px 16px;
            }
        }
    </style>
</head>
<body>
<div class="edit-container">
    <div class="edit-header">
        <h2>编辑酒店信息</h2>
        <p>修改酒店资料</p>
        <div class="hotel-id">
            <i class="fas fa-hashtag"></i> ID: #${hotel.id}
        </div>
    </div>

    <div class="edit-content">
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                    ${error}
            </div>
        </c:if>

        <form action="AdminUpdateHotel" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${hotel.id}">

            <div class="form-group">
                <label for="name">
                    <i class="fas fa-hotel"></i> 酒店名称
                </label>
                <input type="text"
                       id="name"
                       name="name"
                       value="${hotel.name}"
                       class="form-input"
                       required
                       placeholder="请输入酒店名称">
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="cityName">
                        <i class="fas fa-city"></i> 所属城市
                    </label>
                    <select id="cityName" name="cityName" class="form-select" required>
                        <option value="">请选择城市</option>
                        <c:forEach items="${cityList}" var="city">
                            <option value="${city.name}"
                                ${city.id == hotel.cityId ? 'selected' : ''}>
                                🏙️ ${city.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="address">
                        <i class="fas fa-map-marker-alt"></i> 详细地址
                    </label>
                    <input type="text"
                           id="address"
                           name="address"
                           value="${hotel.address}"
                           class="form-input"
                           placeholder="请输入详细地址">
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label for="phone">
                        <i class="fas fa-phone"></i> 联系电话
                    </label>
                    <input type="tel"
                           id="phone"
                           name="phone"
                           value="${hotel.phone}"
                           class="form-input"
                           placeholder="请输入联系电话">
                </div>

                <div class="form-group">
                    <label for="price">
                        <i class="fas fa-money-bill-wave"></i> 价格（元/晚）
                    </label>
                    <input type="number"
                           id="price"
                           name="price"
                           value="${hotel.price != null ? hotel.price : ''}"
                           class="form-input"
                           min="0"
                           step="0.01"
                           placeholder="请输入价格">
                </div>
            </div>

            <div class="form-group">
                <label for="starRating">
                    <i class="fas fa-star"></i> 星级
                </label>
                <select id="starRating" name="starRating" class="form-select">
                    <option value="1" ${hotel.starRating == 1 ? 'selected' : ''}>★ 经济型</option>
                    <option value="2" ${hotel.starRating == 2 ? 'selected' : ''}>★★ 舒适型</option>
                    <option value="3" ${hotel.starRating == 3 ? 'selected' : ''}>★★★ 高档型</option>
                    <option value="4" ${hotel.starRating == 4 ? 'selected' : ''}>★★★★ 豪华型</option>
                    <option value="5" ${hotel.starRating == 5 ? 'selected' : ''}>★★★★★ 超豪华型</option>
                </select>
                <div class="star-rating-display">
                    <c:forEach begin="1" end="${hotel.starRating}" varStatus="loop">
                        <span class="star">★</span>
                    </c:forEach>
                    <c:if test="${hotel.starRating < 5}">
                        <c:forEach begin="${hotel.starRating + 1}" end="5" varStatus="loop">
                            <span class="star" style="color: #ccc;">☆</span>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <div class="form-group">
                <label for="image">
                    <i class="fas fa-image"></i> 酒店图片
                </label>
                <input type="file"
                       id="image"
                       name="image"
                       class="form-input">
                <c:if test="${not empty hotel.image}">
                    <div class="current-image">
                        <i class="fas fa-image"></i>
                        当前图片：<span style="color: #6a11cb;">${hotel.image}</span>
                    </div>
                </c:if>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-save">
                    <i class="fas fa-save"></i> 保存修改
                </button>
                <a href="AdminHotelList?section=hotels" class="btn btn-cancel">
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
        const phone = document.getElementById('phone').value.trim();
        const price = document.getElementById('price').value.trim();

        if (!name || !cityName) {
            e.preventDefault();
            alert('请填写必填字段（酒店名称和所属城市）！');
            return;
        }
    });

    // 星级选择变化时更新显示
    const starRatingSelect = document.getElementById('starRating');
    const starDisplay = document.querySelector('.star-rating-display');

    function updateStarDisplay(rating) {
        let starsHtml = '';
        for (let i = 1; i <= 5; i++) {
            if (i <= rating) {
                starsHtml += '<span class="star" style="color: #ffd700;">★</span>';
            } else {
                starsHtml += '<span class="star" style="color: #ccc;">☆</span>';
            }
        }
        starDisplay.innerHTML = starsHtml;
    }

    starRatingSelect.addEventListener('change', function() {
        updateStarDisplay(parseInt(this.value));
    });

    // 初始化星级显示
    updateStarDisplay(parseInt(starRatingSelect.value));



    const priceInput = document.getElementById('price');
    if (priceInput) {
        priceInput.addEventListener('blur', function() {
            let value = this.value.trim();
            if (value) {
                // 保留两位小数
                const num = parseFloat(value);
                if (!isNaN(num)) {
                    this.value = num.toFixed(2);
                }
            }
        });
    }


    const inputs = document.querySelectorAll('.form-input, .form-select');
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
