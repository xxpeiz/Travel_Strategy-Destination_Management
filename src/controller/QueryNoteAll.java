package com.controller;

import com.model.Hotel;
import com.model.Note;
import com.model.User;
import com.service.HotelService;
import com.service.NoteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "QueryNoteAll",urlPatterns = "/QueryNoteAll")
public class QueryNoteAll extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NoteService noteService = new NoteService();
        List<Note> notes = noteService.getNotesAll();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        // 设置热门城市数据
        request.setAttribute("notes", notes);

        // 检查用户是否登录且为管理员
        if (user != null && "管理员".equals(user.getRole())) {
            request.getRequestDispatcher("manager.jsp").forward(request, response);
        } else {
            // 普通用户或未登录用户都跳转到首页
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
