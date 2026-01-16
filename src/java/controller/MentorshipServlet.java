package controller;

import dao.StudentDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/MentorshipServlet")
public class MentorshipServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Use session ID if available, otherwise try to get from parameter (to match your URL)
        Integer currentId = (Integer) session.getAttribute("studentID");
        String menteeIdParam = request.getParameter("menteeId");
        
        if (currentId == null && menteeIdParam != null) {
            currentId = Integer.parseInt(menteeIdParam);
        }

        StudentDAO dao = new StudentDAO();

        try {
            // Updated to check for "request" to match your URL: action=request
            if ("apply".equals(action) || "request".equals(action)) {
                int mentorId = Integer.parseInt(request.getParameter("mentorId"));
                
                if (currentId != null) {
                    dao.applyForMentorship(mentorId, currentId);
                    response.sendRedirect("dashboard.jsp?view=mentors&status=applied");
                } else {
                    response.sendRedirect("login.jsp?msg=session_expired");
                }
            } 
            else if ("approve".equals(action)) {
                int menteeId = Integer.parseInt(request.getParameter("menteeId"));
                dao.updateRequestStatus(currentId, menteeId, "APPROVED");
                response.sendRedirect("dashboard.jsp?view=requests&status=success");
            } 
            else if ("reject".equals(action)) {
                int menteeId = Integer.parseInt(request.getParameter("menteeId"));
                dao.updateRequestStatus(currentId, menteeId, "REJECTED");
                response.sendRedirect("dashboard.jsp?view=requests&status=removed");
            }
            else {
                // Catch-all to prevent blank page if action is unknown
                response.sendRedirect("dashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to dashboard with error instead of showing blank/white error page
            response.sendRedirect("dashboard.jsp?msg=error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}