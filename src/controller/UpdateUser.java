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

@WebServlet(name = "UpdateUser", urlPatterns = "/UpdateUser")
public class UpdateUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("userInfo");

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            if (username == null || username.trim().isEmpty()) {
                request.setAttribute("error", "用户名不能为空");
                request.getRequestDispatcher("userInfo.jsp").forward(request, response);
                return;
            }

            if (password != null && !password.trim().isEmpty()) {
                if (!password.equals(confirmPassword)) {
                    request.setAttribute("error", "两次输入的密码不一致");
                    request.getRequestDispatcher("userInfo.jsp").forward(request, response);
                    return;
                }
                if (password.length() < 6) {
                    request.setAttribute("error", "密码长度不能少于6位");
                    request.getRequestDispatcher("userInfo.jsp").forward(request, response);
                    return;
                }
            }

            UserService userService = new UserService();

            boolean success = userService.updateUser(currentUser.getId(), username, password);

            if (success) {
                User updatedUser = userService.getUserById(currentUser.getId());
                session.setAttribute("userInfo", updatedUser);
                request.setAttribute("success", "信息更新成功");
            } else {
                request.setAttribute("error", "更新失败，请重试");
            }



                request.getRequestDispatcher("userInfo.jsp").forward(request, response);

    }
}
