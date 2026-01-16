package com.controller;

import com.model.User;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteUser",urlPatterns = "/DeleteUser")
public class DeleteUser extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User admin = (User) request.getSession().getAttribute("userInfo");

        int userId = Integer.parseInt(request.getParameter("id"));

        UserService userService = new UserService();
        boolean success = userService.deleteUser(userId);

        if (success) {
            request.getSession().setAttribute("message", "用户删除成功！");
        } else {
            request.getSession().setAttribute("message", "用户删除失败！");
        }

        response.sendRedirect("AdminUserList");

    }
}
