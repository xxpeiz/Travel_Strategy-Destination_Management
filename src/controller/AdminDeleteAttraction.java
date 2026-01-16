package com.controller;

import com.model.User;
import com.service.AttractionService;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminDeleteAttraction",urlPatterns = "/AdminDeleteAttraction")
public class AdminDeleteAttraction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User admin = (User) request.getSession().getAttribute("userInfo");
        int id = Integer.parseInt(request.getParameter("id"));

        AttractionService attractionService = new AttractionService();
        boolean success = attractionService.deleteAttraction(id);

        if (success) {
            request.getSession().setAttribute("message", "用户删除成功！");
        } else {
            request.getSession().setAttribute("message", "用户删除失败！");
        }

        response.sendRedirect("AdminAttractionList?section=attractions");

    }
}
