package com.service;

import com.model.City;
import com.tools.DbUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CityService {

    private DbUtils dbUtils = new DbUtils();

    public List<City> getHotCitiesAll() {
        String sql = "SELECT * FROM city WHERE is_recommended = 1";
        ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
        List<City> cities = new ArrayList<>();
        for (HashMap<String, Object> map : mapList) {
            Integer id = Integer.parseInt(map.get("id").toString());
            String name=map.get("name").toString();
            String province=map.get("province").toString();
            String description=map.get("description").toString();
            String bestSeason=map.get("best_season").toString();
            String climate=map.get("climate").toString();
            String travelTips=map.get("travel_tips").toString();
            String coverImage=map.get("cover_image").toString();
            String isRecommended = map.get("is_recommended").toString();
            int recommended = "true".equals(isRecommended) ? 1 : 0;

            cities.add(new City(id, name, province, description, bestSeason,climate,travelTips,coverImage,recommended));
        }
        return cities;
    }

    public List<City> getCitiesAll() {
        String sql = "SELECT * FROM city";
        ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
        List<City> cities = new ArrayList<>();
        for (HashMap<String, Object> map : mapList) {
            Integer id = Integer.parseInt(map.get("id").toString());
            String name=map.get("name").toString();
            String province=map.get("province").toString();
            String description=map.get("description").toString();
            String bestSeason=map.get("best_season").toString();
            String climate=map.get("climate").toString();
            String travelTips=map.get("travel_tips").toString();
            String coverImage=map.get("cover_image").toString();
            String isRecommended = map.get("is_recommended").toString();
            int recommended = "true".equals(isRecommended) ? 1 : 0;

            cities.add(new City(id, name, province, description, bestSeason,climate,travelTips,coverImage,recommended));
        }
        return cities;
    }

    public City getCityById(Integer cityId) {
            String sql = "SELECT * FROM city WHERE id = " + cityId;
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);

            if (mapList != null && !mapList.isEmpty()) {
                HashMap<String, Object> map = mapList.get(0);
                Integer id = Integer.parseInt(map.get("id").toString());
                String name = map.get("name").toString();
                String province = map.get("province").toString();
                String description = map.get("description") != null ? map.get("description").toString() : "";
                String bestSeason = map.get("best_season") != null ? map.get("best_season").toString() : "";
                String climate = map.get("climate") != null ? map.get("climate").toString() : "";
                String travelTips = map.get("travel_tips") != null ? map.get("travel_tips").toString() : "";
                String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "default-city.jpg";

                String isRecommended = map.get("is_recommended").toString();
                int recommended = "true".equals(isRecommended) ? 1 : 0;

                return new City(id, name, province, description, bestSeason, climate, travelTips, coverImage, recommended);
            }
            return null;
    }

    public boolean addCity(City city) {
        DbUtils db = new DbUtils();
        String sql = String.format(
                "INSERT INTO city (name, province, description, best_season, climate, travel_tips, cover_image, is_recommended) " +
                        "VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', %d)",
                city.getName().replace("'", "''"),
                city.getProvince() != null ? city.getProvince().replace("'", "''") : "",
                city.getDescription() != null ? city.getDescription().replace("'", "''") : "",
                city.getBestSeason() != null ? city.getBestSeason().replace("'", "''") : "",
                city.getClimate() != null ? city.getClimate().replace("'", "''") : "",
                city.getTravelTips() != null ? city.getTravelTips().replace("'", "''") : "",
                city.getCoverImage() != null ? city.getCoverImage().replace("'", "''") : "",
                city.getIsRecommended() != null ? city.getIsRecommended() : 0
        );
        int rows = db.update(sql);
        return rows > 0;
    }
    public boolean updateCity(City city) {
        String sql = String.format(
                "UPDATE city SET " +
                        "name = '%s', " +
                        "province = '%s', " +
                        "description = '%s', " +
                        "best_season = '%s', " +
                        "climate = '%s', " +
                        "travel_tips = '%s', " +
                        "cover_image = '%s', " +
                        "is_recommended = %d " +
                        "WHERE id = %d",
                city.getName().replace("'", "''"),
                city.getProvince() != null ? city.getProvince().replace("'", "''") : "",
                city.getDescription() != null ? city.getDescription().replace("'", "''") : "",
                city.getBestSeason() != null ? city.getBestSeason().replace("'", "''") : "",
                city.getClimate() != null ? city.getClimate().replace("'", "''") : "",
                city.getTravelTips() != null ? city.getTravelTips().replace("'", "''") : "",
                city.getCoverImage() != null ? city.getCoverImage().replace("'", "''") : "",
                city.getIsRecommended() != null ? city.getIsRecommended() : 0,
                city.getId()
        );
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean deleteCity(int id) {
        String sql = "DELETE FROM city WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean recommendCity(int id) {
        String sql = "UPDATE city SET is_recommended = 1 WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean cancelRecommendCity(int id) {
        String sql = "UPDATE city SET is_recommended = 0 WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }
}
