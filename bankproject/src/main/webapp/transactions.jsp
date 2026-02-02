<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transactions - Personal Finance Management System</title>
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
    select, input[type="number"], input[type="text"] {
        padding: 10px;
        width: 200px;
        margin: 5px;
        border-radius: 8px;
        border: 1px solid #ccc;
    }
    input[type="submit"] {
        background-color: #004aad;
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        border: none;
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

<header>Transaction History</header>

<div class="container">
<%
    // Ensure user is logged in
    String uname = (String) session.getAttribute("username");
    if (uname == null) {
        response.sendRedirect("login.jsp");
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/4pmdb", "root", "Chandu@143");

    // Handle new transaction submission
    if (request.getParameter("add") != null) {
        String type = request.getParameter("type");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String description = request.getParameter("description");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO transactions(username, type, amount, description, date) VALUES (?, ?, ?, ?, NOW())"
        );
        ps.setString(1, uname);
        ps.setString(2, type);
        ps.setDouble(3, amount);
        ps.setString(4, description);
        ps.executeUpdate();
        ps.close();
        out.println("<p style='color:green;text-align:center;'>Transaction added successfully!</p>");
    }

    // Handle delete transaction
    if (request.getParameter("delete") != null) {
        int id = Integer.parseInt(request.getParameter("delete"));
        PreparedStatement ps = con.prepareStatement("DELETE FROM transactions WHERE id=? AND username=?");
        ps.setInt(1, id);
        ps.setString(2, uname);
        ps.executeUpdate();
        ps.close();
        out.println("<p style='color:red;text-align:center;'>Transaction deleted successfully!</p>");
    }
%>

<h2>Welcome, <%= uname %> 👋</h2>

<form method="post">
    <select name="type" required>
        <option value="">-- Select Type --</option>
        <option value="credit">Credit (Income)</option>
        <option value="debit">Debit (Expense)</option>
    </select>
    <input type="number" name="amount" step="0.01" placeholder="Amount" required>
    <input type="text" name="description" placeholder="Description" required>
    <input type="submit" name="add" value="Add Transaction">
</form>

<table>
    <tr>
        <th>ID</th>
        <th>Type</th>
        <th>Amount (₹)</th>
        <th>Description</th>
        <th>Date</th>
        <th>Action</th>
    </tr>
<%
    // Display all user transactions
    PreparedStatement ps2 = con.prepareStatement("SELECT * FROM transactions WHERE username=? ORDER BY date DESC");
    ps2.setString(1, uname);
    ResultSet rs = ps2.executeQuery();

    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("type") %></td>
        <td><%= rs.getDouble("amount") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getTimestamp("date") %></td>
        <td><a class="delete-btn" href="transactions.jsp?delete=<%= rs.getInt("id") %>">Delete</a></td>
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
