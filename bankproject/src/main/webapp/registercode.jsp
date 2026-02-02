<%@page import="java.lang.ref.PhantomReference"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>

<%
try
{
String name=request.getParameter("uname");
String password=request.getParameter("psw");
String cpassword=request.getParameter("cpsw");
String address=request.getParameter("address");
String mobileno=request.getParameter("mobileno");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/4pmdb","root","Chandu@143");
PreparedStatement ps=con.prepareStatement("insert into banking values(?,?,?,?,?)");


	ps.setString(1, name);
	ps.setString(2, password);
	ps.setString(3, cpassword);
	ps.setString(4, address);
	ps.setString(5, mobileno);
	int i=ps.executeUpdate();
	out.print("<h1>signup been successfuly..............</h1>");
}
catch(Exception ex)
{
	out.print(ex);
}
%>
</body>
</html>