package com.controller;

import com.model.User;
import com.service.HotelService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminDeleteHotel", urlPatterns = "/AdminDeleteHotel")
public class AdminDeleteHotel extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");


        String hotelIdStr = request.getParameter("id");
        if (hotelIdStr == null || hotelIdStr.isEmpty()) {
            session.setAttribute("error", "酒店ID不能为空");
            response.sendRedirect("AdminHotelList?section=hotels");
            return;
        }

            int hotelId = Integer.parseInt(hotelIdStr);
            HotelService hotelService = new HotelService();
            boolean success = hotelService.deleteHotel(hotelId);

            if (success) {
                session.setAttribute("success", "酒店删除成功");
            } else {
                session.setAttribute("error", "酒店删除失败");
            }

            response.sendRedirect("AdminHotelList?section=hotels");

    }
}