package com.controller;


import com.tools.DbUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SignUp",urlPatterns = "/SignUp")
public class SignUp extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            resp.sendRedirect("signup.jsp?error=1");
            return;
        }

        DbUtils db = new DbUtils();

        String sql = "INSERT INTO user(username,password) VALUES('"+username+"','"+password+"')";
        int rows = db.update(sql);
        if (rows > 0) {
            resp.sendRedirect("signup.jsp?error=success");
        } else {
            resp.sendRedirect("signup.jsp?error=2");
        }
    }
}
