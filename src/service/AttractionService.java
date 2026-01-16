package com.service;

import com.model.Attraction;
import com.model.Note;
import com.tools.DbUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class AttractionService {

    private DbUtils dbUtils = new DbUtils();

    public List<Attraction> queryAttractionsByCityId(Integer cityId) {
            String sql = "SELECT * FROM attraction WHERE city_id = " + cityId + " ORDER BY rating DESC";
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Attraction> attractions = new ArrayList<>();

            for (HashMap<String, Object> map : mapList) {
                try {
                    Integer id = Integer.parseInt(map.get("id").toString());
                    String name = map.get("name").toString();
                    Integer attractionCityId = Integer.parseInt(map.get("city_id").toString());
                    String description = map.get("description") != null ? map.get("description").toString() : "";
                    String address = map.get("address") != null ? map.get("address").toString() : "";
                    String image = map.get("image") != null ? map.get("image").toString() : "default-attraction.jpg";
                    Double rating = Double.parseDouble(map.get("rating").toString());

                    Attraction attraction = new Attraction(id, name, attractionCityId, description, address, image, rating);
                    attractions.add(attraction);

                } catch (Exception e) {
                    System.err.println("解析景点数据时出错: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            return attractions;
    }

    public Attraction queryAttractionById(Integer attractionId) {
            String sql = "SELECT * FROM attraction WHERE id = " + attractionId;
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);

            if (mapList != null && !mapList.isEmpty()) {
                HashMap<String, Object> map = mapList.get(0);

                Integer id = Integer.parseInt(map.get("id").toString());
                String name = map.get("name").toString();
                Integer cityId = Integer.parseInt(map.get("city_id").toString());
                String description = map.get("description") != null ? map.get("description").toString() : "";
                String address = map.get("address") != null ? map.get("address").toString() : "";
                String image = map.get("image") != null ? map.get("image").toString() : "default-attraction.jpg";
                Double rating = Double.parseDouble(map.get("rating").toString());

                Attraction attraction = new Attraction(id, name, cityId, description, address, image, rating);
                return attraction;
            }
            return null;
    }

    public List<Attraction> getAllAttractions() {
        String sql = "SELECT * FROM attraction";
        ArrayList<HashMap<String, Object>> result = dbUtils.queryForList(sql);
        List<Attraction> list = new ArrayList<>();
        for (HashMap<String, Object> map : result) {
                Integer id = Integer.parseInt(map.get("id").toString());
                String name = map.get("name").toString();
                Integer cityId = Integer.parseInt(map.get("city_id").toString());
                String description = map.get("description") != null ? map.get("description").toString() : "";
                String address = map.get("address") != null ? map.get("address").toString() : "";
                String image = map.get("image") != null ? map.get("image").toString() : "default-attraction.jpg";
                Double rating = Double.parseDouble(map.get("rating").toString());

                Attraction attraction = new Attraction(id, name, cityId, description, address, image, rating);
                list.add(attraction);
        }
        return list;
    }
    public boolean addAttraction(String name,Integer cityId,String description,String address,String image,Double rating) {
        String sql = "INSERT INTO attraction (name, city_id, description, address, image, rating) " +
                        "VALUES ('"+name+"','"+cityId+"','"+description+"','"+address+"', '"+image+"','"+rating+"')";
        int rows = dbUtils.update(sql);
        return rows > 0;
    }
    public boolean deleteAttraction(int id) {
        String sql = "DELETE FROM attraction WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }
    public boolean updateAttraction(int id, String name, Integer cityId, String description,
                                    String address, String image, Double rating) {

        String sql = "UPDATE attraction SET " +
                "name = '" + name + "', " +
                "city_id = " + cityId + ", " +
                "description = '" + description + "', " +
                "address = '" + address + "', " +
                "image = '" + image + "', " +
                "rating = " + rating + " " +
                "WHERE id = " + id;

        int rows = dbUtils.update(sql);
        return rows > 0;
    }


    public boolean checkUserCollected(int userId, int attractionId) {
        try {
            String sql = "SELECT * FROM collection WHERE user_id = " + userId + " AND attraction_id = " + attractionId;
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            return mapList != null && !mapList.isEmpty();
        } catch (Exception e) {
            System.err.println("检查用户收藏状态时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean addCollection(int userId, int attractionId) {
        try {
            String sql = "INSERT INTO collection (user_id, attraction_id) VALUES (" + userId + ", " + attractionId + ")";
            int result = dbUtils.update(sql);
            return result > 0;
        } catch (Exception e) {
            System.err.println("添加收藏记录时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public boolean removeCollection(int userId, int attractionId) {
        try {
            String sql = "DELETE FROM collection WHERE user_id = " + userId + " AND attraction_id = " + attractionId;
            int result = dbUtils.update(sql);
            return result > 0;
        } catch (Exception e) {
            System.err.println("删除收藏记录时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public List<Attraction> getUserCollections(int userId) {
            String sql = "SELECT a.*, c.name as city_name " +
                    "FROM attraction a " +
                    "INNER JOIN collection col ON a.id = col.attraction_id " +
                    "LEFT JOIN city c ON a.city_id = c.id " +
                    "WHERE col.user_id = " + userId + " " +
                    "ORDER BY col.id DESC";

            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Attraction> attractions = new ArrayList<>();

            for (HashMap<String, Object> map : mapList) {
                Integer id = Integer.parseInt(map.get("id").toString());
                String name = map.get("name").toString();
                Integer cityId = Integer.parseInt(map.get("city_id").toString());
                String description = map.get("description") != null ? map.get("description").toString() : "";
                String address = map.get("address") != null ? map.get("address").toString() : "";
                String image = map.get("image") != null ? map.get("image").toString() : "default-attraction.jpg";
                Double rating = map.get("rating") != null ? Double.parseDouble(map.get("rating").toString()) : 0.0;
                String cityName = map.get("city_name") != null ? map.get("city_name").toString() : "";

                Attraction attraction = new Attraction(id, name, cityId, description, address, image, rating);
                attractions.add(attraction);
            }
            return attractions;

    }
}
