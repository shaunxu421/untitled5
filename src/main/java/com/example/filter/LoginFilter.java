package com.example.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // 白名单
        if (uri.endsWith("login.jsp") || uri.endsWith("login") || uri.contains("/css/") || uri.contains("/js/")) {
            chain.doFilter(request, response);
        } else {
            // 检查是否登录
            HttpSession session = req.getSession(false);

            if (session != null && session.getAttribute("loggedInUser") != null) {
                // 已登录
                chain.doFilter(request, response);
            } else {
                // 未登录
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            }
        }
    }

    @Override public void init(FilterConfig filterConfig) throws ServletException {}
    @Override public void destroy() {}
}