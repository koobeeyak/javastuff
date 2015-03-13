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
<title>Update</title>
</head>
<BODY BGCOLOR="white">
<CENTER>
<H1>Welcome to Update Baruch Course Schedule</H1>
<br>
<%
	if (session.getAttribute("user") == null)//check if user has previously logged in and session exists
	{
		response.sendRedirect("login.jsp");//if it's null, user never logged in to create a session attribute "user",
	}							// and we need to redirect user to login
%>
<p>Please enter dates in DD-mon-YY format.</p>
<p>E.g. "12-sep-14"</p>
<FORM ACTION="display.jsp" METHOD="post">
  <label>Semester:
    <select name="semester">
    <option selected="selected">Semester Select</option>
    <option value='Spring'>Spring 2007 </option>
    <%

   Connection conn = null;
    
   try
   {
	    String driver = "oracle.jdbc.OracleDriver";
	    String url = "jdbc:oracle:thin:@localhost:1521:XE";
	    String myusername = "cis4160";
	    String mypassword = "cis4160";
	    
                Class.forName(driver);
     
      conn = DriverManager.getConnection(url,myusername,mypassword);
               
      Statement stmt = conn.createStatement();

      ResultSet rs = stmt.executeQuery("SELECT * FROM SEMESTER_SR");

      while(rs.next()) // this will fill the drop down bar with appropriate semester names from database
      {

        out.println("<option value='" +rs.getString("SEMESTER_NAME") + "'>" +
            rs.getString("SEMESTER_NAME") + "</option>");

      }

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

    </select>
  </label>&nbsp;&nbsp;
  Start Date:
  <INPUT TYPE="TEXT" NAME="startDate" VALUE="">&nbsp;&nbsp;&nbsp;
  End Date:
  <INPUT TYPE="TEXT" NAME="endDate" VALUE=""><br><br><br>
  <INPUT TYPE="SUBMIT" value="Update Schedule"> <!-- Press this button to submit form -->
</FORM>
</CENTER>
<p>Username:<%=session.getAttribute("user") %></p>
</body>
</html>