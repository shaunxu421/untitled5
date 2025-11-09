package com.example.servlet;

import com.example.dao.ProductDao;
import com.example.model.Product;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ProductListServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取所有商品列表
        List<Product> productList = productDao.getAllProducts();

        // 2. 将商品列表存入 request 域
        req.setAttribute("productList", productList);

        // 3. 转发到商品列表 JSP 页面
        req.getRequestDispatcher("/productList.jsp").forward(req, resp);
    }

    // 通常商品列表是 GET 请求，不需要 doPost
}