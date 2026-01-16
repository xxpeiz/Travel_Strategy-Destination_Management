package com.controller;

import com.model.User;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserList",urlPatterns ="/AdminUserList")
public class AdminUserList extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User admin = (User) request.getSession().getAttribute("userInfo");
        UserService userService = new UserService();
        List<User> userList = userService.getAllUsers();
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }
}
