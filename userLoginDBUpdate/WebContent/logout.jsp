<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logged Out</title>
</head>
<body>
<%
	if (session != null) //This time, see if session exists. If it does, we invalidate, thus "logging user out"
		session.invalidate();
%>
<h3>Your session has been terminated.</h3>
<p>Make sure that you close the browser to ensure no personal data is kept on the computer.</p>
<p align="left">
     <b>
     <a href="login.jsp"><font size="5">Login again</font></a> </b>&nbsp;<br>

</body>
</html>