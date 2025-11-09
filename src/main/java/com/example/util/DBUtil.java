package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // !! 更改点:
    // 1. URL中移除了 serverTimezone=UTC (MySQL 5.x 驱动通常不需要)
    // 2. 确保使用 useSSL=false 和 characterEncoding=utf8
    private static final String URL = "jdbc:mysql://localhost:3306/buy?useSSL=false&characterEncoding=utf8";
    private static final String USER = "root"; // 替换为你的数据库用户名
    private static final String PASSWORD = "root"; // 替换为你的数据库密码

    static {
        try {
            // !! 更改点: 驱动类名从 cj 驱动改为 5.x 的驱动
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("MySQL 5.x 驱动加载失败!");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}