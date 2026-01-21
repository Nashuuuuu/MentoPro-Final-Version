package controller;

import dao.StudentDAO;
import model.Student;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Student s = new Student();
            
            // Basic Account Info
            s.setStudentID(Integer.parseInt(request.getParameter("studentID")));
            s.setStudentName(request.getParameter("name"));
            s.setStudentUsername(request.getParameter("username"));
            s.setStudentPassword(request.getParameter("password"));
            s.setStudentRole(request.getParameter("role"));
            
            // New Fields requested for the latest update
            s.setStudentEmail(request.getParameter("email"));
            
            // Handle CGPA (Converting String to Double safely)
            String cgpaStr = request.getParameter("cgpa");
            if (cgpaStr != null && !cgpaStr.isEmpty()) {
                s.setStudentCGPA(Double.parseDouble(cgpaStr));
            } else {
                s.setStudentCGPA(0.0);
            }
            
            // Course and Achievements
            s.setCourseCode(request.getParameter("courseCode"));
            s.setStudentAchievements(request.getParameter("achievements"));
            
            // Handle Profile Picture
            String pic = request.getParameter("profilePic");
            if (pic == null || pic.isEmpty()) {
                pic = "gambar/default.png"; // Default fallback
            }
            s.setProfilePic(pic);
            
            // Initialize empty strings for fields that shouldn't be null
            s.setStudentBio(""); 
            s.setStudentPhone("");

            StudentDAO dao = new StudentDAO();
            if (dao.register(s)) {
                response.sendRedirect("login.jsp?reg=1");
            } else {
                response.sendRedirect("register.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=1");
        }
    }
}