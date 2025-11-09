package com.example.servlet;

import com.example.dao.ProductDao;
import com.example.model.Cart;
import com.example.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddToCartServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取要添加的商品 ID
        int productId = Integer.parseInt(req.getParameter("productId"));

        // 2. 从 Session 中获取购物车
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // 3. 根据 ID 获取商品
        Product product = productDao.getProductById(productId);

        // 4. 将商品添加到购物车
        if (product != null) {
            cart.addItem(product);
        }

        // 5. 重定向回商品列表页（或购物车页）
        // 这里我们重定向到 /cart，让用户立刻看到购物车
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}