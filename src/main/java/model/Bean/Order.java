package model.Bean;

import java.time.LocalDate;
import java.time.LocalTime;


public class Order {
    private int idOrder;
    private String status;
    private LocalDate date;
    private LocalTime time;
    private float total;
    private int idBillingAddress;
    private int idShippingAddress;
    private int idUser;

    public Order(int idUser, int idShippingAddress, int idBillingAddress, float total, LocalTime time, LocalDate date, String status, int idOrder) {
        this.idUser = idUser;
        this.idShippingAddress = idShippingAddress;
        this.idBillingAddress = idBillingAddress;
        this.total = total;
        this.time = time;
        this.date = date;
        this.status = status;
        this.idOrder = idOrder;
    }
    public Order() {
    }

    public int getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(int idOrder) {
        this.idOrder = idOrder;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdBillingAddress() {
        return idBillingAddress;
    }

    public void setIdBillingAddress(int idBillingAddress) {
        this.idBillingAddress = idBillingAddress;
    }

    public int getIdShippingAddress() {
        return idShippingAddress;
    }

    public void setIdShippingAddress(int idShippingAddress) {
        this.idShippingAddress = idShippingAddress;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public LocalTime getTime() {
        return time;
    }

    public void setTime(LocalTime time) {
        this.time = time;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
