package com.example.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap; // 使用 LinkedHashMap 保证商品添加顺序
import java.util.Map;

public class Cart implements Serializable {

    // 键：商品ID (Integer), 值：购物车项 (CartItem)
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new LinkedHashMap<>();
    }

    // 1. 添加商品
    public void addItem(Product product) {
        int productId = product.getId();
        if (items.containsKey(productId)) {
            // 如果已存在，数量+1
            items.get(productId).incrementQuantity();
        } else {
            // 如果不存在，新加一项
            items.put(productId, new CartItem(product));
        }
    }

    // 2. 更新商品数量
    public void updateItem(int productId, int quantity) {
        if (items.containsKey(productId)) {
            if (quantity > 0) {
                items.get(productId).setQuantity(quantity);
            } else {
                // 数量为 0 或更少，则移除
                removeItem(productId);
            }
        }
    }

    // 3. 移除商品
    public void removeItem(int productId) {
        items.remove(productId);
    }

    // 4. 清空购物车
    public void clear() {
        items.clear();
    }

    // 5. 获取所有购物车项
    public Collection<CartItem> getItems() {
        return items.values();
    }

    // 6. 计算总花费
    public double getTotalCost() {
        double total = 0.0;
        for (CartItem item : items.values()) {
            total += item.getSubtotal();
        }
        return total;
    }
}