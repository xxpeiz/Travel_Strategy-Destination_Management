<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑用户 - 管理员</title>
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
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
            overflow: hidden;
        }

        .edit-header {
            background: linear-gradient(135deg, #aab7f6 0%, #e1cfff 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .edit-header h2 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .edit-header p {
            opacity: 0.9;
            font-size: 14px;
        }

        .edit-content {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-select {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 16px;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-select:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
        }

        .btn-save {
            background: linear-gradient(135deg, #7f97f5 0%, #a674f8 100%);
            color: white;
        }

        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-cancel {
            background: #f8f9fa;
            color: #666;
            border: 2px solid #e1e5e9;
        }

        .btn-cancel:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }

        .error-message {
            background: #fee;
            border-left: 4px solid #f44336;
            padding: 12px 16px;
            margin-bottom: 20px;
            border-radius: 8px;
            color: #c33;
            font-size: 14px;
        }

        .user-id {
            text-align: center;
            margin-top: 10px;
            color: #666;
            font-size: 14px;
        }

        @media (max-width: 600px) {
            .edit-container {
                margin: 10px;
            }

            .edit-content {
                padding: 30px 20px;
            }

            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="edit-container">
    <!-- 头部 -->
    <div class="edit-header">
        <h2>编辑用户信息</h2>
        <p>修改用户资料</p>
        <div class="user-id">用户ID: #${user.id}</div>
    </div>

    <!-- 内容区 -->
    <div class="edit-content">
        <!-- 错误提示 -->
        <c:if test="${not empty error}">
            <div class="error-message">
                ⚠️ ${error}
            </div>
        </c:if>

        <!-- 编辑表单 -->
        <form action="AdminUpdateUser" method="post">
            <input type="hidden" name="id" value="${user.id}">

            <!-- 用户名 -->
            <div class="form-group">
                <label for="username">
                    <i class="fas fa-user"></i> 用户名
                </label>
                <input type="text"
                       id="username"
                       name="username"
                       value="${user.username}"
                       class="form-input"
                       required
                       placeholder="请输入用户名">
            </div>

            <!-- 密码 -->
            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i> 密码
                </label>
                <input type="text"
                       id="password"
                       name="password"
                       value="${user.password}"
                       class="form-input"
                       required
                       placeholder="请输入密码">
            </div>

            <!-- 操作按钮 -->
            <div class="form-actions">
                <button type="submit" class="btn btn-save">
                    💾 保存修改
                </button>
                <a href="AdminUserList" class="btn btn-cancel">
                    ↩️ 返回列表
                </a>
            </div>
        </form>
    </div>
</div>


<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!username || !password) {
            e.preventDefault();
            alert('请填写完整信息！');
            return;
        }

    });

</script>
</body>
</html>
