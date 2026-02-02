<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Goal Setting & Tracking</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f1f4f9;
    font-family: 'Segoe UI', sans-serif;
}
.container {
    margin-top: 40px;
    max-width: 900px;
}
.card {
    border-radius: 12px;
    box-shadow: 0 0 15px rgba(0,0,0,0.1);
}
h2 {
    color: #0d6efd;
    text-align: center;
}
.table {
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
}
th {
    background-color: #198754;
    color: white;
}
.progress {
    height: 20px;
    border-radius: 8px;
}
</style>
</head>

<body>
<div class="container">
    <div class="card p-4">
        <h2>🎯 Set New Financial Goal</h2>
        <form method="post" class="mt-3">
            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label">Goal Name</label>
                    <input type="text" name="goalName" class="form-control" placeholder="e.g. Buy a Bike" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Target Amount (₹)</label>
                    <input type="number" name="targetAmount" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Saved Amount (₹)</label>
                    <input type="number" name="savedAmount" class="form-control" value="0">
                </div>
                <div class="col-md-2">
                    <label class="form-label">Due Date</label>
                    <input type="date" name="dueDate" class="form-control" required>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary px-5">Add Goal</button>
            </div>
        </form>
    </div>

    <%
        // Simple Goal class
        class Goal {
            String name, dueDate;
            double target, saved;
            Goal(String name, double target, double saved, String dueDate) {
                this.name = name; this.target = target; this.saved = saved; this.dueDate = dueDate;
            }
        }

        // Retrieve existing goals from session or create a new list
        List<Goal> goals = (List<Goal>) session.getAttribute("goals");
        if (goals == null) goals = new ArrayList<>();

        // Handle form submission
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String gName = request.getParameter("goalName");
            double target = Double.parseDouble(request.getParameter("targetAmount"));
            double saved = Double.parseDouble(request.getParameter("savedAmount"));
            String due = request.getParameter("dueDate");

            goals.add(new Goal(gName, target, saved, due));
            session.setAttribute("goals", goals);
        }
    %>

    <div class="card mt-5 p-4">
        <h2 class="text-success mb-4">📊 Goals Overview</h2>

        <%
            if (goals.size() == 0) {
        %>
            <div class="alert alert-info text-center">No goals added yet. Add your first goal above!</div>
        <%
            } else {
        %>

        <table class="table table-striped text-center">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Goal Name</th>
                    <th>Target (₹)</th>
                    <th>Saved (₹)</th>
                    <th>Progress</th>
                    <th>Due Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    for (Goal g : goals) {
                        double progress = (g.saved / g.target) * 100;
                        String status = progress >= 100 ? "Completed" : "In Progress";
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= g.name %></td>
                    <td><%= g.target %></td>
                    <td><%= g.saved %></td>
                    <td>
                        <div class="progress">
                            <div class="progress-bar bg-success" role="progressbar"
                                style="width: <%= progress %>%">
                                <%= String.format("%.0f", progress) %>%
                            </div>
                        </div>
                    </td>
                    <td><%= g.dueDate %></td>
                    <td><%= status %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>
</body>
</html>
