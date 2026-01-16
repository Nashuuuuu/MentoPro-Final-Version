package controller;

import dao.StudentDAO;
import model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.Base64;

@WebServlet("/ProfileServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 2) // 2MB Limit for profile pictures
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            StudentDAO dao = new StudentDAO();
            int id = Integer.parseInt(request.getParameter("studentID"));
            
            // 1. Fetch the existing student data from the database
            Student s = dao.getStudentById(id);
            
            if (s != null) {
                // 2. Update text fields from the form
                s.setStudentName(request.getParameter("name"));
                s.setStudentEmail(request.getParameter("email"));
                s.setStudentPhone(request.getParameter("phone"));
                s.setStudentBio(request.getParameter("bio"));
                s.setStudentAchievements(request.getParameter("achievements"));
                
                // 3. Update Course Code (New field added)
                String courseCode = request.getParameter("courseCode");
                if (courseCode != null && !courseCode.isEmpty()) {
                    s.setCourseCode(courseCode);
                }

                // 4. Update CGPA
                String cgpaStr = request.getParameter("cgpa");
                if (cgpaStr != null && !cgpaStr.isEmpty()) {
                    s.setStudentCGPA(Double.parseDouble(cgpaStr));
                }
                
                // 5. Handle Image Upload if a new file was provided
                Part filePart = request.getPart("profilePicFile");
                if (filePart != null && filePart.getSize() > 0) {
                    InputStream is = filePart.getInputStream();
                    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                    byte[] data = new byte[4096];
                    int nRead;
                    while ((nRead = is.read(data, 0, data.length)) != -1) {
                        buffer.write(data, 0, nRead);
                    }
                    byte[] imageBytes = buffer.toByteArray();
                    String base64Image = "data:" + filePart.getContentType() + ";base64," + 
                                         Base64.getEncoder().encodeToString(imageBytes);
                    s.setProfilePic(base64Image);
                }

                // 6. Save everything back to the database
                if (dao.updateProfile(s)) {
                    // Refresh session name in case user changed their name
                    request.getSession().setAttribute("studentName", s.getStudentName());
                    response.sendRedirect("dashboard.jsp?view=profile&msg=success");
                } else {
                    response.sendRedirect("dashboard.jsp?view=profile&msg=error");
                }
            } else {
                response.sendRedirect("dashboard.jsp?view=profile&msg=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?view=profile&msg=error");
        }
    }
}