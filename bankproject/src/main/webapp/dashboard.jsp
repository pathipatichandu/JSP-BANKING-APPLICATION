<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - Personal Finance Management System</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f2f6fa;
        margin: 0;
        padding: 0;
    }
    header {
        background-color: #004aad;
        color: white;
        padding: 15px 30px;
        text-align: center;
        font-size: 24px;
        font-weight: bold;
    }
    .logout {
        position: absolute;
        right: 20px;
        top: 20px;
    }
    .logout a {
        background-color: #ff4d4d;
        color: white;
        padding: 8px 15px;
        border-radius: 6px;
        text-decoration: none;
    }
    .logout a:hover {
        background-color: #e60000;
    }
    .container {
        max-width: 1000px;
        margin: 30px auto;
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    h2 {
        color: #004aad;
        text-align: center;
    }
    .info-box {
        display: flex;
        justify-content: space-around;
        margin-top: 30px;
    }
    .box {
        width: 250px;
        background-color: #e9f0ff;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
        box-shadow: 0px 3px 6px rgba(0,0,0,0.1);
    }
    .box h3 {
        margin: 10px 0;
        color: #004aad;
    }
    .box p {
        font-size: 18px;
        color: #333;
    }
    .links {
        text-align: center;
        margin-top: 40px;
    }
    .links a {
        display: inline-block;
        background-color: #004aad;
        color: white;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 8px;
        margin: 5px;
    }
    .links a:hover {
        background-color: #003580;
    }
</style>
</head>
<body>

<header>
    Personal Finance Dashboard
    <div class="logout">
        <a href="logout.jsp">Logout</a>
    </div>
</header>

<div class="container">
    <%
        // Ensure user is logged in
        String uname = (String) session.getAttribute("username");
        if (uname == null) {
            response.sendRedirect("login.jsp");
        }

        double totalBalance = 0;
        double totalExpenses = 0;
        double totalGoals = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4pmdb", "root", "Chandu@143");

            // Example: Fetch balances, expenses, goals from your tables
            // (You can modify table names and column names as per your DB)
            PreparedStatement ps1 = con.prepareStatement("SELECT SUM(balance) FROM accounts WHERE username=?");
            ps1.setString(1, uname);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) totalBalance = rs1.getDouble(1);

            PreparedStatement ps2 = con.prepareStatement("SELECT SUM(amount) FROM expenses WHERE username=?");
            ps2.setString(1, uname);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) totalExpenses = rs2.getDouble(1);

            PreparedStatement ps3 = con.prepareStatement("SELECT SUM(goal_amount) FROM goals WHERE username=?");
            ps3.setString(1, uname);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) totalGoals = rs3.getDouble(1);

            con.close();
        } catch (Exception e) {
            out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
        }
    %>

    <h2>Welcome, <%= uname %> 👋</h2>

    <div class="info-box">
        <div class="box">
            <h3>Total Balance</h3>
            <p>₹ <%= totalBalance %></p>
        </div>
        <div class="box">
            <h3>Total Expenses</h3>
            <p>₹ <%= totalExpenses %></p>
        </div>
        <div class="box">
            <h3>Goals Set</h3>
            <p>₹ <%= totalGoals %></p>
        </div>
    </div>

    <div class="links">
        <a href="accounts.jsp">Manage Accounts</a>
        <a href="transactions.jsp">View Transactions</a>
        <a href="bills.jsp">Manage Bills</a>
        <a href="expenses.jsp">Track Expenses</a>
        <a href="goals.jsp">View Goals</a>
    </div>
</div>

</body>
</html>
