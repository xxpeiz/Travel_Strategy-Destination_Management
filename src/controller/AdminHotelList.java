package com.controller;

import com.model.City;
import com.model.Hotel;
import com.model.User;
import com.service.CityService;
import com.service.HotelService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminHotelList", urlPatterns = "/AdminHotelList")
public class AdminHotelList extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        HotelService hotelService = new HotelService();
        List<Hotel> hotelList = hotelService.getHotelsAll();

        CityService cityService = new CityService();
        List<City> cityList = cityService.getCitiesAll();

        request.setAttribute("hotelList", hotelList);
        request.setAttribute("cityList", cityList);
        request.setAttribute("showSection", "hotels");
        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }
}