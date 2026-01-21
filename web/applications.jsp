<%@ page session="true" %>
<%@ page import="dao.MentorshipDAO, java.util.*" %>
<%
    // Only Mentors can access this page
    String role = (String) session.getAttribute("studentRole");
    if (role == null || !role.equals("Mentor")) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    // Get Mentor ID from session
    Integer mentorId = (Integer) session.getAttribute("studentID");
    
    // Fetch pending applications
    MentorshipDAO mDao = new MentorshipDAO();
    List<Map<String, Object>> apps = new ArrayList<>();
    try {
        apps = mDao.getPendingApplications(mentorId);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mentee Requests | MentoPro</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .app-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .app-table th {
            background: #f1f3f5;
            padding: 15px;
            text-align: left;
            font-size: 14px;
            color: #495057;
        }
        .app-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }
        .btn-action {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            font-size: 12px;
            margin-right: 5px;
        }
        .btn-accept { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .btn-reject { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .btn-accept:hover { background: #c3e6cb; }
        .btn-reject:hover { background: #f5c6cb; }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>MentoPro</h2>
    <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="applications.jsp" style="color:#ff7e67;">Mentee Requests</a></li>
        <li><a href="#">Resources Hub</a></li>
        <li style="margin-top: 30px;"><a href="logout.jsp" style="color: #ffb8b8;">Logout</a></li>
    </ul>
</div>

<div class="main">
    <div class="hero">
        <h1>Mentee Applications</h1>
        <p>Review and manage students who want you as their mentor.</p>
    </div>

    <div class="mentor-section">
        <% if (apps.isEmpty()) { %>
            <div style="text-align: center; padding: 40px; background: white; border-radius: 10px;">
                <p style="color: #888;">No pending requests at the moment.</p>
            </div>
        <% } else { %>
            <table class="app-table">
                <thead>
                    <tr>
                        <th>Mentee Name</th>
                        <th>Course</th>
                        <th>CGPA</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Map<String, Object> app : apps) { %>
                    <tr>
                        <td><strong><%= app.get("name") %></strong></td>
                        <td><%= app.get("course") %></td>
                        <td><%= app.get("cgpa") %></td>
                        <td>
                            <a href="MentorshipServlet?action=accept&menteeId=<%= app.get("id") %>&mentorId=<%= mentorId %>" class="btn-action btn-accept">ACCEPT</a>
                            <a href="MentorshipServlet?action=reject&menteeId=<%= app.get("id") %>&mentorId=<%= mentorId %>" class="btn-action btn-reject">REJECT</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
</div>

</body>
</html>