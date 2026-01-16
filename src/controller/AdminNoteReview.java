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
import java.util.List;

@WebServlet(name = "AdminNoteReview", urlPatterns = "/AdminNoteReview")
public class AdminNoteReview extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String status = request.getParameter("status");

        NoteService noteService = new NoteService();
        List<Note> noteList = noteService.getAllNotes(status);

        request.setAttribute("noteList", noteList);
        request.setAttribute("showSection", "notes");
        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }
}