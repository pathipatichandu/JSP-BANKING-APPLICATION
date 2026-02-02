<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f7f9fa;
        background-image: credit.jpg;
    }

    header {
        background-color: #004d99;
        color: white;
        text-align: center;
        padding: 20px 0;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }

    header h1 {
        margin: 0;
        font-size: 34px;
        letter-spacing: 1px;
    }

    header h2 {
        margin-top: 6px;
        font-weight: normal;
        font-size: 18px;
        color: #e0e0e0;
    }

    nav {
        background-color: #e6f2ff;
        display: flex;
        justify-content: center;
        padding: 10px 0;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    nav a {
        text-decoration: none;
        color: #004d99;
        font-weight: bold;
        margin: 0 15px;
        padding: 8px 16px;
        border-radius: 5px;
        transition: 0.3s;
    }

    nav a:hover {
        background-color: #004d99;
        color: white;
    }

    .container {
        max-width: 500px;
        margin: 60px auto;
        background-color: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }

    h3 {
        text-align: center;
        background-color: #004d99;
        color: white;
        padding: 12px;
        border-radius: 5px;
        margin-bottom: 25px;
    }

    label {
        display: block;
        font-weight: 600;
        color: #333;
        margin-bottom: 6px;
    }

    input[type="number"],
    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 20px;
        font-size: 15px;
    }

    input[type="submit"] {
        width: 100%;
        background-color: #004d99;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 5px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
    }

    input[type="submit"]:hover {
        background-color: #0073e6;
    }

    footer {
        text-align: center;
        margin-top: 60px;
        padding: 15px;
        background-color: #004d99;
        color: white;
        font-size: 14px;
    }
</style>
</head>
<body>

<header>
    <h1>Personal Finance Management System</h1>
    <h2>Track. Save. Grow Your Finances</h2>
</header>


<div class="container">
    <h3>Signup Form</h3>

<form action="registercode.jsp" method="post"><p></p>
<label>NAME:</label>
<input type="text" name="uname"><p></p>
<label>PASSWORD:</label>
<input type="password" name="psw"><p></p>
<label>CONFIRM PASSWORD:</label>
<input type="password" name="cpsw"><p></p>
<label>Address:</label>
<input type="text" name="address"><p></p>
<label>Mobile_number:</label>
<input type="number" name="mobileno"><p></p>
<input type="submit" value="signup">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</form>
</div>
</center>
<footer>
    &copy; 2025 Personal Finance Management System | All Rights Reserved
</footer>

</body>
</html>