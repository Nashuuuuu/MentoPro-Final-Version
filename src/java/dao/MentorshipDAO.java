package dao;

import controller.DBConn;
import java.sql.*;
import java.util.*;

public class MentorshipDAO {
    
    public List getPendingApplications(int mentorId) throws Exception {
        List list = new ArrayList();
        // Added s.profilePic to the SELECT statement
        String sql = "SELECT s.studentID, s.studentName, s.courseCode, s.studentCGPA, s.profilePic " +
                     "FROM mentorship m " +
                     "JOIN student s ON m.menteeID = s.studentID " +
                     "WHERE m.mentorID = ? AND m.status = 'PENDING'";
        
        try (Connection con = DBConn.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map map = new HashMap();
                map.put("id", rs.getInt("studentID"));
                map.put("name", rs.getString("studentName"));
                map.put("course", rs.getString("courseCode"));
                map.put("cgpa", rs.getDouble("studentCGPA"));
                map.put("profilePic", rs.getString("profilePic")); // Now fetching the picture
                list.add(map);
            }
        }
        return list;
    }

    public boolean applyForMentorship(int menteeId, int mentorId) throws Exception {
        String sql = "INSERT INTO mentorship (menteeID, mentorID, status) VALUES (?, ?, 'PENDING')";
        try (Connection con = DBConn.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, menteeId);
            ps.setInt(2, mentorId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(int menteeId, int mentorId, String status) throws Exception {
        String sql = "UPDATE mentorship SET status = ? WHERE menteeID = ? AND mentorID = ?";
        try (Connection con = DBConn.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, menteeId);
            ps.setInt(3, mentorId);
            return ps.executeUpdate() > 0;
        }
    }
}