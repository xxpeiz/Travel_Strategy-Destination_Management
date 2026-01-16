package com.controller;

import com.model.Note;
import com.model.User;
import com.service.NoteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ViewNote", urlPatterns = "/ViewNote")
public class ViewNote extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String id = request.getParameter("id");

            NoteService noteService = new NoteService();
            Note note = noteService.getNotesById(Integer.parseInt(id));

            if (note == null) {
                request.setAttribute("error", "找不到指定的游记");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userInfo");

            request.setAttribute("note", note);
            request.getRequestDispatcher("viewNote.jsp").forward(request, response);
    }
}
