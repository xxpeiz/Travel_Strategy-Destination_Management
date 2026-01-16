package com.controller;

import com.model.City;
import com.model.Hotel;
import com.model.Note;
import com.model.User;
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

@WebServlet(name = "Home",urlPatterns = "/Home")
public class Home extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        CityService cityService = new CityService();
        HotelService hotelService = new HotelService();
        NoteService noteService= new NoteService();

        List<City> hotCities = cityService.getHotCitiesAll();
        List<Hotel> hotels = hotelService.getLimitHotels(5);
        List<Note> notes = noteService.getLimitNotes(3);

        request.setAttribute("hotCities", hotCities);
        request.setAttribute("hotels", hotels);
        request.setAttribute("notes", notes);

        if (user != null && "管理员".equals(user.getRole())) {
            request.getRequestDispatcher("manager.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
