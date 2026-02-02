<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Accounts - Personal Finance Management System</title>
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
        text-align: center;
        padding: 15px;
        font-size: 24px;
    }
    .container {
        width: 80%;
        margin: 40px auto;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        padding: 30px;
    }
    h2 {
        color: #004aad;
        text-align: center;
    }
    form {
        text-align: center;
        margin-bottom: 30px;
    }
    input[type="text"], input[type="number"] {
        padding: 10px;
        width: 250px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin: 5px;
    }
    input[type="submit"] {
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        background-color: #004aad;
        color: white;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #003580;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table, th, td {
        border: 1px solid #ccc;
    }
    th {
        background-color: #004aad;
        color: white;
        padding: 10px;
    }
    td {
        text-align: center;
        padding: 8px;
    }
    .delete-btn {
        color: white;
        background-color: #ff4d4d;
        padding: 5px 10px;
        border-radius: 6px;
        text-decoration: none;
    }
    .delete-btn:hover {
        background-color: #e60000;
    }
    .back {
        text-align: center;
        margin-top: 20px;
    }
    .back a {
        text-decoration: none;
        background-color: #004aad;
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
    }
    .back a:hover {
        background-color: #003580;
    }
</style>
</head>
<body>

<header>Manage Your Accounts</header>

<div class="container">
    <%
        // Ensure user is logged in
        String uname = (String) session.getAttribute("username");
        if (uname == null) {
            response.sendRedirect("login.jsp");
        }
    %>

    <h2>Welcome, <%= uname %> 👋</h2>

    <form method="post">
        <input type="text" name="account_name" placeholder="Enter Account Name" required>
        <input type="number" name="balance" placeholder="Enter Balance" required step="0.01">
        <input type="submit" name="add" value="Add Account">
    </form>

    <%
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4pmdb", "root", "Chandu@143");

        // Handle Add Account
        if (request.getParameter("add") != null) {
            String accName = request.getParameter("account_name");
            double balance = Double.parseDouble(request.getParameter("balance"));
            PreparedStatement ps = con.prepareStatement("INSERT INTO accounts(username, account_name, balance) VALUES(?, ?, ?)");
            ps.setString(1, uname);
            ps.setString(2, accName);
            ps.setDouble(3, balance);
            ps.executeUpdate();
            ps.close();
            out.println("<p style='color:green;text-align:center;'>Account added successfully!</p>");
        }

        // Handle Delete Account
        if (request.getParameter("delete") != null) {
            int id = Integer.parseInt(request.getParameter("delete"));
            PreparedStatement ps = con.prepareStatement("DELETE FROM accounts WHERE id=? AND username=?");
            ps.setInt(1, id);
            ps.setString(2, uname);
            ps.executeUpdate();
            ps.close();
            out.println("<p style='color:red;text-align:center;'>Account deleted successfully!</p>");
        }

        // Display all user accounts
        PreparedStatement ps2 = con.prepareStatement("SELECT * FROM accounts WHERE username=?");
        ps2.setString(1, uname);
        ResultSet rs = ps2.executeQuery();
    %>

    <table>
        <tr>
            <th>ID</th>
            <th>Account Name</th>
            <th>Balance (₹)</th>
            <th>Action</th>
        </tr>

        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("account_name") %></td>
            <td><%= rs.getDouble("balance") %></td>
            <td>
                <a class="delete-btn" href="accounts.jsp?delete=<%= rs.getInt("id") %>">Delete</a>
            </td>
        </tr>
        <%
            }
            rs.close();
            ps2.close();
            con.close();
        %>
    </table>

    <div class="back">
        <a href="dashboard.jsp">← Back to Dashboard</a>
    </div>
</div>

</body>
</html>
