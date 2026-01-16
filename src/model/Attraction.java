package com.model;


public class Attraction {
    private Integer id;
    private String name;
    private Integer cityId;
    private String description;
    private String address;
    private String image;
    private Double rating;
    private String cityName;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public Attraction(Integer id, String name, Integer cityId, String description,
                      String address, String image, Double rating) {
        this.id = id;
        this.name = name;
        this.cityId = cityId;
        this.description = description;
        this.address = address;
        this.image = image;
        this.rating = rating;
    }
}
