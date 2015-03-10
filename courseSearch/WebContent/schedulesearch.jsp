<!--
Philip Kubiak  
Professor Abu Kamruzzaman  
CIS 4160  
Final project: Schedule/Class Search  
User will be presented with schedule search template, where he must select a semester and may specify several further options to refine search  
Several drop down bars will be populated with active selections from courses database  
External class inside a created package will be responsible for this, for the sake of simplicity and ease of schedulesearch.jsp code  
e.g. no queries will be run on this page.  
Next page will show user the parameters entered, and rows of classes that match the results for each class, or a notification that none were found  
Clicking on any class will bring user to course details page, where certain parameters are passed through the link to display further relevant course information  
Extra features:  
	-queries are run in separate Queries class  
	-user can see semester names and start + end dates for each semester in drop down bar
	-instructor name search is made case insensitive
	-utilizing lists and maps for ease of calling modules from Queries class  
	-last updated time will be changed for each semester  
	-clean handling of null results  
	-check resultsets for values, do not display   
	-parameters are sent to course details page by generating custom url for each respective course
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page 
             import="java.sql.*,
                     javax.sql.*,
                     java.io.*,
                     java.util.List,
                     java.util.ArrayList,
                     java.util.Map,
                     java.util.TreeMap,
                     javax.naming.InitialContext,
                     javax.naming.Context,
                     kubiakPackage.Queries" %>
   <%@include file="head.html"%>
   <%@include file="body.html"%>
<form method="get" action="scheduleresults.jsp">

    <div align="center">
      <p>Enter the professor's name, discipline, course number and/or days you wish to search.

      </p>
      <table id="search" summary="This table contains search options for the schedule of classes.">
       <caption>
  Schedule of Classes Search</caption>
	  <tbody>
        <tr>
          <th><label for="semester">Semester:</label></th>
          <td><select id="semester" name="semester">
    <%
	  Map<String,String> semesters = new TreeMap<String,String>(); //TreeMap remembers the order in which it is populated
      semesters = Queries.querySemesters(); //create a map (keys & values), populate it with values from querySemesters() method of class Queries
      for(Map.Entry<String,String> e : semesters.entrySet()){ // this will fill the drop down bar with appropriate semester names from database
        out.println("<option value='" + e.getKey() + "'>" 
                + e.getKey() + e.getValue() + "</option>"); //Will display semester names and start & end dates in drop bar
      }
%>
			  
          </select></td>
        </tr>
        <tr>
          <th>Dept:</th>
          <td><select name="department" size="1">
		  <option value="">Select All</option> <!-- default value for parameter will be empty string -->
<%
	  List<String> departments = new ArrayList<String>();
	  departments = Queries.queryDepartments();
	  for(String s : departments){ // populate drop down bar with departments
		  out.println("<option value=\"" + s + "\">" + s + "</option>");
	  }
%>
			</select></td>
        </tr>
        <tr>
          <th>Discipline:</th>
          <td><select name="discipline" size="1">
          <option value="">Select	All</option><!-- default value for parameter will be empty string -->
 <%
	  List<String> disciplines = new ArrayList<String>();
	  disciplines = Queries.queryDisciplines();
	  for(String s : disciplines){ // populate drop down bar with disciplines
		  out.println("<option value=\"" + s + "\">" + s + "</option>");
	  }
%>
			</select></td>
        </tr>
        <tr>
          <th>Division</th>
          <td>
            <label for="undergraduate">Undergraduate </label><input type="checkbox" id="undergraduate" value="U" name="div_undr" checked>
            <br>
            <label for="graduate">Graduate</label><input type="checkbox" id="gradaute" value="G" name="div_grad" checked>
          </td>
        </tr>
        <tr>
          <th><label for="number">Course number:</label></th>
          <td><input id="number" size="10" name="number" maxlength="5" type="text"></td>
        </tr>
        <tr>
          <th><label for="days">Days:</label></th>
          <td><select id="days" name="week">
              <option value="">Select	All </option>
              <option value="M">Mon </option>
              <option value="MTW">Mon-Tue-Wed </option>
              <option value="MTWF">Mon-Tue-Wed-Fri </option>
              <option value="MTWTH">Mon-Tue-Wed-Thr </option>
              <option value="MW">Mon-Wed </option>
              <option value="MWTH">Mon-Wed-Thr </option>
              <option value="MTH">Mon-Thr </option>
              <option value="T">Tue </option>
              <option value="TWF">Tue-Wed-Fri </option>
              <option value="TWTH">Tue-Wed-Thu </option>
              <option value="TTH">Tue-Thr </option>
              <option value="TF">Tue-Fri </option>
              <option value="W">Wed </option>
              <option value="TH">Thr </option>
              <option value="F">Fri </option>
              <option value="S">Sat </option>
              <option value="SU">Sun </option>
          </select></td>
        </tr>
        <tr>
          <th><label for="time">Time:</label></th>
          <td><select id="time" name="time_a_b">
              <option value="">Select	All </option>
              <option>before </option>
              <option>after </option>
              <option>around </option>
            </select>
            <select name="time">
              <option value="">Select	All </option>
              <option value="7">7:00am </option>
              <option value="8">8:00am </option>
              <option value="9">9:00am </option>
              <option value="10">10:00am </option>
              <option value="11">11:00am </option>
              <option value="12">12:00pm </option>
              <option value="13">1:00pm </option>
              <option value="14">2:00pm </option>
              <option value="15">3:00pm </option>
              <option value="16">4:00pm </option>
              <option value="17">5:00pm </option>
              <option value="18">6:00pm </option>
              <option value="19">7:00pm </option>
              <option value="20">8:00pm </option>
              <option value="21">9:00pm </option>
            </select>          </td>
        </tr>
        <tr>
          <th><label for="instructor">Instructor:</label></th>
          <td><input id="instructor" size="30" name="prof" type="text"></td>
        </tr>
      </tbody>
      </table>
    </div>
    <p align="center">
      <input value="Start Search" type="submit">
   </p>
 
</form>
   <%@include file="foot.html"%>
