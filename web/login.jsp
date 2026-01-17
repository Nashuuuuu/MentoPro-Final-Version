<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | MentoPro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Base styles consistent with Register Page */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        body {
            background: #667eea;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: #ffffff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo-container {
            margin-bottom: 30px;
        }

        .logo-icon {
            background: #667eea;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin: 0 auto 15px;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .logo-text {
            font-size: 28px;
            font-weight: 800;
            color: #333;
            letter-spacing: -1px;
        }

        h2 { 
            color: #333333; 
            margin-bottom: 8px; 
            font-size: 22px; 
        }

        .subtitle { 
            color: #777777; 
            font-size: 14px; 
            margin-bottom: 30px; 
        }

        /* Form Styling */
        .form-group { 
            text-align: left; 
            margin-bottom: 20px; 
        }

        .form-group label { 
            display: block; 
            font-size: 13px; 
            font-weight: 600; 
            color: #555; 
            margin-bottom: 8px; 
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 14px;
        }

        .input-field {
            width: 100%;
            padding: 12px 12px 12px 40px;
            border: 1px solid #ddd;
            border-radius: 10px;
            outline: none;
            transition: all 0.3s;
            font-size: 14px;
        }

        .input-field:focus { 
            border-color: #667eea; 
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1); 
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.3s, transform 0.2s;
        }

        .btn-login:hover { 
            background: #5a6fd6; 
            transform: translateY(-1px);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        /* Footer links */
        .footer-link { 
            margin-top: 25px; 
            font-size: 14px; 
            color: #777; 
        }

        .footer-link a { 
            color: #667eea; 
            text-decoration: none; 
            font-weight: 700; 
            transition: color 0.2s;
        }

        .footer-link a:hover { 
            color: #764ba2;
            text-decoration: underline; 
        }

        /* Error message style (if needed for LoginServlet redirects) */
        .error-msg {
            background: #fff5f5;
            color: #e53e3e;
            padding: 10px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 20px;
            border: 1px solid #feb2b2;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="logo-container">
        <div class="logo-icon">
            <i class="fa-solid fa-graduation-cap"></i>
        </div>
        <div class="logo-text">MentoPro</div>
    </div>

    <h2>Welcome Back!</h2>
    <p class="subtitle">Please enter your details to sign in.</p>

    <!-- Optional: Display error message if login fails (passed from servlet) -->
    <% if(request.getAttribute("error") != null) { %>
        <div class="error-msg">
            <i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="LoginServlet" method="POST">
        <div class="form-group">
            <label>Username</label>
            <div class="input-wrapper">
                <i class="fa-solid fa-user"></i>
                <input type="text" name="username" class="input-field" placeholder="Enter your username" required>
            </div>
        </div>

        <div class="form-group">
            <label>Password</label>
            <div class="input-wrapper">
                <i class="fa-solid fa-lock"></i>
                <input type="password" name="password" class="input-field" placeholder="••••••••" required>
            </div>
        </div>

        <button type="submit" class="btn-login">Sign In</button>
    </form>

    <div class="footer-link">
        Don't have an account? <a href="register.jsp">Register for free</a>
    </div>
</div>

</body>
</html>