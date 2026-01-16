package com.controller;

import com.model.City;
import com.model.Hotel;
import com.model.User;
import com.service.CityService;
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
import java.util.List;

@WebServlet(name = "AdminUpdateHotel", urlPatterns = "/AdminUpdateHotel")
public class AdminUpdateHotel extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String hotelIdStr = request.getParameter("id");
        if (hotelIdStr == null || hotelIdStr.isEmpty()) {
            response.sendRedirect("AdminHotelList?error=酒店ID不能为空");
            return;
        }

            HotelService hotelService = new HotelService();
            Hotel hotel = hotelService.queryhotelById(hotelIdStr);

            if (hotel == null) {
                session.setAttribute("error", "酒店不存在");
                response.sendRedirect("AdminHotelList");
                return;
            }

            CityService cityService = new CityService();
            List<City> cityList = cityService.getCitiesAll();

            request.setAttribute("hotel", hotel);
            request.setAttribute("cityList", cityList);
            request.getRequestDispatcher("adminUpdateHotel.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HashMap<String, Object> map = FileUpload.getValues(request);

        String hotelIdStr = (String) map.get("id");
        String name = (String) map.get("name");
        String cityName = (String) map.get("cityName");
        String address = (String) map.get("address");
        String phone = (String) map.get("phone");
        String priceStr = (String) map.get("price");
        String starRatingStr = (String) map.get("starRating");
        String image = (String) map.get("image");

        if (hotelIdStr == null || name == null || name.isEmpty() || cityName == null || cityName.isEmpty()) {
            session.setAttribute("error", "请填写必填字段");
            response.sendRedirect("AdminHotelList");
            return;
        }

            int hotelId = Integer.parseInt(hotelIdStr);

            DbUtils db = new DbUtils();
            String citySql = "SELECT id FROM city WHERE name = '" + cityName + "'";
            ArrayList<HashMap<String, Object>> cityResult = db.queryForList(citySql);

            if (cityResult == null || cityResult.isEmpty()) {
                session.setAttribute("error", "城市【" + cityName + "】不存在");
                response.sendRedirect("AdminHotelList");
                return;
            }

            Integer cityId = (Integer) cityResult.get(0).get("id");

            String getImageSql = "SELECT image FROM hotel WHERE id = " + hotelId;
            ArrayList<HashMap<String, Object>> imageResult = db.queryForList(getImageSql);
            String oldImage = "";
            if (imageResult != null && !imageResult.isEmpty()) {
                Object imageObj = imageResult.get(0).get("image");
                if (imageObj != null) {
                    oldImage = imageObj.toString();
                }
            }

            String imageToSave;
            if (image == null || image.isEmpty()) {
                imageToSave = oldImage;
            } else {
                imageToSave = image;
            }

            BigDecimal price = BigDecimal.ZERO;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                    price = new BigDecimal(priceStr.trim());
            }

            Integer starRating = 3;
            if (starRatingStr != null && !starRatingStr.isEmpty()) {
                    starRating = Integer.parseInt(starRatingStr);
                    if (starRating < 1) starRating = 1;
                    if (starRating > 5) starRating = 5;
            }

            Hotel hotel = new Hotel();
            hotel.setId(hotelId);
            hotel.setName(name);
            hotel.setCityId(cityId);
            hotel.setAddress(address != null ? address : "");
            hotel.setPhone(phone != null ? phone : "");
            hotel.setPrice(price);
            hotel.setStarRating(starRating);
            hotel.setImage(imageToSave);

            HotelService hotelService = new HotelService();
            boolean success = hotelService.updateHotel(hotel);

            if (success) {
                session.setAttribute("success", "酒店【" + name + "】更新成功");
            } else {
                session.setAttribute("error", "酒店更新失败");
            }

            response.sendRedirect("AdminHotelList?section=hotels");
    }
}