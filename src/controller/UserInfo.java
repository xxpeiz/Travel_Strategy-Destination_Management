package com.controller;

import com.model.City;
import com.model.Note;
import com.model.Attraction;
import com.model.User;
import com.service.CityService;
import com.service.NoteService;
import com.service.AttractionService;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserInfo", urlPatterns = "/UserInfo")
public class UserInfo extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        if (user != null) {
            NoteService noteService = new NoteService();
            AttractionService collectionService = new AttractionService();
            UserService userService = new UserService();
            CityService cityService = new CityService();

            List<Note> myNotes = noteService.getUserNotes(user.getId());
            request.setAttribute("myNotes", myNotes);

            List<City> cities = cityService.getCitiesAll();
            request.setAttribute("cities", cities);

            List<Note> likedNotes = noteService.getUserLikedNotes(user.getId());
            request.setAttribute("likedNotes", likedNotes);

            List<Attraction> collectedAttractions = collectionService.getUserCollections(user.getId());
            request.setAttribute("collectedAttractions", collectedAttractions);

            User fullUserInfo = userService.getUserById(user.getId());
            session.setAttribute("userInfo", fullUserInfo);
        }

        request.getRequestDispatcher("userInfo.jsp").forward(request, response);
    }
}