package com.controller;

import com.tools.DbUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "QueryLikeHome", urlPatterns = "/QueryLikeHome")
public class QueryLikeHome extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String like = request.getParameter("like");
        DbUtils dbUtils = new DbUtils();

        String sql = "select * from city where name like '%" + like + "%'";
        ArrayList<HashMap<String, Object>> list = dbUtils.queryForList(sql);

        if (list == null || list.isEmpty()) {
            response.sendRedirect("Home");
            return;
        }

        HashMap<String, Object> firstCity = list.get(0);
        String cityId = firstCity.get("id").toString();

        response.sendRedirect("QueryStrategyAll?id=" + cityId);

    }
}
