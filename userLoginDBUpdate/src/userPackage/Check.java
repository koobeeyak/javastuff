package userPackage;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import javax.sql.*;
import java.io.*;
import javax.naming.InitialContext;
import javax.naming.Context;

/**
 * Servlet implementation class Check
 */
@WebServlet("/Check")
public class Check extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   Connection conn = null;
		   PrintWriter out = response.getWriter();
		   try
		   {
			  String driver = "oracle.jdbc.OracleDriver";
			  String url = "jdbc:oracle:thin:@localhost:1521:XE";
			  String myusername = "cis4160";
			  String mypassword = "cis4160";
			  
		      Class.forName(driver);
		     
		      conn = DriverManager.getConnection(url,myusername,mypassword);
		      
		      String user = request.getParameter("userId"); //the fields we take from previous page as part of request
		      String pass = request.getParameter("password");
		      String dept = request.getParameter("deptId");
		               
		      PreparedStatement stmt = null;
		      String query = "SELECT * FROM ADMIN_USER_SR "
		    		  + "WHERE USER_NAME = ? "
		    		  + "AND PASSWORD = ? "
		    		  + "AND DEPT = ?";
		      stmt = conn.prepareStatement(query);
		      stmt.setString(1,user); // we will construct query, check all three values against database
		      stmt.setString(2,pass);
		      stmt.setString(3,dept);
		      ResultSet rs = stmt.executeQuery();
		      if (rs.next()){ // if there is something in the result set, query returned a value and login info exists
		    	  HttpSession session = request.getSession();
		    	  session.setAttribute("user", user); // we will track this user's name across all accessed pages as part of attribute "user" in session
		    	  response.sendRedirect("update.jsp");
		      }
		      else{ //no such login info, redirect back to login page
		    	  response.sendRedirect("login.jsp");
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
	}

}
