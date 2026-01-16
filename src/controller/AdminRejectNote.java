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

@WebServlet(name = "AdminRejectNote", urlPatterns = "/AdminRejectNote")
public class AdminRejectNote extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String noteIdStr = request.getParameter("id");

        if (noteIdStr == null || noteIdStr.isEmpty()) {
            session.setAttribute("error", "游记ID不能为空");
            response.sendRedirect("AdminNoteReview?section=notes");
            return;
        }

            int noteId = Integer.parseInt(noteIdStr);
            NoteService noteService = new NoteService();
            boolean success = noteService.rejectNote(noteId);

            if (success) {
                session.setAttribute("success", "游记拒绝成功");
            } else {
                session.setAttribute("error", "游记拒绝失败");
            }

            response.sendRedirect("AdminNoteReview?section=notes");

    }
}
