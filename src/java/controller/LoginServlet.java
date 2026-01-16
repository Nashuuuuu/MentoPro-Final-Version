package controller;
import dao.StudentDAO;
import model.Student;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            StudentDAO dao = new StudentDAO();
            Student s = dao.authenticate(request.getParameter("username"), request.getParameter("password"));
            if(s != null) {
                HttpSession session = request.getSession();
                session.setAttribute("studentID", s.getStudentID());
                session.setAttribute("studentName", s.getStudentName());
                session.setAttribute("studentRole", s.getStudentRole());
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=1");
        }
    }
}