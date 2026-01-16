package com.controller;

import com.model.*;
import com.service.AttractionService;
import com.service.CityService;
import com.service.HotelService;
import com.service.NoteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QueryStrategyAll",urlPatterns ="/QueryStrategyAll")
public class QueryStrategyAll extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cityIdStr = request.getParameter("id");
        int cityId = Integer.parseInt(cityIdStr);

        CityService cityService = new CityService();
        City city = cityService.getCityById(cityId);

        AttractionService attractionService = new AttractionService();
        List<Attraction> attractions = attractionService.queryAttractionsByCityId(cityId);
        //System.out.println("获取到景点数量: " + (attractions != null ? attractions.size() : 0));

        HotelService hotelService = new HotelService();
        List<Hotel> hotels = hotelService.getHotelsByCityId(cityId);
        //System.out.println("获取到酒店数量: " + (hotels != null ? hotels.size() : 0));

        NoteService noteService = new NoteService();
        List<Note> notes = noteService.getNotesByCityId(cityId);
        //System.out.println("获取到游记数量: " + (notes != null ? notes.size() : 0));

        // 设置请求属性
        request.setAttribute("city", city);
        request.setAttribute("attractions", attractions);
        request.setAttribute("hotels", hotels);
        request.setAttribute("notes", notes);

        request.getRequestDispatcher("strategy.jsp").forward(request, response);
    }
}
