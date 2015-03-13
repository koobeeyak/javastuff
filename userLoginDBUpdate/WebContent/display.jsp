<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <%@ page 
             import="java.sql.*,
                     javax.sql.*,
                     java.io.*,
                     javax.naming.InitialContext,
                     javax.naming.Context" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display</title>
</head>
<%
	if (session.getAttribute("user") == null) //check if user has previously logged in and session exists
	{
		response.sendRedirect("login.jsp"); //if it's null, user never logged in to create a session attribute "user",
	}									// and we need to redirect user to login
%>
<body BGCOLOR="white">
<center>
<h1>You have successfully updated the semester schedule</h1>
</center>


<p align="left">
     <b>
     <a href="logout.jsp"><font size="5">Log out</font></a> </b>&nbsp;<br>

<br>
</p>
<center>
    <%
    String userSemester = request.getParameter("semester"); // these are the data we will be using to update
    String userStartDate = request.getParameter("startDate"); // in request from previous page
    String userEndDate = request.getParameter("endDate");
    
    PreparedStatement stat = null;
    Connection conn = null;
   try
   {
	  String driver = "oracle.jdbc.OracleDriver";
	  String url = "jdbc:oracle:thin:@localhost:1521:XE";
	  String myusername = "cis4160";
	  String mypassword = "cis4160";
	    
      Class.forName(driver);
     
      conn = DriverManager.getConnection(url,myusername,mypassword);
               
      
	// the following will construct a string using request data to form a query
      String updateQueryStr = ("UPDATE SEMESTER_SR"
                                      + " SET START_DATE='" + userStartDate
                                      + "', END_DATE='" + userEndDate
                                      + "' WHERE SEMESTER_NAME='" + userSemester
                                      + "'");
      stat = conn.prepareStatement(updateQueryStr); 
      stat.executeUpdate();
      %>
      <table width=600 border=1>
      <tr>
    <th align=left>Semester Name</th>
        <th align=left>Start Date</th>
        <th align=left>End Date</th>
     </tr>
        <tr>
        <%
        Statement stmt = conn.createStatement();
        ResultSet rs2 = stmt.executeQuery("SELECT * from SEMESTER_SR"
                    + " WHERE SEMESTER_NAME='" + userSemester
                    + "'"); // this will query the databse to show user that the update was successful
       
        while(rs2.next()){
            %>
      <td><%=rs2.getString("SEMESTER_NAME") %></td>
      <td><%=rs2.getString("START_DATE") %></td>
      <td><%=rs2.getString("END_DATE") %></td>
        </tr>
        <% } %>
</table>
      <%

   }
   catch(SQLException e)
   {
      // Is connection made?
      // Is query set up properly?
      out.println("SQLException: " + e.getMessage() + "<BR>");
      while((e = e.getNextException()) != null)
         out.println(e.getMessage() + "<BR>");
   }
   catch(ClassNotFoundException e)
   {
      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
   }
   finally
   {
      if(conn != null)
      {
         try
         {
            conn.close();
         }
         catch (Exception ignored) {}
      }
   }
%>

</center>
<p>Username:<%=session.getAttribute("user") %></p>
</body>
