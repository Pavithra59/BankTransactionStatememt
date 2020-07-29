<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%-- Importing required Libraries of Java --%>
    <%@ page import="java.sql.*" %>
    <%@ page import= "java.text.*" %>
    <%@ page import= "java.util.Date" %>
    
<%! String driverName = "com.mysql.cj.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/BankStatement";%>
<%!String user = "newuser";%>
<%!String psw = "root";%>
<% 
Connection con = null;
PreparedStatement ps = null;
Statement statement = null;
ResultSet resultset = null;
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
statement=con.createStatement();
// adding current date to database
  Date date=new Date();
  SimpleDateFormat formatter= new SimpleDateFormat("yyyy/MM/dd");
  String Dates= formatter.format(date);
  String Details= "Fund";
  float Withdrawals = 1000;
  float Deposits = 0;
  // Getting account balance from TransactionDetails table to calculate further changes
  String sqll = "Select SI_NO,Balance from TransactionDetails where SI_NO = (select MAX(SI_NO) from TransactionDetails)";
  resultset = statement.executeQuery(sqll);
  if(resultset.next())
 {
  float balance = resultset.getFloat("Balance");
  float Balance = balance - Withdrawals;
  int SI_NO= (resultset.getInt("SI_NO"))+1;
 // Inserting values to the database after fund ttansfer operation
  String sql="INSERT INTO TransactionDetails(SI_NO,Dates,Details,Withdrawals,Deposits,Balance)VALUES(?,?,?,?,?,?)";
  ps = con.prepareStatement(sql);
  ps.setInt(1,SI_NO);
  ps.setString(2, Dates);
  ps.setString(3, Details);
  ps.setFloat(4, Withdrawals);
  ps.setFloat(5, Deposits);
  ps.setFloat(6,Balance);
  ps.executeUpdate();
  %>
   <h3> CLICK TO VIEW BANK STATEMENT</h3>
  <form method="post" action="TransactionDetails.jsp">
  <input type="submit" value="BankStatement">
 </form>
 <%
 }
  }
catch(SQLException sql)
{
  System.err.println(sql);
}
 %>
   
  
  