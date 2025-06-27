package model.Bean;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;


public class Order {
    private int orderId;
    private String status;
    private LocalDate orderDate;
    private LocalTime orderTime;
    private float totalAmount;
    private int billingAddressId;
    private int shippingAddressId;
    private int userId;
    private List<OrderItem> orderItems;



    public Order(int idOrder, int idUser, int idBillingAddress, int idShippingAddress, float total, LocalTime time, LocalDate date, String status) {
        this.orderId = idOrder;
        this.userId = idUser;
        this.billingAddressId = idBillingAddress;
        this.shippingAddressId = idShippingAddress;
        this.totalAmount = total;
        this.orderTime = time;
        this.orderDate = date;
        this.status = status;
    }

    public Order() {
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getShippingAddressId() {
        return shippingAddressId;
    }

    public void setShippingAddressId(int shippingAddressId) {
        this.shippingAddressId = shippingAddressId;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getBillingAddressId() {
        return billingAddressId;
    }

    public void setBillingAddressId(int billingAddressId) {
        this.billingAddressId = billingAddressId;
    }

    public LocalTime getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(LocalTime orderTime) {
        this.orderTime = orderTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
}
