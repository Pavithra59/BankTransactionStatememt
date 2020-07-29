<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%-- Importing required Libraries of Java --%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%-- Connecting database and adding userid as newuser and password as root --%>
<%
String driver = "com.mysql.cj.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/BankStatement";
String database = "BankStatement";
String userid = "newuser";
String password = "root";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
ResultSet resultset = null;
%>
<!DOCTYPE html>
<html>
<body>
<%-- Printing Table headers, form and setting its action to Fund_Transfer.jsp --%>
<h3>BANK TRANSACTION STATEMENT</h3>
<form method="post" action="Fund_Transfer.jsp">
<table border="1">
<tr>
<td>Dates</td>
<td>Details</td>
<td>withdrawals</td>
<td>Deposits</td>
<td>Balance</td>

</tr>
<%-- Retrieving all the data from database and printing it in table format --%>
<%
try{
connection = DriverManager.getConnection(connectionUrl, userid, password);
statement=connection.createStatement();
String sql ="select * from TransactionDetails";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("Dates") %></td>
<td><%=resultSet.getString("Details") %></td>
<td><%=resultSet.getString("Withdrawals") %></td>
<td><%=resultSet.getString("Deposits") %></td>
<td><%=resultSet.getString("Balance") %></td>
</tr>
<%
}
%>
</table>
<%-- Creating a button as FundTransfer --%>
<input type="submit" value="FundTransfer">
</form>
<% 
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</body>
</html>