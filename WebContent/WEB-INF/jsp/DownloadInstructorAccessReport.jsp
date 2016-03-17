<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<% 
	response.setContentType("application/csv");
	response.setHeader("content-disposition","filename=AccesoDocentes_"+ request.getParameter("Sede") +"-"+ request.getParameter("Modalidad") +".xls"); // Filename
%>
<html><body>${HTMLTable}</body></html>