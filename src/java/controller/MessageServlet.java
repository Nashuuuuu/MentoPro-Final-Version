package controller;

import dao.MessageDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer senderId = (Integer) session.getAttribute("studentID");
        
        // Security check
        if (senderId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String receiverIdStr = request.getParameter("receiverId");
        String content = request.getParameter("message");

        if (receiverIdStr != null && content != null && !content.trim().isEmpty()) {
            int receiverId = Integer.parseInt(receiverIdStr);
            MessageDAO dao = new MessageDAO();
            dao.sendMessage(senderId, receiverId, content);
            
            // Redirect back to the chat view with the same partner
            response.sendRedirect("dashboard.jsp?view=messages&partnerId=" + receiverId);
        } else {
            response.sendRedirect("dashboard.jsp?view=messages");
        }
    }
}