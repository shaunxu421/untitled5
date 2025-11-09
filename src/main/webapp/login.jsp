<%-- src/main/webapp/login.jsp (内嵌 CSS 精美版) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>买家登录</title>

    <%--
        ******************************************************
        * *
        * 我们把所有的 CSS 代码直接放在这里 ( <style> 标签内 ) *
        * 这就不再需要 <link href="css/style.css">          *
        * *
        ******************************************************
    --%>
    <style>
        /* ----------------------------------
           全局和背景
           ---------------------------------- */
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            /* 核心：使用平滑的渐变背景 */
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-size: cover; /* 确保渐变铺满全屏 */

            /* 使用 Flexbox 实现完美的垂直和水平居中 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh; /* 最小高度为视口高度 */
            margin: 0;
        }

        /* ----------------------------------
           登录框容器
           ---------------------------------- */
        .login-container {
            /* 核心：添加一个微妙的入场动画 */
            animation: fadeIn 0.6s ease-out;

            background-color: #ffffff;
            /* 更深的阴影，营造“卡片浮动”效果 */
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border-radius: 12px; /* 更圆的圆角 */

            padding: 40px 50px; /* 增加内边距 */
            width: 400px; /* 固定宽度，使其更大气 */
            box-sizing: border-box; /* 确保 padding 不会撑开宽度 */
            text-align: center;
        }

        /* 入场动画定义 */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ----------------------------------
           表单元素
           ---------------------------------- */
        .login-container h2 {
            color: #333;
            font-size: 32px; /* 更大的标题 */
            font-weight: 600; /* 稍细的字体 */
            margin-top: 0;
            margin-bottom: 35px;
        }

        .form-group {
            margin-bottom: 25px; /* 增加间距 */
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #555;
            font-weight: 600; /* 加粗标签 */
            font-size: 14px;
        }

        /* 核心：美化输入框 */
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 15px; /* 更大的内边距，手感更好 */
            border: 1px solid #ddd;
            border-radius: 8px; /* 圆角 */
            font-size: 16px;
            box-sizing: border-box;

            /* 核心：添加平滑的过渡效果 */
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        /* 核心：输入框获得焦点时的“发光”效果 */
        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus {
            outline: none; /* 移除默认的蓝色轮廓 */
            border-color: #667eea; /* 边框变为主题色 */
            /* 添加一个发光的阴影 */
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.2);
        }

        /* ----------------------------------
           登录按钮 (CTA - Call to Action)
           ---------------------------------- */
        .login-button {
            width: 100%;
            padding: 15px;

            /* 核心：使用与背景一致的渐变色 */
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 700; /* 加粗按钮文字 */
            cursor: pointer;

            /* 核心：添加过渡和阴影 */
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            margin-top: 10px; /* 留出一点空间 */
        }

        /* 核心：按钮的悬停效果 */
        .login-button:hover {
            /* 按钮轻微上浮 */
            transform: translateY(-2px);
            /* 阴影更明显 */
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .login-button:active {
            /* 按钮被点击时 */
            transform: translateY(0);
            box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
        }

        /* ----------------------------------
           错误信息
           ---------------------------------- */
        .error-message {
            color: #e74c3c; /* 鲜艳的红色 */
            font-weight: 600;
            margin-top: 20px;
            font-size: 15px;
        }
    </style>
</head>
<body>

<%--
    ******************************************************
    * *
    * 这里的 HTML 结构和我们之前用的是完全一样的        *
    * *
    ******************************************************
--%>

<div class="login-container">
    <h2>买家登录</h2>

    <%-- 登录失败时显示错误信息 --%>
    <p class="error-message">${requestScope.error}</p>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">用户名:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="login-button">登录</button>
    </form>
</div>
</body>
</html>