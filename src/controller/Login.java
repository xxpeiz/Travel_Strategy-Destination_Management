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

@WebServlet(name = "Login",urlPatterns = "/Login")
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserService service = new UserService();
        User user = service.login(username, password);

        if (user == null) {
                response.sendRedirect("login.jsp?code=404");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("userInfo", user);

            if ("管理员".equals(user.getRole())) {
                response.sendRedirect("AdminUserList");
            } else {
                response.sendRedirect("Home");
            }
        }
    }
}