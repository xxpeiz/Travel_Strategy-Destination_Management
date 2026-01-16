<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    session.invalidate();
%>
<html>
<head>
    <title>退出登录</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #b2bcff 0%, #eeeeee 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .logout-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }
        .logout-icon {
            font-size: 48px;
            color: #156eee;
            margin-bottom: 20px;
        }
        .logout-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }
        .logout-message {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.6;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
        }
        .btn-secondary {
            background: #f5f5f5;
            color: #333;
            border: 1px solid #ddd;
        }
        .btn-secondary:hover {
            background: #e9e9e9;
        }
    </style>
</head>
<body>
<div class="logout-container">
    <div class="logout-icon">👋</div>
    <h2 class="logout-title">您已成功退出登录</h2>
    <p class="logout-message">
        感谢您使用到哪旅行网<br>
        期待您的再次光临！
    </p>
    <div class="btn-group">
        <a href="Home" class="btn btn-secondary">返回首页</a>
    </div>
</div>

<script>
    localStorage.removeItem('userToken');
    sessionStorage.clear();
</script>
</body>
</html>
