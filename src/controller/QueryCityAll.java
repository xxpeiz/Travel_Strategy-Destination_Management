package com.controller;

import com.model.City;
import com.model.User;
import com.service.CityService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QueryCityAll",urlPatterns ="/QueryCityAll")
public class QueryCityAll extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        CityService cityService = new CityService();
        List<City> cities = cityService.getCitiesAll();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        // 设置热门城市数据
        request.setAttribute("cities", cities);


        request.getRequestDispatcher("cityAll.jsp").forward(request, response);

    }
}
