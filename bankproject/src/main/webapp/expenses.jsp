<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expense Management</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f2f4f8;
    font-family: 'Segoe UI', sans-serif;
}
.container {
    margin-top: 40px;
    max-width: 900px;
}
.card {
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
}
h2 {
    color: #0d6efd;
}
.table {
    background: white;
    border-radius: 8px;
}
th {
    background-color: #0d6efd;
    color: white;
}
</style>
</head>

<body>
<div class="container">
    <div class="card p-4">
        <h2 class="text-center mb-4">💰 Add Two Expenses</h2>

        <form method="post">
            <div class="row mb-3">
                <h5>Expense 1</h5>
                <div class="col-md-3">
                    <input type="text" name="category1" class="form-control" placeholder="Category" required>
                </div>
                <div class="col-md-3">
                    <input type="number" step="0.01" name="amount1" class="form-control" placeholder="Amount" required>
                </div>
                <div class="col-md-3">
                    <input type="date" name="date1" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <input type="text" name="desc1" class="form-control" placeholder="Description">
                </div>
            </div>

            <div class="row mb-3">
                <h5>Expense 2</h5>
                <div class="col-md-3">
                    <input type="text" name="category2" class="form-control" placeholder="Category" required>
                </div>
                <div class="col-md-3">
                    <input type="number" step="0.01" name="amount2" class="form-control" placeholder="Amount" required>
                </div>
                <div class="col-md-3">
                    <input type="date" name="date2" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <input type="text" name="desc2" class="form-control" placeholder="Description">
                </div>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary px-4">Add Expenses</button>
            </div>
        </form>
    </div>

    <%
        class Expense {
            String category, date, desc;
            double amount;
            Expense(String c, double a, String d, String de) {
                category = c; amount = a; date = d; desc = de;
            }
        }

        // Get previous list or create new
        List<Expense> expenses = (List<Expense>) session.getAttribute("expenses");
        if (expenses == null) expenses = new ArrayList<>();

        // If form submitted
        if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                String c1 = request.getParameter("category1");
                double a1 = Double.parseDouble(request.getParameter("amount1"));
                String d1 = request.getParameter("date1");
                String desc1 = request.getParameter("desc1");

                String c2 = request.getParameter("category2");
                double a2 = Double.parseDouble(request.getParameter("amount2"));
                String d2 = request.getParameter("date2");
                String desc2 = request.getParameter("desc2");

                expenses.add(new Expense(c1, a1, d1, desc1));
                expenses.add(new Expense(c2, a2, d2, desc2));

                session.setAttribute("expenses", expenses);
            } catch (Exception e) {
                out.println("<div class='alert alert-danger mt-3'>Error adding expenses!</div>");
            }
        }
    %>

    <div class="card mt-5 p-3">
        <h3 class="text-center mb-3 text-success">📊 Expense Summary</h3>
        <table class="table table-striped text-center">
            <thead>
                <tr>
                    <th>Category</th>
                    <th>Amount (₹)</th>
                    <th>Date</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <%
                    double total = 0;
                    for (Expense e : expenses) {
                        total += e.amount;
                %>
                <tr>
                    <td><%= e.category %></td>
                    <td><%= String.format("%.2f", e.amount) %></td>
                    <td><%= e.date %></td>
                    <td><%= e.desc %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <h5 class="text-end me-3 mt-3">Total: ₹ <%= String.format("%.2f", total) %></h5>
    </div>
</div>
</body>
</html>

