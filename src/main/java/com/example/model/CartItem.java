package com.example.model;

import java.io.Serializable;

public class CartItem implements Serializable {

    private Product product;
    private int quantity;

    public CartItem(Product product) {
        this.product = product;
        this.quantity = 1; // 默认添加 1 件
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // 增加数量
    public void incrementQuantity() {
        this.quantity++;
    }

    // 计算小计
    public double getSubtotal() {
        return this.product.getPrice() * this.quantity;
    }
}