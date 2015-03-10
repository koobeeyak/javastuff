package kubiakPackage;

import java.sql.*;
import javax.sql.*;
import java.io.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.TreeMap;
import javax.naming.InitialContext;
import javax.naming.Context;


public class Queries {
	private static Connection conn = null;
	private static String driver = "oracle.jdbc.OracleDriver";
	private static String url = "jdbc:oracle:thin:@localhost";
	private static String myusername = "USER";
	private static String mypassword = "PSWRD";
    public static Map<String,String> querySemesters(){ // We want the semester name as a key, and we will build values of start and end dates to show to user
       Map<String,String> semesters = new TreeMap<String,String>(); //TreeMap remembers the order in which it is populated
 	   try
 	   {
 	      Class.forName(driver);
 	      conn = DriverManager.getConnection(url,myusername,mypassword);
 	               
 	      Statement stmt = conn.createStatement();

 	      ResultSet rs = stmt.executeQuery("SELECT * FROM SEMESTER_SR");
 	      String startAndEndDate = null;
 	      while (rs.next()){ //taking a substring of dates will get rid of 00:00:00 hours
 	    	  startAndEndDate = " Start Date: " + rs.getString(2).substring(0, 10) + 
 	    			  ", End Date: " + rs.getString(3).substring(0,10);
 	    	  semesters.put(rs.getString(4),startAndEndDate);
 	      }

 	   }
 	   catch(SQLException e)
 	   {
 		  // Is connection made?
 		  // Is query set up properly?
 	      System.out.println("SQLException: " + e.getMessage() + "<BR>");
 	      while((e = e.getNextException()) != null)
 	         System.out.println(e.getMessage() + "<BR>");
 	   }
 	   catch(ClassNotFoundException e)
 	   {
 	      System.out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
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
 	   return semesters;
    }
    public static List<String> queryDepartments(){
       List<String> departments = new ArrayList<String>();
  	   try
  	   {
  	      Class.forName(driver);
  	      conn = DriverManager.getConnection(url,myusername,mypassword);
  	               
  	      Statement stmt = conn.createStatement();

  	      ResultSet rs = stmt.executeQuery("SELECT * FROM DEPT_SR ORDER BY DEPT_NAME ASC");
  	      while (rs.next()){
  	    	  departments.add(rs.getString(2));
  	      }

  	   }
  	   catch(SQLException e)
  	   {
  		  // Is connection made?
  		  // Is query set up properly?
  	      System.out.println("SQLException: " + e.getMessage() + "<BR>");
  	      while((e = e.getNextException()) != null)
  	         System.out.println(e.getMessage() + "<BR>");
  	   }
  	   catch(ClassNotFoundException e)
  	   {
  	      System.out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
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
  	   return departments;
    }
    public static List<String> queryDisciplines(){
        List<String> disciplines = new ArrayList<String>();
   	   try
   	   {
   	      Class.forName(driver);
   	      conn = DriverManager.getConnection(url,myusername,mypassword);
   	               
   	      Statement stmt = conn.createStatement();

   	      ResultSet rs = stmt.executeQuery("SELECT * FROM DISCIPLINE_SR ORDER BY DISCIPLINE_NAME ASC");
   	      while (rs.next()){
   	    	  disciplines.add(rs.getString(1));
   	      }

   	   }
   	   catch(SQLException e)
   	   {
   		  // Is connection made?
   		  // Is query set up properly?
   	      System.out.println("SQLException: " + e.getMessage() + "<BR>");
   	      while((e = e.getNextException()) != null)
   	         System.out.println(e.getMessage() + "<BR>");
   	   }
   	   catch(ClassNotFoundException e)
   	   {
   	      System.out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
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
   	   return disciplines;
     }
}
