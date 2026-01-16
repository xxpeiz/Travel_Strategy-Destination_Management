package com.controller;

import com.model.Attraction;
import com.model.City;
import com.model.User;
import com.service.AttractionService;
import com.service.CityService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminAttractionList", urlPatterns = "/AdminAttractionList")
public class AdminAttractionList extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        AttractionService attractionService = new AttractionService();
        List<Attraction> attractionList = attractionService.getAllAttractions();

        CityService cityService = new CityService();
        List<City> cityList = cityService.getCitiesAll();

        request.setAttribute("attractionList", attractionList);
        request.setAttribute("cityList", cityList);
        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }
}