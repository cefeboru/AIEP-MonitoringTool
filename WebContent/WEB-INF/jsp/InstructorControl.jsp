<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/bbNG" prefix="bbNG"   %>
<%@taglib uri="/bbUI" prefix="bbUI"   %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

  		<bbNG:genericPage title="${ReportName}">
	<bbNG:pageHeader>
		<bbNG:pageTitleBar title="${ReportName}"/>
		<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</bbNG:pageHeader>
	
		<bbNG:form id="AdminForm" method = "POST" action = "${actionUrl}" enctype="application/x-www-form-urlencoded">
			<bbNG:dataCollection>

				<bbNG:step id="Filtros" title="Filtros" instructions= "">
					<label>Sede: </label>${HTMLHeadquarters}&emsp;
					<!--label>Modulo:&emsp;</label><input type="text" id="Modulo">&emsp;
					<label>A&ntilde;o:</label><select id="Anio">${YearsOptions}</select>&emsp;
					<label>Semestre:</label><input type="text" id="Semestre">&emsp;
					<label>Modalidad:</label><input type="text" id="Modalidad">&emsp;-->
					<input type="button" id ="Filter" value="Filtrar">
				</bbNG:step>
				<bbNG:stepSubmit showCancelButton= "False"><bbNG:stepSubmitButton id="SubmitButton" label="Submit"></bbNG:stepSubmitButton></bbNG:stepSubmit>
				

					<div id="InstructorData"></div>
					
					<div id="DownloadReport" style="display:none;">
					<img src="/webapps/lnoh-AIEPMTOOL-BBLEARN/Images/xls.png" style="width: 2%;">&nbsp;<label id="DownloadReport" style="font-size: 84%;font-Weight: bold;cursor: pointer;">Descargar Listado</label>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				<bbNG:stepSubmit showCancelButton= "False"><bbNG:stepSubmitButton id="SubmitButton" label="Submit"></bbNG:stepSubmitButton></bbNG:stepSubmit>
				
			</bbNG:dataCollection>
		</bbNG:form>

<script src="/webapps/lnoh-AIEPMTOOL-BBLEARN/AlertifyJS/alertify.min.js"></script>
<script src="/webapps/lnoh-AIEPMTOOL-BBLEARN/Jquery/jquery-2.1.3.min.js"></script>
<script src="/webapps/lnoh-AIEPMTOOL-BBLEARN/Jquery/jquery.bootgrid.min.js"></script>
<script type="text/javascript">

function goToPage(page){
	var SelectedHeadquarter = document.getElementById("Headquarters").value;
	
	document.getElementById("InstructorData").innerHTML = "Loading...";
	document.getElementById("DownloadReport").style.display = "none";
	$("#dvData").remove();
	
	$.ajax({
        type:'GET',
        url:'InstructorsInfo',
        data:{
     	   
     	   Sede: SelectedHeadquarter,
     	   Report: "Activity",
     	   Page: page,
        },
        datatype:'text',
        success:function(result){
            
	            document.getElementById("InstructorData").innerHTML = result;
	            
	            if(result.indexOf("<table ") != -1){
	            	
	            	document.getElementById("DownloadReport").style.display = "block";
	            }
    		},
    		error: function (jqXHR, exception) {
    			
    	        var msg = '';
    	        
    	        if (jqXHR.status === 0) {
    	            msg = 'Not connect.\n Verify Network.';
    	        } else if (jqXHR.status == 404) {
    	            msg = 'Requested page not found. [404]';
    	        } else if (jqXHR.status == 500) {
    	            msg = 'Internal Server Error [500].';
    	        } else if (exception === 'parsererror') {
    	            msg = 'Requested JSON parse failed.';
    	        } else if (exception === 'timeout') {
    	            msg = 'Time out error.';
    	        } else if (exception === 'abort') {
    	            msg = 'Ajax request aborted.';
    	        } else {
    	            msg = 'Uncaught Error.\n' + jqXHR.responseText;
    	        }
	       	    
    	        document.getElementById("InstructorData").innerHTML +=  "</br>" + msg;
    	    }
        });
}

$( document ).ready( function() {
	
	$('head').append('<link rel="stylesheet" href="/webapps/lnoh-AIEPMTOOL-BBLEARN/AlertifyJS/alertify.core.css" />');
	$('head').append('<link rel="stylesheet" href="/webapps/lnoh-AIEPMTOOL-BBLEARN/AlertifyJS/alertify.default.css" />');
	$('head').append('<link rel="stylesheet" href="/webapps/lnoh-AIEPMTOOL-BBLEARN/css/bootstrap.min.css"/>');
	$('head').append('<link rel="stylesheet" href="/webapps/lnoh-AIEPMTOOL-BBLEARN/css/jquery.bootgrid.min.css"/>');
	
	$(".stepHelp").remove();
	
	var ManageWindow = null;
	
	    var Top_Button = document.getElementById("top_SubmitButton");
	    var Bottom_Button = document.getElementById("bottom_SubmitButton");
	    
	    Top_Button.style.display = "none";
	    Bottom_Button.style.display = "none";
	    
	    var form = document.getElementsByTagName("form")[0];
	    form.onsubmit = function() { return false; };
	    
	    document.getElementsByClassName("submitStepBottom")[0].remove();
	    document.getElementById("content").appendChild(document.getElementById("dataCollectionContainer"));
	    document.getElementById("content").appendChild(document.getElementById("containerdiv"));
	    document.getElementById("dataCollectionContainer").id = "TableData";
	    
	    document.getElementById("Filter").onclick = function(){
	    	
	    	
	    	var SelectedHeadquarter = document.getElementById("Headquarters").value;
	    	document.getElementById("InstructorData").innerHTML = "Loading...";
	    	document.getElementById("DownloadReport").style.display = "none";
	    	$("#dvData").remove();
	    	
	    	$.ajax({
		           type:'GET',
		           url:'InstructorsInfo',
		           data:{
		        	   
		        	   Sede: SelectedHeadquarter,
		        	   Report: "Activity",
		        	   Page: 1,
		           },
		           datatype:'text',
		           success:function(result){
		               
			            document.getElementById("InstructorData").innerHTML = result;
			            
			            if(result.indexOf("<table ") != -1){
			            	
			            	document.getElementById("DownloadReport").style.display = "block";
			            }
		       		},
		       		error: function (jqXHR, exception) {
		       			
		       	        var msg = '';
		       	        
		       	        if (jqXHR.status === 0) {
		       	            msg = 'Not connect.\n Verify Network.';
		       	        } else if (jqXHR.status == 404) {
		       	            msg = 'Requested page not found. [404]';
		       	        } else if (jqXHR.status == 500) {
		       	            msg = 'Internal Server Error [500].';
		       	        } else if (exception === 'parsererror') {
		       	            msg = 'Requested JSON parse failed.';
		       	        } else if (exception === 'timeout') {
		       	            msg = 'Time out error.';
		       	        } else if (exception === 'abort') {
		       	            msg = 'Ajax request aborted.';
		       	        } else {
		       	            msg = 'Uncaught Error.\n' + jqXHR.responseText;
		       	        }
			       	    
		       	        document.getElementById("InstructorData").innerHTML +=  "</br>" + msg;
		       	    }
		           });
	    };
		document.getElementById("DownloadReport").onclick = function(){
			window.location = "https://aiepclone.blackboard.com/webapps/lnoh-AIEPMTOOL-BBLEARN/app/InstructorsControlReport"+
			"?Headquarter="+document.getElementById("Headquarters").value;			
	    };
});

</script>
<style type="text/css">
		.bootgrid-table{
			table-layout: auto !important;
		}
		#TableData{
			overflow: hidden;
			overflow-y: hidden;
			margin-left: 20px;
  			margin-right: 20px;
		}
		
		.dropdown-menu.pull-right {
		
		    margin-top: 0px !important;
		}
		#InstructorData tr,#InstructorData td,#InstructorData th{

			border: 1px solid #DDDDDD;
		}
</style>

	</bbNG:genericPage>
	
	