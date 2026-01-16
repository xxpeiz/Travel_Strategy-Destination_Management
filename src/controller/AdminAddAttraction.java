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

@WebServlet(name = "AdminAddAttraction", urlPatterns = "/AdminAddAttraction")
public class AdminAddAttraction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HashMap<String, Object> map = FileUpload.getValues(request);
        String name = (String) map.get("name");
        String cityId = (String) map.get("cityId");
        String description = (String) map.get("description");
        String address = (String) map.get("address");
        String ratingStr = (String) map.get("rating");
        String image = (String) map.get("image");
        Double rating =Double.parseDouble(ratingStr);

        if (name == null || name.isEmpty() || cityId == null || cityId.isEmpty()) {
            session.setAttribute("error", "请填写景点名称和所属城市");
            return;
        }



        Integer cityId1 = Integer.parseInt(cityId);

        AttractionService attractionService = new AttractionService();
        boolean success = attractionService.addAttraction(name,cityId1,description,address,image,rating);

        if (success) {
            session.setAttribute("success", "景点【" + name + "】添加成功");
        } else {
            session.setAttribute("error", "景点添加失败");
        }

        response.sendRedirect("AdminAttractionList?section=attractions");
    }
}
