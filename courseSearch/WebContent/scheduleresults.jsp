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
   String discipline = request.getParameter("discipline"); //Some of these may not have been entered, we will check for that later
   String crsNumber = request.getParameter("number");
   String days = request.getParameter("week");
   String underGrad = request.getParameter("div_undr");
   String grad = request.getParameter("div_grad");
   String instructor = request.getParameter("prof");
            
   PreparedStatement stmt = null; //building our class search query
   String query = "SELECT distinct * " // Let's select all, we will specify which columns we need when drawing from result set
		  + "FROM CRS_SEC_SR, SEMESTER_SR, CRS_COMMENTS_SR, COURSE_SR " // These tables have the information we want, 
 		  + "WHERE SEMESTER_SR.SEMESTER = CRS_SEC_SR.SEMESTER " // we have to make some joins so SQL knows how they're related
 		  + "AND CRS_COMMENTS_SR.CRS_CD = CRS_SEC_SR.CRS_CD "
 		  + "AND CRS_COMMENTS_SR.SEMESTER = CRS_SEC_SR.SEMESTER "
 		  + "AND COURSE_SR.DISCIPLINE = CRS_SEC_SR.DISC "
 		  + "AND COURSE_SR.COURSENUMBER = CRS_SEC_SR.CRS_NUM "
 		  + "AND SEMESTER_SR.SEMESTER_NAME = ?"; // A semester is always the minimum amount of information we require. It is a drop down bar, so it can never be blank.
   // The following if statements will check to see if user inputted parameters
   //(For some parameters, no input means parameter will not exist, for others it will simply be blank)
   // We may add these parameters to our where clause, thereby building the query before it is executed and getting the classes based on specifications 
   if (discipline != "")
	   query += " AND CRS_SEC_SR.DISC = '" + discipline + "'";
   if (crsNumber != "")
	   query += " AND CRS_SEC_SR.CRS_NUM = '" + crsNumber + "'";
   if (days != "")
	   query += " AND CRS_SEC_SR.MEETING_DAYS = '" + days + "'";
   if (underGrad != null && grad == null) // only UnderGraduate box is checked
	   query += " AND COURSE_SR.LEVEL_DIV = 'u'";
   if (grad != null && underGrad == null) // only Graduate box is checked
	   query += " AND COURSE_SR.LEVEL_DIV = 'g'"; // so if both or neither U or G boxes are checked, let's return all class matches for both undergrad and grad
   if (instructor != ""){
	   instructor = instructor.toUpperCase(); // Database contains mix of uppercase and lowercase, let's make it consistent
	   query += " AND UPPER(CRS_SEC_SR.INSTRUCTOR_LNAME) = '" + instructor + "'"; // UPPER() will give us case insensitive search
   }
   query += " ORDER BY CRS_SEC_SR.CRS_CD";
   stmt = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE); //scroll insensitive result set ensures we can test whether any classes were returned
   stmt.setString(1,semester); // adding semester (which will always exist as a parameter) to our query before we execute it
   ResultSet rs = stmt.executeQuery();

   PreparedStatement stmt2 = null; //this will be a query to get last update time and date for the semester
   String query2 = "SELECT * "
		   + "FROM UPDATE_TIME_SR, SEMESTER_SR " //we want the update time, but have to match it to semester_name because that's the parameter
		   + "WHERE UPDATE_TIME_SR.SEMESTER = SEMESTER_SR.SEMESTER "
		   + "AND SEMESTER_SR.SEMESTER_NAME = ?";
   stmt2 = conn.prepareStatement(query2);
   stmt2.setString(1,semester); //adding semester_name to query
   ResultSet rs2 = stmt2.executeQuery();
   

%>
  <p>Search results are based on the following keywords:</p>
  <table id="criteria" summary="This table contains the search criteria. Results are listed in next table.">
    <tr>
      <td><strong>Semester</strong>: <%=semester %></td> <!-- All of these are taken from parameters -->
      <td><strong>Days</strong>: <%=days %></td>
    </tr>
    <tr>
      <td><strong>Department</strong>: <%=request.getParameter("department") %></td>
      <td><strong>Time</strong>: <%=request.getParameter("time") %></td>
    </tr>
    <tr>
      <td><strong>Discipline</strong>: <%=discipline %></td>
      <td><strong>Course number</strong>: <%=crsNumber %></td>
    </tr>
    <tr>
      <td><strong>Division</strong>: <%=underGrad %>, <%=grad %></td>
      <td><strong>Instructor</strong>: <%=instructor %> </td>
    </tr>
    </table>
  <font color="red">
  <%while (rs2.next()){ %><!-- let's let the user know when the tables were last updated for a specific semester -->
  <p><b>The schedule was LAST&nbsp; updated on <%=rs2.getString("UPDATE_TIME") %>.</b></p>
  <%} %>
  <p>Due to the dynamic nature of the registration process, not all courses listed as open will have space for new registrants.</p>
  </font>
<table id="results" summary="This table contains the search results for schedule of classes.">
  <caption>
  Schedule of Classes Search Results
  </caption>
  <%if (!rs.isBeforeFirst()){ //first, check if we found any classes. Let the user know if there aren't any.
		  %><h1>No classes found.</h1><%
   }
   else{ //if we have classes in our result set, let's generate the table %> 
  <thead>
    <tr>
      <th scope="col">Course</th>
      <th scope="col">Code</th>
      <th scope="col">Section</th>
      <th scope="col">Day &amp; Time </th>
      <th scope="col">Dates</th>
      <th scope="col">Bldg &amp; Rm </th>
      <th scope="col">Instructor</th>
      <th scope="col">Seats Avail </th>
      <th scope="col">Comments</th>
    </tr>
  </thead>
  <tbody>
    <% 
    
    while (rs.next()){ //resultset containing classes. We already checked if its empty
    	out.println("<tr>"); 
    	//in the following line, we construct a link to coursedetails.jsp page AND pass parameters to it of semester and course code. We will use this to get details of course on next page.
    	//then, name the link as the discipline and course number.
    	out.println("<td><a href =\"coursedetails.jsp?semester=" + rs.getString("SEMESTER") + "&coursecode=" + rs.getString("CRS_CD")+"\">" + rs.getString("DISC") + rs.getString("CRS_NUM") + "</a></td>");
    	out.println("<td>" + rs.getString("CRS_CD") + "</td>");
    	out.println("<td>" + rs.getString("CRS_SEC") + "</td>");
    	out.println("<td>" + rs.getString("MEETING_DAYS") + "  " + rs.getString("START_TIME") + rs.getString("AM_PM") + " - " + rs.getString("STOP_TIME") + rs.getString("AM_PM") + "</td>");
    	//taking a substring of dates will get rid of 00:00:00 hours
    	out.println("<td>" + rs.getString("START_DATE").substring(0, 10) + " - " + rs.getString("END_DATE").substring(0, 10) + "</td>");
    	out.println("<td>" + rs.getString("BUILDING") + " " + rs.getString("RM") + "</td>");
        out.println("<td>" + rs.getString("INSTRUCTOR_LNAME") + "</td>");
        out.println("<td>" + rs.getString("SEATS_AVAIL") + "</td>");
        String comments = rs.getString("CRS_COMMENTS1");
        // ensure user is not seeing "null" on page
        if (comments == null)
        		comments = "None";
        out.println("<td>" + comments + "</td>");
    	out.println("</tr>");
    }
    %>
  </tbody>
</table>
<%} %>
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
   <%@include file="foot.html"%>