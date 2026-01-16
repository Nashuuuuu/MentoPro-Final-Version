package dao;

import java.sql.*;
import java.util.*;
import model.Message;
import model.Student;
import controller.DBConn; 

public class MessageDAO {
    
    // 1. Send a new message
    public boolean sendMessage(int senderId, int receiverId, String content) {
        String sql = "INSERT INTO message (message_id, sender_id, receiver_id, content, created_at) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConn.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String uuid = UUID.randomUUID().toString();
            
            ps.setString(1, uuid);
            ps.setInt(2, senderId);
            ps.setInt(3, receiverId);
            ps.setString(4, content);
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("MessageDAO Send Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // 2. Get full conversation history between two users
    public List<Message> getChatHistory(int user1, int user2) {
        List<Message> history = new ArrayList<>();
        String sql = "SELECT * FROM message WHERE (sender_id = ? AND receiver_id = ?) " +
                     "OR (sender_id = ? AND receiver_id = ?) ORDER BY created_at ASC";
        
        try (Connection conn = DBConn.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, user1);
            ps.setInt(2, user2);
            ps.setInt(3, user2);
            ps.setInt(4, user1);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Message m = new Message();
                    m.setMessageId(rs.getString("message_id"));
                    m.setSenderId(rs.getInt("sender_id"));
                    m.setReceiverId(rs.getInt("receiver_id"));
                    m.setContent(rs.getString("content"));
                    m.setCreatedAt(rs.getTimestamp("created_at"));
                    history.add(m);
                }
            }
        } catch (Exception e) {
            System.err.println("MessageDAO History Error: " + e.getMessage());
            e.printStackTrace();
        }
        return history;
    }

    /**
     * 3. Get Recent Chat Partners
     * This is needed to show the list of people you have talked to on the left side of the chat.
     */
    public List<Map<String, Object>> getRecentChatPartners(int currentUserId) {
        List<Map<String, Object>> partners = new ArrayList<>();
        // This query finds unique users who sent/received messages to/from current user
        // and gets their name and profile pic from the student table.
        String sql = "SELECT DISTINCT s.studentID, s.studentName, s.profilePic, s.studentRole " +
                     "FROM student s " +
                     "JOIN message m ON (s.studentID = m.sender_id OR s.studentID = m.receiver_id) " +
                     "WHERE (m.sender_id = ? OR m.receiver_id = ?) AND s.studentID != ? " +
                     "ORDER BY s.studentName ASC";

        try (Connection conn = DBConn.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, currentUserId);
            ps.setInt(2, currentUserId);
            ps.setInt(3, currentUserId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> partner = new HashMap<>();
                    partner.put("id", rs.getInt("studentID"));
                    partner.put("name", rs.getString("studentName"));
                    partner.put("pic", rs.getString("profilePic"));
                    partner.put("role", rs.getString("studentRole"));
                    partners.add(partner);
                }
            }
        } catch (Exception e) {
            System.err.println("MessageDAO Partners Error: " + e.getMessage());
            e.printStackTrace();
        }
        return partners;
    }
}