package com.controller;

import com.model.User;
import com.service.CityService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminRecommendCity", urlPatterns = "/AdminRecommendCity")
public class AdminRecommendCity extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String cityIdStr = request.getParameter("id");
        if (cityIdStr == null || cityIdStr.isEmpty()) {
            session.setAttribute("error", "城市ID不能为空");
            response.sendRedirect("AdminCityList?section=cities");
            return;
        }

            int cityId = Integer.parseInt(cityIdStr);
            CityService cityService = new CityService();
            boolean success = cityService.recommendCity(cityId);

            if (success) {
                session.setAttribute("success", "城市推荐成功");
            } else {
                session.setAttribute("error", "城市推荐失败");
            }

            response.sendRedirect("AdminCityList?section=cities");

    }
}
