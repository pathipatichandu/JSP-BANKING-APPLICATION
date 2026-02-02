<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Personal Finance Management System</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f4f8;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 400px;
        margin: 100px auto;
        background: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0px 4px 10px rgba(0,0,0,0.2);
    }
    h2 {
        text-align: center;
        color: #004aad;
    }
    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 8px 0;
        border-radius: 8px;
        border: 1px solid #ccc;
    }
    input[type="submit"] {
        background-color: #004aad;
        color: white;
        border: none;
        padding: 10px 20px;
        width: 100%;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
    }
    input[type="submit"]:hover {
        background-color: #003580;
    }
    .error {
        color: red;
        text-align: center;
    }
    .success {
        color: green;
        text-align: center;
    }
</style>
</head>
<body>

<div class="container">
    <h2>User Login</h2>
    <form method="post">
        <label>Username:</label>
        <input type="text" name="uname" required><br>
        <label>Password:</label>
        <input type="password" name="psw" required><br>
        <input type="submit" value="Login">
    </form>

<%
if (request.getMethod().equalsIgnoreCase("POST")) {
    String uname = request.getParameter("uname");
    String psw = request.getParameter("psw");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4pmdb", "root", "Chandu@143");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM banking WHERE name=? AND password=?");
        ps.setString(1, uname);
        ps.setString(2, psw);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            session.setAttribute("username", uname);  // store user in session
            out.println("<h3 class='success'>Login successful! Redirecting...</h3>");
            response.setHeader("Refresh", "2; URL=home.jsp"); // redirect to home page after 2 sec
        } else {
            out.println("<h3 class='error'>Invalid username or password!</h3>");
        }

        con.close();
    } catch (Exception e) {
        out.println("<h3 class='error'>Error: " + e.getMessage() + "</h3>");
    }
}
%>
</div>

</body>
</html>
