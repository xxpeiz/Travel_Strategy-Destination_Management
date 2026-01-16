package com.controller;

import com.model.User;
import com.service.NoteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UnlikeNote", urlPatterns = "/UnlikeNote")
public class UnlikeNote extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String noteIdStr = request.getParameter("noteId");
            Integer noteId = Integer.parseInt(noteIdStr);

            NoteService noteService = new NoteService();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userInfo");
            Integer userId = user.getId();

            boolean success = noteService.removeLikeRecord(userId, noteId);

            if (success) {
                response.sendRedirect("QueryNoteById?id=" + noteId);
            } else {
                response.sendRedirect("QueryNoteById?id=" + noteId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
