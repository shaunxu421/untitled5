package com.example.servlet;

import com.example.model.Cart;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取要删除的商品 ID
        int productId = Integer.parseInt(req.getParameter("productId"));

        // 2. 从 Session 获取购物车
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            // 3. 从购物车删除
            cart.removeItem(productId);
        }

        // 4. 重定向回购物车页面
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}