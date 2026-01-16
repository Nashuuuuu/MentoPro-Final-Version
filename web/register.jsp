<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.StudentDAO, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Join MentoPro | Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 500px;
        }
        h2 { color: #333; margin-bottom: 25px; text-align: center; font-size: 28px; }
        .input-group { margin-bottom: 15px; }
        .input-group label { display: block; margin-bottom: 8px; color: #666; font-weight: 600; font-size: 14px; }
        .input-group input, .input-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
            transition: 0.3s;
        }
        .input-group input:focus, .input-group select:focus { border-color: #667eea; box-shadow: 0 0 8px rgba(102, 126, 234, 0.2); }
        .btn-register {
            width: 100%;
            padding: 14px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-register:hover { background: #5a6fd6; transform: translateY(-1px); }
        .login-link { text-align: center; margin-top: 20px; font-size: 14px; color: #777; }
        .login-link a { color: #667eea; text-decoration: none; font-weight: 700; }
        .role-selection { display: flex; gap: 15px; margin-bottom: 15px; }
        .role-option { flex: 1; text-align: center; }
        .role-option input { display: none; }
        .role-option label {
            display: block;
            padding: 10px;
            border: 2px solid #eee;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            font-weight: 600;
            color: #888;
        }
        .role-option input:checked + label { border-color: #667eea; color: #667eea; background: #f0f4ff; }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Create Account</h2>
    <form action="RegisterServlet" method="POST">
        <div class="role-selection">
            <div class="role-option">
                <input type="radio" name="role" id="mentee" value="Mentee" checked>
                <label for="mentee">Mentee</label>
            </div>
            <div class="role-option">
                <input type="radio" name="role" id="mentor" value="Mentor">
                <label for="mentor">Mentor</label>
            </div>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-id-card"></i> Student ID</label>
            <input type="number" name="studentID" placeholder="Enter your ID" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-user"></i> Full Name</label>
            <input type="text" name="name" placeholder="Enter full name" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-book"></i> Course</label>
            <select name="courseCode" required>
                <option value="" disabled selected>Select your course</option>
                <% 
                    try {
                        StudentDAO courseDao = new StudentDAO();
                        List<Map<String, String>> courses = courseDao.getAllCourses();
                        for(Map<String, String> c : courses) { 
                %>
                    <option value="<%= c.get("code") %>"><%= c.get("code") %> - <%= c.get("name") %></option>
                <% 
                        }
                    } catch(Exception e) {
                %>
                    <option value="" disabled>Error loading courses</option>
                <% 
                    }
                %>
            </select>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-envelope"></i> Email Address</label>
            <input type="email" name="email" placeholder="student@uitm.edu.my" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-user-tag"></i> Username</label>
            <input type="text" name="username" placeholder="Choose a username" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-lock"></i> Password</label>
            <input type="password" name="password" placeholder="Min 6 characters" required>
        </div>

        <button type="submit" class="btn-register">Sign Up Now</button>
    </form>
    
    <div class="login-link">
        Already have an account? <a href="login.jsp">Login here</a>
    </div>
</div>

</body>
</html>