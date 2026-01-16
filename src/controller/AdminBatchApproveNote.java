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

@WebServlet(name = "AdminBatchApproveNote", urlPatterns = "/AdminBatchApproveNote")
public class AdminBatchApproveNote extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("userInfo");

        String noteIdsStr = request.getParameter("noteIds");

        if (noteIdsStr == null || noteIdsStr.isEmpty()) {
            session.setAttribute("errorMsg", "请选择要操作的游记");
            response.sendRedirect("AdminNoteReview?section=notes");
            return;
        }

            String[] noteIds = noteIdsStr.split(",");
            NoteService noteService = new NoteService();
            boolean success = noteService.batchApproveNotes(noteIds);

            if (success) {
                session.setAttribute("successMsg", "成功通过 " + noteIds.length + " 条游记");
            } else {
                session.setAttribute("errorMsg", "部分或全部游记审核失败");
            }


        response.sendRedirect("AdminNoteReview?section=notes");
    }

}