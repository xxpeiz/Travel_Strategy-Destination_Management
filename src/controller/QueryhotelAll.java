package com.controller;

import com.model.Hotel;
import com.model.User;
import com.service.HotelService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QueryhotelAll",urlPatterns ="/QueryhotelAll")
public class QueryhotelAll extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HotelService hotelService = new HotelService();
        List<Hotel> hotels = hotelService.getHotelsAll();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        request.setAttribute("hotels", hotels);
        // 检查用户是否登录且为管理员
        if (user != null && "管理员".equals(user.getRole())) {
            request.getRequestDispatcher("manager.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("hotel.jsp").forward(request, response);
        }
    }
}
