package com.controller;

import com.service.NoteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminBatchRejectNote", urlPatterns = "/AdminBatchRejectNote")
public class AdminBatchRejectNote extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String noteIdsStr = request.getParameter("noteIds");
        String section = request.getParameter("section");

        if (noteIdsStr == null || noteIdsStr.isEmpty()) {
            session.setAttribute("errorMsg", "请选择要操作的游记");
            response.sendRedirect("AdminNoteReview?section=notes");
            return;
        }

            String[] noteIds = noteIdsStr.split(",");
            NoteService noteService = new NoteService();
            boolean success = noteService.batchRejectNotes(noteIds);

            if (success) {
                session.setAttribute("successMsg", "成功拒绝 " + noteIds.length + " 条游记");
            } else {
                session.setAttribute("errorMsg", "部分或全部游记拒绝失败");
            }


        response.sendRedirect("AdminNoteReview?section=notes");
    }
}
