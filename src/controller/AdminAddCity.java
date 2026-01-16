package com.controller;

import com.model.City;
import com.model.User;
import com.service.CityService;
import com.tools.FileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name = "AdminAddCity", urlPatterns = "/AdminAddCity")
public class AdminAddCity extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HashMap<String, Object> map = FileUpload.getValues(request);

        String name = (String) map.get("name");
        String province = (String) map.get("province");
        String description = (String) map.get("description");
        String bestSeason = (String) map.get("bestSeason");
        String climate = (String) map.get("climate");
        String travelTips = (String) map.get("travelTips");
        String coverImage = (String) map.get("coverImage");
        String isRecommendedStr = (String) map.get("isRecommended");

        if (name == null || name.isEmpty() || province == null || province.isEmpty()) {
            session.setAttribute("error", "请填写城市名称和所属省份");
            response.sendRedirect("AdminCityList?section=cities");
            return;
        }

        City city = new City();
        city.setName(name);
        city.setProvince(province);
        city.setDescription(description != null ? description : "");
        city.setBestSeason(bestSeason != null ? bestSeason : "");
        city.setClimate(climate != null ? climate : "");
        city.setTravelTips(travelTips != null ? travelTips : "");
        city.setCoverImage(coverImage != null ? coverImage : "");

        int isRecommended = 0;
        if (isRecommendedStr != null && !isRecommendedStr.isEmpty()) {
            isRecommended = Integer.parseInt(isRecommendedStr);
        }
        city.setIsRecommended(isRecommended);

        CityService cityService = new CityService();
        boolean success = cityService.addCity(city);

        if (success) {
            session.setAttribute("success", "城市【" + name + "】添加成功");
        } else {
            session.setAttribute("error", "城市添加失败，可能城市名已存在");
        }

        response.sendRedirect("AdminCityList?section=cities");
    }
}