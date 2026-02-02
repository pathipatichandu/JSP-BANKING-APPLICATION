<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bill Management - Personal Finance Management System</title>
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
    input[type="text"], input[type="number"], input[type="date"] {
        padding: 10px;
        width: 220px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin: 5px;
    }
    input[type="submit"] {
        padding: 10px 20px;
        background-color: #004aad;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #003580;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th {
        background-color: #004aad;
        color: white;
        padding: 10px;
    }
    td {
        text-align: center;
        padding: 8px;
        border: 1px solid #ddd;
    }
    .btn {
        text-decoration: none;
        color: white;
        padding: 5px 10px;
        border-radius: 6px;
    }
    .delete-btn {
        background-color: #ff4d4d;
    }
    .delete-btn:hover {
        background-color: #e60000;
    }
    .pay-btn {
        background-color: #00b300;
    }
    .pay-btn:hover {
        background-color: #009900;
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

<header>Bill Management</header>

<div class="container">
<%
    // Ensure user is logged in
    String uname = (String) session.getAttribute("username");
    if (uname == null) {
        response.sendRedirect("login.jsp");
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4pmdb", "root", "Chandu@143");

    // Add new bill
    if (request.getParameter("add") != null) {
        String billName = request.getParameter("bill_name");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String dueDate = request.getParameter("due_date");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO bills(username, bill_name, amount, due_date, status) VALUES (?, ?, ?, ?, 'Pending')"
        );
        ps.setString(1, uname);
        ps.setString(2, billName);
        ps.setDouble(3, amount);
        ps.setString(4, dueDate);
        ps.executeUpdate();
        ps.close();

        out.println("<p style='color:green;text-align:center;'>Bill added successfully!</p>");
    }

    // Mark bill as paid
    if (request.getParameter("paid") != null) {
        int id = Integer.parseInt(request.getParameter("paid"));
        PreparedStatement ps = con.prepareStatement("UPDATE bills SET status='Paid' WHERE id=? AND username=?");
        ps.setInt(1, id);
        ps.setString(2, uname);
        ps.executeUpdate();
        ps.close();

        out.println("<p style='color:blue;text-align:center;'>Bill marked as paid!</p>");
    }

    // Delete bill
    if (request.getParameter("delete") != null) {
        int id = Integer.parseInt(request.getParameter("delete"));
        PreparedStatement ps = con.prepareStatement("DELETE FROM bills WHERE id=? AND username=?");
        ps.setInt(1, id);
        ps.setString(2, uname);
        ps.executeUpdate();
        ps.close();

        out.println("<p style='color:red;text-align:center;'>Bill deleted successfully!</p>");
    }
%>

<h2>Welcome, <%= uname %> 👋</h2>

<form method="post">
    <input type="text" name="bill_name" placeholder="Enter Bill Name" required>
    <input type="number" name="amount" placeholder="Enter Amount" step="0.01" required>
    <input type="date" name="due_date" required>
    <input type="submit" name="add" value="Add Bill">
</form>

<table>
    <tr>
        <th>ID</th>
        <th>Bill Name</th>
        <th>Amount (₹)</th>
        <th>Due Date</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

<%
    // Display user bills
    PreparedStatement ps2 = con.prepareStatement("SELECT * FROM bills WHERE username=? ORDER BY due_date ASC");
    ps2.setString(1, uname);
    ResultSet rs = ps2.executeQuery();

    while (rs.next()) {
        String status = rs.getString("status");
        String color = status.equalsIgnoreCase("Paid") ? "green" : "red";
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("bill_name") %></td>
        <td><%= rs.getDouble("amount") %></td>
        <td><%= rs.getString("due_date") %></td>
        <td style="color:<%= color %>;"><%= status %></td>
        <td>
            <% if (!status.equalsIgnoreCase("Paid")) { %>
                <a class="btn pay-btn" href="bills.jsp?paid=<%= rs.getInt("id") %>">Mark Paid</a>
            <% } %>
            <a class="btn delete-btn" href="bills.jsp?delete=<%= rs.getInt("id") %>">Delete</a>
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
