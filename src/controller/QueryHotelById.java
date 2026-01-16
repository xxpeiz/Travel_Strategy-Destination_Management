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

@WebServlet(name = "QueryHotelById",urlPatterns = "/QueryHotelById")
public class QueryHotelById extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        HotelService hotelService = new HotelService();
        Hotel hotels = hotelService.queryhotelById(id);
        request.setAttribute("hotels",hotels);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        if (user.getRole().equals("管理员")){
            request.getRequestDispatcher("update_goods.jsp").forward(request,response);
        }else {
            request.getRequestDispatcher("hotelDetail.jsp").forward(request,response);

        }
    }
}
