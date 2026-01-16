package com.controller;

import com.model.Attraction;
import com.model.User;
import com.service.AttractionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(name = "QueryAttractionsByCity",urlPatterns ="/QueryAttractionsByCity")
public class QueryAttractionsByCity extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Integer attractionId = Integer.parseInt(id);
        AttractionService attractionService = new AttractionService();
        Attraction attraction =attractionService.queryAttractionById(attractionId);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        // 设置热门城市数据
        request.setAttribute("attraction", attraction);
        request.setAttribute("cityId", attraction.getCityId());

        boolean collected = false;
        if (user != null) {
            AttractionService collectionService = new AttractionService();
            collected = collectionService.checkUserCollected(user.getId(), attractionId);
        }
        request.setAttribute("collected", collected);

        request.getRequestDispatcher("attractionDetail.jsp").forward(request, response);

    }
}
