package com.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CheckLogin", urlPatterns = "/CheckLogin")
public class CheckLogin extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Object userInfo = session.getAttribute("userInfo");

        PrintWriter out = response.getWriter();
        if (userInfo != null) {
            out.print("{\"loggedIn\": true}");
        } else {
            out.print("{\"loggedIn\": false}");
        }
        out.flush();
    }
}