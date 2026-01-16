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

@WebServlet(name = "QueryNoteById",urlPatterns = "/QueryNoteById")
public class QueryNoteById extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Integer id2=Integer.parseInt(id);
        NoteService noteService = new NoteService();
        Note note = noteService.getNotesById(id2);
        request.setAttribute("note",note);

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        boolean userLiked = false;
        if (user != null) {
            userLiked = noteService.checkUserLiked(user.getId(), id2);
        }
        request.setAttribute("userLiked", userLiked);

        request.getRequestDispatcher("noteDetail.jsp").forward(request,response);

    }
}
