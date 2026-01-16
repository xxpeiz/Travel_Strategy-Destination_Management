package com.model;

public class City {
    private Integer id;
    private String name;
    private String province;
    private String description;
    private String bestSeason;
    private String climate;
    private String travelTips;
    private String coverImage;
    private Integer isRecommended;

    public City(){}

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

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getClimate() {
        return climate;
    }

    public void setClimate(String climate) {
        this.climate = climate;
    }

    public String getBestSeason() {
        return bestSeason;
    }

    public void setBestSeason(String bestSeason) {
        this.bestSeason = bestSeason;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTravelTips() {
        return travelTips;
    }

    public void setTravelTips(String travelTips) {
        this.travelTips = travelTips;
    }

    public Integer getIsRecommended() {
        return isRecommended;
    }

    public void setIsRecommended(Integer isRecommended) {
        this.isRecommended = isRecommended;
    }

    public City(Integer id,String name, String province,String description,String bestSeason,String climate,String travelTips,String coverImage,Integer isRecommended) {
        this.id = id;
        this.name = name;
        this.province = province;
        this.description=description;
        this.bestSeason = bestSeason;
        this.climate=climate;
        this.travelTips=travelTips;
        this.coverImage=coverImage;
        this.isRecommended = isRecommended;
    }
}
