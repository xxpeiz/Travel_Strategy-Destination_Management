package com.controller;

import com.model.Hotel;
import com.service.HotelService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchHotels", urlPatterns = "/SearchHotels")
public class SearchHotels extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String cityName = request.getParameter("cityName");

            HotelService hotelService = new HotelService();
            List<Hotel> hotels;

            hotels = hotelService.getHotelsByCityName(cityName);
            request.setAttribute("searchedCityName", cityName);


            request.setAttribute("hotels", hotels);
            request.getRequestDispatcher("hotel.jsp").forward(request, response);


    }
}