package com.controller;

import com.model.User;
import com.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminUpdateUser", urlPatterns = "/AdminUpdateUser")
public class AdminUpdateUser extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String userIdStr = request.getParameter("id");

            int userId = Integer.parseInt(userIdStr);
            UserService userService = new UserService();
            User user = userService.getUserById(userId);

            if (user == null) {
                response.sendRedirect("AdminUserList?error=用户不存在");
                return;
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("adminUpdateUser.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String userIdStr = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (userIdStr == null || username == null || password == null ||
                username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "请填写完整信息");

                int userId = Integer.parseInt(userIdStr);
                UserService userService = new UserService();
                User user = userService.getUserById(userId);
                request.setAttribute("user", user);
                request.getRequestDispatcher("adminUpdateUser.jsp").forward(request, response);
            return;
        }

            int userId = Integer.parseInt(userIdStr);
            UserService userService = new UserService();


            boolean success = userService.adminUpdateUser(userId,username,password);

            if (success) {
                response.sendRedirect("AdminUserList?msg=用户更新成功");
            } else {
                request.setAttribute("error", "更新失败，请重试");
                request.getRequestDispatcher("adminUpdateUser.jsp").forward(request, response);
            }

    }
}