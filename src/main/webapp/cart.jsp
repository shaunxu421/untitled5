<%-- src/main/webapp/cart.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的购物车</title>

    <%-- *********************************************** --%>
    <%-- * 内嵌 CSS * --%>
    <%-- *********************************************** --%>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            margin: 0;
            background-color: #f9f9f9;
        }

        /* 复制 productList.jsp 的头部样式 */
        .header {
            background-color: #ffffff;
            color: #333;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            position: sticky;
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
        .header .user-info a:hover {
            color: #0056b3;
        }
        .header .user-info a.home-link {
            color: #28a745;
            font-weight: bold;
        }
        .header .user-info a.home-link:hover {
            color: #218838;
        }

        /* 购物车容器 */
        .cart-container {
            max-width: 1100px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 40px;
        }

        .cart-empty {
            text-align: center;
            padding: 50px;
        }
        .cart-empty h2 {
            color: #555;
            font-size: 24px;
        }
        .cart-empty a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .cart-empty a:hover {
            background-color: #0056b3;
        }

        /* 购物车表格 */
        .cart-table {
            width: 100%;
            border-collapse: collapse; /* 移除单元格间距 */
        }
        .cart-table th, .cart-table td {
            padding: 20px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .cart-table th {
            color: #888;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* 商品信息单元格 */
        .product-cell {
            display: flex;
            align-items: center;
        }
        .product-cell img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }
        .product-cell .product-name {
            font-size: 18px;
            color: #333;
            font-weight: 600;
        }

        /* 价格和数量 */
        .price-cell, .subtotal-cell {
            font-size: 18px;
            color: #333;
            font-weight: 500;
        }
        .quantity-cell input[type="number"] {
            width: 60px;
            padding: 8px;
            font-size: 16px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        /* 按钮 */
        .update-button {
            padding: 8px 15px;
            background-color: #ffc107;
            color: #333;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .update-button:hover {
            background-color: #e0a800;
        }
        .remove-link {
            color: #dc3545;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        .remove-link:hover {
            color: #a71d2a;
            text-decoration: underline;
        }

        /* 购物车总结 */
        .cart-summary {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #eee;
            text-align: right;
        }
        .cart-summary h2 {
            font-size: 28px;
            color: #333;
            margin: 0;
        }
        .cart-summary .total-price {
            color: #e63946;
            font-weight: bold;
        }

    </style>
</head>
<body>
<fmt:setLocale value="zh_CN"/>

<div class="header">
    <h1>我的购物车</h1>
    <div class="user-info">
        欢迎您，${sessionScope.loggedInUser}！
        <a href="${pageContext.request.contextPath}/productList" class="home-link">返回商城</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>

<div class="cart-container">

    <%-- JSTL c:choose 类似于 if-else --%>
    <%-- 检查购物车是否为空 (sessionScope.cart.items) --%>
    <c:choose>
        <%-- 1. 购物车不为空 --%>
        <c:when test="${not empty sessionScope.cart.items}">
            <table class="cart-table">
                <thead>
                <tr>
                    <th>商品</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <%-- 循环显示购物车中的商品 --%>
                <c:forEach var="item" items="${sessionScope.cart.items}">

                    <%-- 每一个商品都是一个单独的表单，用于更新数量 --%>
                    <form action="${pageContext.request.contextPath}/updateCart" method="post">

                            <%-- 隐藏域，用于传递商品ID --%>
                        <input type="hidden" name="productId" value="${item.product.id}">

                        <tr>
                            <td class="product-cell">
                                <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                <span class="product-name">${item.product.name}</span>
                            </td>
                            <td class="price-cell">
                                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="¥ "/>
                            </td>
                            <td class="quantity-cell">
                                <input type="number" name="quantity" value="${item.quantity}" min="0">
                            </td>
                            <td class="subtotal-cell">
                                <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="¥ "/>
                            </td>
                            <td>
                                <button type="submit" class="update-button">更新</button>
                                <br>
                                <a href="${pageContext.request.contextPath}/removeFromCart?productId=${item.product.id}" class="remove-link">移除</a>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
                </tbody>
            </table>

            <%-- 购物车总计 --%>
            <div class="cart-summary">
                <h2>
                    总花费：
                    <span class="total-price">
                            <fmt:formatNumber value="${sessionScope.cart.totalCost}" type="currency" currencySymbol="¥ "/>
                        </span>
                </h2>
            </div>

        </c:when>

        <%-- 2. 购物车为空 --%>
        <c:otherwise>
            <div class="cart-empty">
                <h2>您的购物车空空如也...</h2>
                <a href="${pageContext.request.contextPath}/productList">马上去逛逛</a>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>