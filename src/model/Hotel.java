package com.model;

import java.math.BigDecimal;

public class Hotel {
    private Integer id;
    private String name;
    private Integer cityId;
    private String address;
    private String phone;
    private BigDecimal price;
    private Integer starRating;
    private String image;
    private String cityName;

    public Hotel() {}

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getStarRating() {
        return starRating;
    }

    public void setStarRating(Integer starRating) {
        this.starRating = starRating;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public Hotel(Integer id, String name, Integer cityId, String address,
                 String phone, BigDecimal price, Integer starRating, String image) {
        this.id = id;
        this.name = name;
        this.cityId = cityId;
        this.address = address;
        this.phone = phone;
        this.price = price;
        this.starRating = starRating;
        this.image = image;
    }
}