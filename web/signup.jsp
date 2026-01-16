<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
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

        .box {
            background-color: white;
            width: 450px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .box_1 {
            padding: 50px 40px;
            text-align: center;
        }

        .denglu {
            font-size: 32px;
            color: #156eee;
            margin-bottom: 40px;
            font-weight: bold;
        }

        .input1, .input2 {
            width: 100%;
            height: 50px;
            border-radius: 8px;
            border: 2px solid #e1e5e9;
            outline: none;
            transition: all 0.3s ease;
            font-size: 16px;
            padding: 0 20px;
            margin-bottom: 25px;
        }

        .input1:focus, .input2:focus {
            border-color: #156eee;
            box-shadow: 0 0 0 3px rgba(21, 110, 238, 0.1);
        }

        button {
            width: 100%;
            height: 50px;
            background: linear-gradient(135deg, #156eee 0%, #22b5fa 100%);
            border: none;
            border-radius: 8px;
            font-size: 18px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(21, 110, 238, 0.3);
        }

        .help {
            color: #999;
            text-decoration: none;
            font-size: 14px;
            margin-top: 20px;
            display: inline-block;
        }

        .help:hover {
            color: #156eee;
        }

        .message {
            margin: 15px 0;
            min-height: 20px;
        }

        .message a {
            color: #156eee;
            text-decoration: none;
            margin-left: 10px;
            font-weight: bold;
        }

        .message a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<%
    String msg = null;
    String error = request.getParameter("error");
    if (error == null){
        msg = "";
    }else if(error.equals("success")) {
        msg = "注册成功！";
    }else{
        msg = "注册失败！";
    }
%>

<div class="box">
    <div class="box_1">
        <div class="denglu">欢迎注册</div>

        <form action="SignUp" method="post">

            <input class="input1" type="text" name="username" placeholder="用户名">
            <input class="input2" type="password" name="password" placeholder="密码">

            <button>注册</button>

            <div class="message" style="color:red;text-decoration: none">
                <%=msg%><a href="Home">返回</a>
            </div>

            <a href="" class="help">帮助中心</a>

        </form>
    </div>
</div>

</body>
</html>