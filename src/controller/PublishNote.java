package com.controller;

import com.model.User;
import com.service.NoteService;
import com.tools.FileUpload;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name = "PublishNote", urlPatterns = "/PublishNote")
public class PublishNote extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HashMap<String, Object> map = FileUpload.getValues(request);
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userInfo");

            String title = (String) map.get("title");
            String cityname = (String) map.get("cityname");
            String summary = (String) map.get("summary");
            String content = (String) map.get("content");
            String coverImage = (String) map.get("pic");

            Integer userId = user.getId();
            String username = user.getUsername();

            NoteService noteService = new NoteService();
            boolean success = noteService.publishNote(title, content, summary, coverImage, userId, username, cityname);

            if (success) {
                session.setAttribute("success", "游记发布成功！等待管理员审核通过后即可显示。");
            } else {
                session.setAttribute("error", "游记发布失败，请重试");
            }

            response.sendRedirect("UserInfo");


    }
}