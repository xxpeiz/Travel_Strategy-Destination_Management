package com.service;

import com.model.Hotel;
import com.tools.DbUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class HotelService {

    private DbUtils dbUtils = new DbUtils();

    public List<Hotel> getHotelsAll() {
        String sql = "SELECT * FROM hotel";
        ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
        List<Hotel> hotels = new ArrayList<>();
        for (HashMap<String, Object> map : mapList) {
            Integer id = Integer.parseInt(map.get("id").toString());
            String name=map.get("name").toString();
            Integer cityId = Integer.parseInt(map.get("city_id").toString());
            String address = map.get("address").toString() ;
            String phone =map.get("phone").toString() ;
            BigDecimal price = new BigDecimal(map.get("price").toString());
            Integer starRating = Integer.parseInt(map.get("star_rating").toString());
            String image = map.get("image").toString();

            hotels.add(new Hotel(id, name, cityId, address, phone, price,starRating,image));
        }
        return hotels;
    }

    public List<Hotel> getLimitHotels(int limit) {
            String sql = "SELECT h.*, c.name AS city_name FROM hotel h LEFT JOIN city c ON h.city_id = c.id ORDER BY h.star_rating DESC, h.price ASC LIMIT "  + limit;
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Hotel> hotels = new ArrayList<>();

            if (mapList != null) {
                for (HashMap<String, Object> map : mapList) {
                    Integer id = Integer.parseInt(map.get("id").toString());
                    String name=map.get("name").toString();
                    Integer cityId = Integer.parseInt(map.get("city_id").toString());
                    String address = map.get("address").toString() ;
                    String phone =map.get("phone").toString() ;
                    BigDecimal price = new BigDecimal(map.get("price").toString());
                    String starRatingStr = map.get("star_rating").toString();
                    Integer starRating = "false".equalsIgnoreCase(starRatingStr) ? 0 :
                            "true".equalsIgnoreCase(starRatingStr) ? 1 :
                                    Integer.parseInt(starRatingStr);
                    String image = map.get("image").toString();

                    hotels.add(new Hotel(id, name, cityId, address, phone, price,starRating,image));
                }
            }
            return hotels;

    }

    public Hotel queryhotelById(String id) {
        String sql = "select * from hotel where id = '"+id+"'";
        ArrayList<HashMap<String, Object>> list =dbUtils.queryForList(sql);
        HashMap<String, Object> map = list.get(0);
        Integer id2 = Integer.parseInt(map.get("id").toString());
        String name=map.get("name").toString();
        Integer cityId = Integer.parseInt(map.get("city_id").toString());
        String address = map.get("address").toString() ;
        String phone =map.get("phone").toString() ;
        BigDecimal price = new BigDecimal(map.get("price").toString());
        Integer starRating = Integer.parseInt(map.get("star_rating").toString());
        String image = map.get("image").toString();
        Hotel hotels = new Hotel(id2, name, cityId, address, phone, price,starRating,image);
        return hotels;
    }


    public List<Hotel> getHotelsByCityId(Integer cityId) {
            String sql = "SELECT * FROM hotel WHERE city_id = " + cityId + " ORDER BY star_rating DESC, price ASC";
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Hotel> hotels = new ArrayList<>();

            for (HashMap<String, Object> map : mapList) {
                try {
                    Integer id = Integer.parseInt(map.get("id").toString());
                    String name = map.get("name").toString();
                    Integer hotelCityId = Integer.parseInt(map.get("city_id").toString());
                    String address = map.get("address").toString();
                    String phone = map.get("phone").toString();
                    BigDecimal price = new BigDecimal(map.get("price").toString());
                    Integer starRating = Integer.parseInt(map.get("star_rating").toString());
                    String image = map.get("image").toString();

                    hotels.add(new Hotel(id, name, hotelCityId, address, phone, price, starRating, image));

                } catch (Exception e) {
                    System.err.println("解析酒店数据时出错: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            return hotels;
    }

    public List<Hotel> getHotelsByCityName(String cityName) {
            String sql = "SELECT h.*, c.name as city_name FROM hotel h " +
                    "LEFT JOIN city c ON h.city_id = c.id " +
                    "WHERE c.name LIKE '%" + cityName + "%' " +
                    "ORDER BY h.star_rating DESC, h.price ASC";

            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Hotel> hotels = new ArrayList<>();

            for (HashMap<String, Object> map : mapList) {
                Integer id = Integer.parseInt(map.get("id").toString());
                String name = map.get("name").toString();
                Integer hotelCityId = Integer.parseInt(map.get("city_id").toString());
                String address = map.get("address").toString();
                String phone = map.get("phone").toString();
                BigDecimal price = new BigDecimal(map.get("price").toString());
                Integer starRating = Integer.parseInt(map.get("star_rating").toString());
                String image = map.get("image").toString();
                String hotelCityName = map.get("city_name") != null ? map.get("city_name").toString() : "";

                Hotel hotel = new Hotel(id, name,hotelCityId, address, phone, price,starRating,image);
                hotel.setCityName(hotelCityName);
                hotels.add(hotel);
            }
            return hotels;
    }

    public boolean addHotel(Hotel hotel) {
        String priceValue = "0.00";
        if (hotel.getPrice() != null) {
            priceValue = hotel.getPrice().toString();
        }

        String sql = String.format(
                "INSERT INTO hotel (name, city_id, address, phone, price, star_rating, image) " +
                        "VALUES ('%s', %d, '%s', '%s', %s, %d, '%s')",
                hotel.getName().replace("'", "''"),
                hotel.getCityId(),
                hotel.getAddress() != null ? hotel.getAddress().replace("'", "''") : "",
                hotel.getPhone() != null ? hotel.getPhone().replace("'", "''") : "",
                priceValue,
                hotel.getStarRating() != null ? hotel.getStarRating() : 3,
                hotel.getImage() != null ? hotel.getImage().replace("'", "''") : ""
        );
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean updateHotel(Hotel hotel) {
        String priceValue = "0.00";
        if (hotel.getPrice() != null) {
            priceValue = hotel.getPrice().toString();
        }

        String sql = String.format(
                "UPDATE hotel SET " +
                        "name = '%s', " +
                        "city_id = %d, " +
                        "address = '%s', " +
                        "phone = '%s', " +
                        "price = %s, " +
                        "star_rating = %d, " +
                        "image = '%s' " +
                        "WHERE id = %d",
                hotel.getName().replace("'", "''"),
                hotel.getCityId(),
                hotel.getAddress() != null ? hotel.getAddress().replace("'", "''") : "",
                hotel.getPhone() != null ? hotel.getPhone().replace("'", "''") : "",
                priceValue,
                hotel.getStarRating() != null ? hotel.getStarRating() : 3,
                hotel.getImage() != null ? hotel.getImage().replace("'", "''") : "",
                hotel.getId()
        );
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean deleteHotel(int id) {
        String sql = "DELETE FROM hotel WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }


}
