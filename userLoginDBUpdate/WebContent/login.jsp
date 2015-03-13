<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logged Out</title>
</head>
<BODY BGCOLOR="white">
<center>
  	 <H1><font color="red">User ID and Password does not match!</font></H1>
<H2>Please Enter your User ID and Password</H2>
<br>
 
<FORM ACTION="/Kubiak_Philip/Check"><!-- servlet to check user input in ADMIN_USR_SR database -->
  User  ID: 
  <INPUT TYPE="TEXT" NAME="userId" VALUE=""><p>
  Password:
  <INPUT TYPE="password" NAME="password" VALUE=""><p>
  <label>Department ID:
	<select name="deptId">
	<option selected="selected">Select Dept </option>
	<option value="1">Registrar</option>
	<option value="2">BCTC</option>
	<option value="3">Zicklin</option>

	</select>
  </label>
  <P>
  <INPUT TYPE="SUBMIT" value="Log In"> <!-- Press this button to submit form -->
</FORM>
</CENTER>
</BODY>


