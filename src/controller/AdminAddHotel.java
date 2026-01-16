package com.controller;

import com.model.Hotel;
import com.model.User;
import com.service.HotelService;
import com.tools.DbUtils;
import com.tools.FileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "AdminAddHotel", urlPatterns = "/AdminAddHotel")
public class AdminAddHotel extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HashMap<String, Object> map = FileUpload.getValues(request);

        String name = (String) map.get("name");
        String cityName = (String) map.get("cityName");
        String address = (String) map.get("address");
        String phone = (String) map.get("phone");
        String priceStr = (String) map.get("price");
        String starRatingStr = (String) map.get("starRating");
        String image = (String) map.get("image");

        if (name == null || name.isEmpty() || cityName == null || cityName.isEmpty()) {
            session.setAttribute("error", "请填写酒店名称和所属城市");
            response.sendRedirect("AdminHotelList?section=hotels");
            return;
        }

            DbUtils db = new DbUtils();
            String citySql = "SELECT id FROM city WHERE name = '" + cityName + "'";
            ArrayList<HashMap<String, Object>> cityResult = db.queryForList(citySql);

            if (cityResult == null || cityResult.isEmpty()) {
                session.setAttribute("error", "城市【" + cityName + "】不存在");
                response.sendRedirect("AdminHotelList?section=hotels");
                return;
            }

            Integer cityId = (Integer) cityResult.get(0).get("id");

            BigDecimal price = BigDecimal.ZERO;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                    price = new BigDecimal(priceStr.trim());
            }

            Integer starRating = 3;
            if (starRatingStr != null && !starRatingStr.trim().isEmpty()) {
                    starRating = Integer.parseInt(starRatingStr.trim());
                    if (starRating < 1) starRating = 1;
                    if (starRating > 5) starRating = 5;
            }

            Hotel hotel = new Hotel();
            hotel.setName(name);
            hotel.setCityId(cityId);
            hotel.setAddress(address != null ? address : "");
            hotel.setPhone(phone != null ? phone : "");
            hotel.setPrice(price);
            hotel.setStarRating(starRating);
            hotel.setImage(image != null ? image : "");

            HotelService hotelService = new HotelService();
            boolean success = hotelService.addHotel(hotel);

            if (success) {
                session.setAttribute("success", "酒店【" + name + "】添加成功");
            } else {
                session.setAttribute("error", "酒店添加失败");
            }

            response.sendRedirect("AdminHotelList?section=hotels");
    }
}