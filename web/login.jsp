<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #b2bcff 0%, #eeeeee 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            display: flex;
            width: 900px;
            height: 550px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #156eee 0%, #22b5fa 100%);
            color: white;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .welcome-text {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .sub-text {
            font-size: 16px;
            opacity: 0.9;
            line-height: 1.6;
        }

        .right-panel {
            flex: 1;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-title {
            font-size: 32px;
            color: #156eee;
            text-align: center;
            margin-bottom: 40px;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .input-field {
            width: 100%;
            height: 50px;
            padding: 0 20px;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            outline: none;
        }

        .input-field:focus {
            border-color: #156eee;
            box-shadow: 0 0 0 3px rgba(21, 110, 238, 0.1);
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .remember {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 14px;
        }

        .forgot-password {
            color: #156eee;
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            height: 50px;
            background: linear-gradient(135deg, #156eee 0%, #22b5fa 100%);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(21, 110, 238, 0.3);
        }

        .error-message {
            color: #ff4757;
            text-align: center;
            margin: 15px 0;
            font-size: 14px;
            min-height: 20px;
        }

        .register-link {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 14px;
        }

        .register-link a {
            color: #156eee;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .help-link {
            text-align: center;
            margin-top: 20px;
        }

        .help-link a {
            color: #999;
            text-decoration: none;
            font-size: 13px;
        }

        .help-link a:hover {
            color: #156eee;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                width: 90%;
                height: auto;
            }

            .left-panel {
                padding: 30px;
                text-align: center;
            }

            .right-panel {
                padding: 30px;
            }
        }
    </style>
</head>
<body>

<%
    String msg = null;
    String code = request.getParameter("code");
    if (code == null) {
        msg = "";
    } else {
        msg = "用户不存在或密码错误！";
    }
%>

<div class="container">
    <!-- 左侧欢迎面板 -->
    <div class="left-panel">
        <div class="welcome-text">欢迎回来</div>
        <div class="sub-text">
            <p>探索世界的美好从登录开始</p>
            <p style="margin-top: 15px;">加入我们，发现更多精彩的旅行攻略和目的地推荐，让每一次旅行都成为难忘的回忆。</p>
        </div>
    </div>

    <!-- 右侧登录面板 -->
    <div class="right-panel">
        <div class="login-title">用户登录</div>

        <form action="Login" method="post" id="loginForm">
            <div class="form-group">
                <input class="input-field" type="text" name="username" placeholder="请输入用户名" required>
            </div>

            <div class="form-group">
                <input class="input-field" type="password" name="password" placeholder="请输入密码" required>
            </div>

            <div class="remember-forgot">
                <label class="remember">
                    <input type="checkbox"> 记住我
                </label>
                <a href="#" class="forgot-password">忘记密码？</a>
            </div>

            <button type="submit" class="login-btn">登录</button>

            <div class="error-message"><%=msg%></div>

            <div class="register-link">
                还没有账号？ <a href="signup.jsp">立即注册</a>
            </div>

            <div class="help-link">
                <a href="#">帮助中心</a>
            </div>
        </form>
    </div>
</div>

<script>
    // 添加输入框动画效果
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.input-field');

        inputs.forEach(input => {
            // 输入时添加动画
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });
        });

        // 表单提交动画
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const btn = this.querySelector('.login-btn');
            btn.innerHTML = '登录中...';
            btn.style.opacity = '0.8';
        });
    });

</script>

</body>
</html>