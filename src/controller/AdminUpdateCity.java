package com.controller;

import com.model.City;
import com.model.User;
import com.service.CityService;
import com.tools.DbUtils;
import com.tools.FileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "AdminUpdateCity", urlPatterns = "/AdminUpdateCity")
public class AdminUpdateCity extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String cityIdStr = request.getParameter("id");
        if (cityIdStr == null || cityIdStr.isEmpty()) {
            response.sendRedirect("AdminCityList?error=城市ID不能为空");
            return;
        }

            int cityId = Integer.parseInt(cityIdStr);
            CityService cityService = new CityService();
            City city = cityService.getCityById(cityId);

            if (city == null) {
                session.setAttribute("error", "城市不存在");
                response.sendRedirect("AdminCityList?section=cities");
                return;
            }

            request.setAttribute("city", city);
            request.getRequestDispatcher("adminUpdateCity.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HashMap<String, Object> map = FileUpload.getValues(request);

        String cityIdStr = (String) map.get("id");
        String name = (String) map.get("name");
        String province = (String) map.get("province");
        String description = (String) map.get("description");
        String bestSeason = (String) map.get("bestSeason");
        String climate = (String) map.get("climate");
        String travelTips = (String) map.get("travelTips");
        String coverImage = (String) map.get("coverImage");
        String isRecommendedStr = (String) map.get("isRecommended");

        if (cityIdStr == null || name == null || name.isEmpty() || province == null || province.isEmpty()) {
            session.setAttribute("error", "请填写必填字段");
            response.sendRedirect("AdminCityList?section=cities");
            return;
        }

            int cityId = Integer.parseInt(cityIdStr);

            DbUtils db = new DbUtils();
            String getImageSql = "SELECT cover_image FROM city WHERE id = " + cityId;
            ArrayList<HashMap<String, Object>> imageResult = db.queryForList(getImageSql);
            String oldImage = "";
            if (imageResult != null && !imageResult.isEmpty()) {
                Object imageObj = imageResult.get(0).get("cover_image");
                if (imageObj != null) {
                    oldImage = imageObj.toString();
                }
            }

            String imageToSave;
            if (coverImage == null || coverImage.isEmpty()) {
                imageToSave = oldImage;
            } else {
                imageToSave = coverImage;
            }

            int isRecommended = 0;
            if (isRecommendedStr != null && !isRecommendedStr.isEmpty()) {
                isRecommended = Integer.parseInt(isRecommendedStr);
            }

            City city = new City();
            city.setId(cityId);
            city.setName(name);
            city.setProvince(province);
            city.setDescription(description != null ? description : "");
            city.setBestSeason(bestSeason != null ? bestSeason : "");
            city.setClimate(climate != null ? climate : "");
            city.setTravelTips(travelTips != null ? travelTips : "");
            city.setCoverImage(imageToSave);
            city.setIsRecommended(isRecommended);

            CityService cityService = new CityService();
            boolean success = cityService.updateCity(city);

            if (success) {
                session.setAttribute("success", "城市【" + name + "】更新成功");
            } else {
                session.setAttribute("error", "城市更新失败");
            }

            response.sendRedirect("AdminCityList?section=cities");
    }
}