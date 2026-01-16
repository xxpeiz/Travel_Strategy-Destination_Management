package com.controller;

import com.model.User;
import com.service.AttractionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CollectAttraction", urlPatterns = "/CollectAttraction")
public class CollectAttraction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String attractionIdStr = request.getParameter("attractionId");
            Integer attractionId = Integer.parseInt(attractionIdStr);

            AttractionService collectionService = new AttractionService();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userInfo");

            Integer userId = user.getId();

            boolean success = collectionService.addCollection(userId, attractionId);

            response.sendRedirect("QueryAttractionsByCity?id=" + attractionId);

    }
}