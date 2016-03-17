<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<% 
	String Headquarter = (request.getParameter("Headquarter") == null ? "" : request.getParameter("Headquarter"));
	response.setContentType("application/csv");
	response.setHeader("content-disposition","filename=ControlDocentes.xls"); // Filename
%>
<html><body>${HTMLTable}</body></html>