<%-- src/main/webapp/productList.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品列表 - 买家中心</title>

    <%-- *********************************************** --%>
    <%-- * 内嵌 CSS，确保样式 100% 加载 * --%>
    <%-- *********************************************** --%>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            margin: 0;
            background-color: #f9f9f9;
        }

        .header {
            background-color: #ffffff;
            color: #333;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            position: sticky; /* 头部固定 */
            top: 0;
            z-index: 1000;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            color: #2c3e50;
        }

        .header .user-info {
            font-size: 16px;
            color: #555;
        }

        .header .user-info a {
            color: #007bff;
            text-decoration: none;
            margin-left: 20px;
            transition: color 0.3s ease;
            font-weight: 500;
        }

        /* 购物车链接样式 */
        .header .user-info a.cart-link {
            color: #28a745;
            font-weight: bold;
        }

        .header .user-info a:hover {
            color: #0056b3;
        }
        .header .user-info a.cart-link:hover {
            color: #218838;
        }

        .product-grid {
            display: grid;
            /* 响应式网格布局: 自动填充，最小 280px, 最大 1fr */
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px; /* 卡片间距 */
            padding: 40px;
            max-width: 1300px;
            margin: 20px auto; /* 页面居中 */
        }

        .product-card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden; /* 确保图片圆角 */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-8px); /* 悬停时上浮 */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .product-card img {
            width: 100%;
            height: 220px; /* 固定图片高度 */
            object-fit: cover; /* 保持图片比例，裁剪超出部分 */
        }

        .product-info {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .product-info h3 {
            margin-top: 0;
            margin-bottom: 10px;
            color: #333;
            font-size: 20px;
            font-weight: 600;
        }

        .product-info p.description {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 15px;
            flex-grow: 1; /* 占据剩余空间，让价格和按钮在底部对齐 */
            /* 最多显示 3 行描述 */
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }

        .product-info .price {
            font-size: 26px;
            color: #e63946; /* 醒目的红色价格 */
            font-weight: bold;
            margin-bottom: 15px;
        }

        .add-to-cart-button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .add-to-cart-button:hover {
            background-color: #0056b3;
            transform: scale(1.02); /* 悬停时轻微放大 */
        }
    </style>
</head>
<body>
<div class="header">
    <h1>商品列表</h1>
    <div class="user-info">
        欢迎您，${sessionScope.loggedInUser}！
        <%-- *********************************************** --%>
        <%-- * 1. 新增：购物车链接 * --%>
        <%-- *********************************************** --%>
        <a href="${pageContext.request.contextPath}/cart" class="cart-link">我的购物车</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>

<div class="product-grid">
    <%-- *********************************************** --%>
    <%-- * 2. 检查 JSTL 循环和价格格式化 * --%>
    <%-- *********************************************** --%>
    <c:forEach var="product" items="${requestScope.productList}">
        <div class="product-card">
            <img src="${product.imageUrl}" alt="${product.name}">
            <div class="product-info">
                <h3>${product.name}</h3>
                <p class="description">${product.description}</p>
                <p class="price">
                    <fmt:setLocale value="zh_CN"/>
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="¥ "/>
                </p>

                    <%-- *********************************************** --%>
                    <%-- * 3. 修改：链接到 AddToCartServlet * --%>
                    <%-- *********************************************** --%>
                <a href="${pageContext.request.contextPath}/addToCart?productId=${product.id}" class="add-to-cart-button">
                    加入购物车
                </a>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>