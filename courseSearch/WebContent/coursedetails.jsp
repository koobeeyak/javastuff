<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page 
             import="java.sql.*,
                     javax.sql.*,
                     java.io.*,
                     java.util.List,
                     java.util.ArrayList,
                     javax.naming.InitialContext,
                     javax.naming.Context" %>
   <%@include file="head.html"%>
   <%@include file="body.html"%>
<table id="details" summary="This table contains details about each course.">
<caption>
Schedule of Classes Course Details 
</caption>  
<%
Connection conn = null;
try
{
   String driver = "oracle.jdbc.OracleDriver"; // database connection information
   String url = "jdbc:oracle:thin:@localhost:1521:XE";
   String myusername = "cis4160";
   String mypassword = "cis4160";
	  
   Class.forName(driver);
  
   conn = DriverManager.getConnection(url,myusername,mypassword);
   
   String semester = request.getParameter("semester"); //the fields we take from previous page as part of request
   String courseCode = request.getParameter("coursecode"); //we get them thanks to constructed link with parameters 
   
   PreparedStatement stmt = null;
   String query = "SELECT * " // Let's select all, we will specify which columns we need when drawing from result set
		  + "FROM CRS_SEC_SR, CRS_COMMENTS_SR, COURSE_SR, DISCIPLINE_SR " // These tables have the information we want
 		  + "WHERE CRS_COMMENTS_SR.CRS_CD = CRS_SEC_SR.CRS_CD " //WE have to make some table joins so we can get correctly related information
 		  + "AND CRS_COMMENTS_SR.SEMESTER = CRS_SEC_SR.SEMESTER "
 		  + "AND COURSE_SR.DISCIPLINE = CRS_SEC_SR.DISC "
 		  + "AND COURSE_SR.COURSENUMBER = CRS_SEC_SR.CRS_NUM "
 		  + "AND DISCIPLINE_SR.DISC_ABBREVIATION = CRS_SEC_SR.DISC "
 		  + "AND CRS_SEC_SR.SEMESTER = ? " 
 		  + "AND CRS_SEC_SR.CRS_CD = ?";
   stmt = conn.prepareStatement(query);
   stmt.setString(1,semester); // adding semester from parameter to our query
   stmt.setString(2,courseCode); // adding course code to our query, and then executing
   ResultSet rs = stmt.executeQuery();
   %>
   
  <tr>
  <%
  	while (rs.next()){ %> <!-- fill our table with respective values from resultset -->
    <th scope="row">Semester:</th>
    <td><%=rs.getString("SEMESTER") %> </td>
  </tr>
  <tr>
    <th scope="row">Course - Title:</th>
    <td><%=rs.getString("DISC") %> <%=rs.getString("CRS_NUM")%> - <%=rs.getString("TITLE") %></td>
  </tr>
  <tr>
    <th scope="row">Code:</th>
    <td><%=rs.getString("CRS_CD") %></td>
  </tr>
  <tr>
    <th scope="row">Section:</th>
    <td><%=rs.getString("CRS_SEC") %></td>
  </tr>
  <tr>
    <th scope="row">Department:</th>
    <td><%=rs.getString("DISCIPLINE_NAME") %></td>
  </tr>
  <tr>
    <th scope="row">Division:</th>
    <td><% //User sees Graduate or UnderGraduate for each class
    	String division = rs.getString("LEVEL_DIV");
    	if (division == "g")
    		division = "Graduate";
    	else
    		division = "Undergraduate";
    	out.println(division);
    	%>
    </td>
  </tr>
  <tr>
    <th scope="row">Dates:</th><!-- taking a substring of dates will get rid of 00:00:00 hours -->
    <td><%out.println(rs.getString("START_DATE").substring(0, 10) + " - " + rs.getString("END_DATE").substring(0, 10)); %> </td>
  </tr>
  <tr>
    <th scope="row">Seats Available:</th>
    <td><%=rs.getString("SEATS_AVAIL") %></td>
  </tr>
  <tr>
    <th scope="row">Meeting - Day &amp; Time, Building &amp; Room, Instructor: </th>
    <td><%out.println(rs.getString("MEETING_DAYS") + ", " + rs.getString("START_TIME") + rs.getString("AM_PM") + " - " + rs.getString("STOP_TIME") + rs.getString("AM_PM")
    		+ ", " + rs.getString("BUILDING") + " " + rs.getString("RM") + ", " + rs.getString("INSTRUCTOR_LNAME")); %></td>
  </tr>
  <tr>
    <th scope="row">Credit Hours: </th>
    <td><%=rs.getString("CREDITHOUR") %></td>
  </tr>
  <tr>
    <th scope="row">Description:</th>
    <td><%=rs.getString("DESCRIPTION") %></td>
  </tr>
  <tr>
    <th scope="row">Course Comments: </th>
    <td><%//Let's be sure the user doesn't see "null"
    	  String comments = rs.getString("CRS_COMMENTS1");
          if (comments == null)
        		comments = "None";
          out.println(comments);
        %></td>
  </tr>
  <tr>
    <th scope="row">Pre-requisite:</th>
    <td><%=rs.getString("PREREQ") %></td>
  </tr>
</table>
<% break; // ensure no duplicates
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
   <%@include file="foot.html"%>