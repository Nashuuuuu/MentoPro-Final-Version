<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.StudentDAO, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Join MentoPro | Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Standard CSS for older browsers/NetBeans compatibility */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        body {
            background: #667eea; /* Fallback */
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-container {
            background: #ffffff;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 480px;
        }

        h2 { 
            color: #333333; 
            margin-bottom: 5px; 
            text-align: center; 
            font-size: 26px; 
            font-weight: bold;
        }

        .subtitle {
            text-align: center;
            color: #777777;
            font-size: 14px;
            margin-bottom: 25px;
        }
        
        /* Avatar Selection - Squared */
        .avatar-selection-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 25px;
        }

        .profile-preview-container {
            position: relative;
            width: 100px;
            height: 100px;
            cursor: pointer;
        }

        .profile-preview {
            width: 100%;
            height: 100%;
            border-radius: 50%; /* CHANGED: Square to Circle */
            object-fit: cover;
            border: 4px solid #ffffff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            background: #f8f9fa;
        }

        .camera-overlay {
            position: absolute;
            bottom: -5px;
            right: -5px;
            background: #667eea;
            color: #ffffff;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            border: 2px solid #ffffff;
        }

        .avatar-label {
            margin-top: 12px;
            font-size: 12px;
            color: #667eea;
            font-weight: bold;
            text-transform: uppercase;
        }

        /* Modal - Legacy compatible transitions */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 15px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }

        .avatar-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-top: 15px;
        }

        .avatar-option {
            width: 100%;
            border-radius: 8px;
            cursor: pointer;
            border: 3px solid transparent;
            transition: 0.2s;
        }

        .avatar-option:hover {
            border-color: #667eea;
            transform: scale(1.05);
        }

        .avatar-option.selected {
            border-color: #667eea;
            background-color: #f0f4ff;
        }

        /* Form Styling */
        .input-group { margin-bottom: 15px; }
        .input-group label { 
            display: block; 
            margin-bottom: 6px; 
            color: #555555; 
            font-weight: 600; 
            font-size: 13px; 
        }
        
        .input-group label i { margin-right: 5px; color: #667eea; }

        .input-group input, .input-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #dddddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
        }

        .input-group input:focus { border-color: #667eea; }
        
        .role-selection { display: flex; gap: 10px; margin-bottom: 15px; }
        .role-option { flex: 1; }
        .role-option input { display: none; }
        .role-option label {
            display: block;
            padding: 10px;
            text-align: center;
            border: 2px solid #eeeeee;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            color: #888888;
        }

        .role-option input:checked + label { 
            border-color: #667eea; 
            color: #667eea; 
            background: #f0f4ff; 
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }

        .login-link { text-align: center; margin-top: 20px; font-size: 14px; color: #777777; }
        .login-link a { color: #667eea; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Create Account</h2>
    <p class="subtitle">Join the MentoPro community</p>

    <form action="RegisterServlet" method="POST">
        <!-- Profile Picture Section -->
        <div class="avatar-selection-wrapper">
            <div class="profile-preview-container" onclick="openAvatarModal()">
                <!-- Default set to pic1 -->
                <img src="gambar/pic2.png" id="mainProfilePreview" class="profile-preview">
                <div class="camera-overlay">
                    <i class="fa-solid fa-camera"></i>
                </div>
            </div>
            <span class="avatar-label">Select Avatar</span>
            <input type="hidden" id="profilePicInput" name="profilePic" value="gambar/pic1.png">
        </div>

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
            <input type="number" name="studentID" placeholder="ID Number" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-user"></i> Full Name</label>
            <input type="text" name="name" placeholder="Full Name" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-book"></i> Course</label>
            <select name="courseCode" required>
                <option value="" disabled selected>Select Course</option>
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
            <label><i class="fa-solid fa-user-tag"></i> Username</label>
            <input type="text" name="username" placeholder="Choose username" required>
        </div>

        <div class="input-group">
            <label><i class="fa-solid fa-lock"></i> Password</label>
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <button type="submit" class="btn-register">Sign Up Now</button>
    </form>
    
    <div class="login-link">
        Already registered? <a href="login.jsp">Login here</a>
    </div>
</div>

<!-- Avatar Selection Modal -->
<div id="avatarModal" class="modal">
    <div class="modal-content">
        <h3 style="margin-bottom:15px;">Choose Avatar</h3>
        <div class="avatar-grid">
            <% for(int i=1; i<=12; i++) { 
                String path = "gambar/pic" + i + ".png";
            %>
                <img src="<%= path %>" class="avatar-option" onclick="selectAvatar('<%= path %>')">
            <% } %>
        </div>
        <button onclick="closeAvatarModal()" style="margin-top:20px; background:#f1f1f1; border:none; padding:8px 20px; border-radius:5px; cursor:pointer;">Close</button>
    </div>
</div>

<script>
    var modal = document.getElementById('avatarModal');

    function openAvatarModal() {
        modal.style.display = 'flex';
    }

    function closeAvatarModal() {
        modal.style.display = 'none';
    }

    function selectAvatar(path) {
        document.getElementById('profilePicInput').value = path;
        document.getElementById('mainProfilePreview').src = path;
        
        var options = document.getElementsByClassName('avatar-option');
        for(var i=0; i < options.length; i++) {
            options[i].classList.remove('selected');
            if(options[i].src.indexOf(path) !== -1) {
                options[i].classList.add('selected');
            }
        }
        closeAvatarModal();
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            closeAvatarModal();
        }
    }
</script>

</body>
</html>