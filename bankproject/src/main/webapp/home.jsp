<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Personal Finance Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('image/credit.jpg');
            background-color: #f8f9fa;
            background-image: credit.jpg;
        }
        header {
            background-color: #004aad;
            color: white;
            padding: 20px;
            text-align: center;
            background-image: credit.jpg;
        }
        .home-container {
            text-align: center;
            margin-top: 50px;
             background-image: credit.jpg;
        }
        .home-container img {
            width: 80%;
            max-width: 800px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            background-image: credit.jpg;
        }
        .home-container h2 {
            color: #333;
            margin-top: 30px;
            font-size: 28px;
        }
        .buttons {
            margin-top: 20px;
        }
        .buttons a {
            display: inline-block;
            background-color: #004aad;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            margin: 5px;
        }
        .buttons a:hover {
            background-color: #003580;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome to Personal Finance Management System</h1>
    </header>

    <div class="home-container">
        <!-- Replace this with your own image (put image inside /images folder in WebContent) -->
        <img src="images/credit.jpg" alt="Finance Dashboard">
        <h2>Track. Save. Grow Your Finances.</h2>

        <div class="buttons">
            <a href="register.jsp">Register</a>
            <a href="login.jsp">Login</a>
            <a href="dashboard.jsp">Dashboard</a>
        </div>
    </div>
</body>
</html>
