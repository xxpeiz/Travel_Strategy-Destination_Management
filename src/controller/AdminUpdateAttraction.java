package com.controller;

import com.model.Attraction;
import com.model.User;
import com.service.AttractionService;
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

@WebServlet(name = "AdminUpdateAttraction", urlPatterns = "/AdminUpdateAttraction")
public class AdminUpdateAttraction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String attractionIdStr = request.getParameter("id");
        if (attractionIdStr == null || attractionIdStr.isEmpty()) {
            response.sendRedirect("AdminAttractionList?error=景点ID不能为空");
            return;
        }

        int attractionId = Integer.parseInt(attractionIdStr);
        AttractionService attractionService = new AttractionService();
        Attraction attraction = attractionService.queryAttractionById(attractionId);

        if (attraction == null) {
            session.setAttribute("error", "景点不存在");
            response.sendRedirect("AdminAttractionList?section=attractions");
            return;
        }

        DbUtils db = new DbUtils();
        String citySql = "SELECT id, name FROM city";
        ArrayList<HashMap<String, Object>> cityList = db.queryForList(citySql);

        request.setAttribute("attraction", attraction);
        request.setAttribute("cityList", cityList);
        request.getRequestDispatcher("adminUpdateAttraction.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HashMap<String, Object> map = FileUpload.getValues(request);

        String attractionIdStr = (String) map.get("id");
        String name = (String) map.get("name");
        String cityName = (String) map.get("cityName");
        String description = (String) map.get("description");
        String address = (String) map.get("address");
        String ratingStr = (String) map.get("rating");
        String newImage = (String) map.get("image");

        if (attractionIdStr == null || name == null || name.isEmpty() || cityName == null || cityName.isEmpty()) {
            session.setAttribute("error", "请填写必填字段");
            response.sendRedirect("AdminAttractionList?section=attractions");
            return;
        }

        int attractionId = Integer.parseInt(attractionIdStr);

        DbUtils db = new DbUtils();
        String citySql = "SELECT id FROM city WHERE name = '" + cityName + "'";
        ArrayList<HashMap<String, Object>> cityResult = db.queryForList(citySql);

        if (cityResult == null || cityResult.isEmpty()) {
            session.setAttribute("error", "城市【" + cityName + "】不存在");
            response.sendRedirect("AdminAttractionList?section=attractions");
            return;
        }

        Integer cityId = (Integer) cityResult.get(0).get("id");

        String getImageSql = "SELECT image FROM attraction WHERE id = " + attractionId;
        ArrayList<HashMap<String, Object>> imageResult = db.queryForList(getImageSql);
        String oldImage =(String) imageResult.get(0).get("image");;

        String imageToSave;
        if (newImage == null || newImage.isEmpty()) {
            imageToSave = oldImage;
        }else {
            imageToSave = newImage;
        }

        Double rating = 0.0;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            rating = Double.parseDouble(ratingStr);
        }

        AttractionService attractionService = new AttractionService();
        boolean success = attractionService.updateAttraction(
                attractionId,
                name,
                cityId,
                description != null ? description : "",
                address != null ? address : "",
                imageToSave,
                rating
        );

        if (success) {
            session.setAttribute("success", "景点【" + name + "】更新成功");
        } else {
            session.setAttribute("error", "景点更新失败");
        }

        response.sendRedirect("AdminAttractionList?section=attractions");

    }
}