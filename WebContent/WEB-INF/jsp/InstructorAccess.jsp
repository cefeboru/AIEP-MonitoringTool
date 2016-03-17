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

				<bbNG:step id="Sedes" title="Filtros"
					instructions="Seleccione una Sede">
						Modalidad: ${HTMLModalidades} Sede: ${HTMLHeadquarters}<input
						type="button" id="Filter" value="Filtrar">
				</bbNG:step>
	
	
				<bbNG:stepSubmit showCancelButton="False">
					<bbNG:stepSubmitButton id="SubmitButton" label="Submit"></bbNG:stepSubmitButton>
				</bbNG:stepSubmit>
				
				<bbNG:step id="InstructorReport" title="Control de Accesso de Docentes" instructions= ".">
					<div id="InstructorData"></div>
					
					</div>
				</bbNG:step>
				<bbNG:stepSubmit showCancelButton= "False"><bbNG:stepSubmitButton id="SubmitButton" label="Submit"></bbNG:stepSubmitButton></bbNG:stepSubmit>
				
				<div id="DownloadReport" style="display:block;">
					<img src="/webapps/lnoh-AIEPMTOOL-BBLEARN/Images/xls.png" style="width: 2%;">&nbsp;<label id="DownloadReport" style="font-size: 84%;font-Weight: bold;cursor: pointer;">Descargar Listado</label>&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</bbNG:dataCollection>
		</bbNG:form>

<script src="/webapps/lnoh-AIEPMTOOL-BBLEARN/AlertifyJS/alertify.min.js"></script>
<script src="/webapps/lnoh-AIEPMTOOL-BBLEARN/Jquery/jquery-2.1.3.min.js"></script>
<script src="/webapps/lnoh-AIEPMTOOL-BBLEARN/Jquery/jquery.bootgrid.min.js"></script>
<script type="text/javascript">

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
	    	var SelectedModalidad = document.getElementById("Modalidades").value;
	    	
	    	document.getElementById("InstructorData").innerHTML = "";
	    	
	    	$.ajax({
		           type:'GET',
		           url:'InstructorsInfo',
		           data:{
		        	   
		        	   Sede: SelectedHeadquarter,
		        	   Report: "Access",
		        	   Modalidad: SelectedModalidad,
		           },
		           datatype:'text',
		           success:function(result){
		               
			            document.getElementById("InstructorData").innerHTML = result;
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
	    
	    var a = document.getElementById("TableData");
	    var b = a.parentNode;
	    b.insertBefore(document.getElementById("InstructorData"),a.nextSibling);
	    
	    var RowCount = -1;
	    var FetchSize = 100;
	    var NumRequests = 0;
	    var ReportTable = null;
	    var AllRequests = [];

	    
		document.getElementById("DownloadReport").onclick = function(){
			
			/*
			RowCount = -1;
		    FetchSize = 100;
		    NumRequests = 0;
		    ReportTable = null;
		    AllRequests = [];
			
			CreateReportDiv();
			GetReportRowCount();
			*/
			
			//window.location = "https://"+ window.location.hostname +"/webapps/lnoh-AIEPMTOOL-BBLEARN/app/DownloadInstructorAccessReport?HTMLTable=" + encodeURIComponent(document.getElementById("ReportData").innerHTML);
			
			window.location = "https://"+ window.location.hostname +"/webapps/lnoh-AIEPMTOOL-BBLEARN/app/DownloadInstructorAccessReport?Sede=" + document.getElementById("Headquarters").value + "&Modalidad=" + document.getElementById("Modalidades").value;
	    };
	    
	    function GetReportRowCount(){

	    	var xhr = new XMLHttpRequest();
	    	xhr.responseType = 'text';
	    	xhr.onload = function() {

	    		RowCount =  xhr.response;
	    		console.log(RowCount);
	    		
	    		if(FetchSize > RowCount){
	    			
	    			FetchReportData(0,RowCount);
	    		}
				else{
					
					FetchReportData(0,FetchSize);	
				}
	    	};

	    	xhr.open('GET', "https://"+ window.location.hostname +"/webapps/lnoh-AIEPMTOOL-BBLEARN/app/InstructorAccessGetRowCount?Sede=" + document.getElementById("Headquarters").value + "&Modalidad=" + document.getElementById("Modalidades").value);
	    	xhr.send();
	    }

	    function CreateReportDiv(){

	    	var temp = document.getElementById("ReportData");

	    	if(temp != null){

	    		temp.remove();
	    	}

	    	var FormTable = document.getElementById("InstructorData").cloneNode(true);
	    	FormTable.getElementsByTagName("nav")[0].remove();
	    	FormTable.id = "ReportData";
	    	var AllRows = Array.prototype.slice.call(FormTable.getElementsByTagName("tbody")[0].getElementsByTagName("tr"));
	    	AllRows.forEach(function(row){row.remove()});

	    	var ReportDiv = document.createElement("div");
	    	ReportDiv.id = "ReportData";
	    	ReportDiv.style.display = "none";
	    	ReportDiv.innerHTML = FormTable.innerHTML;

	    	document.body.appendChild(ReportDiv);

	    	document.getElementById("ReportData").getElementsByTagName("table")[0].id = "grid-basic-Report-Data"
	    }

	    function FetchReportData(FirstRow,LastRow){

	    	if(FirstRow < RowCount){

	    		if(LastRow <= RowCount){

	    			console.log("FirstRow: " + FirstRow + " LastRow: " + LastRow);
	    			NumRequests++;

	    			var xhr = new XMLHttpRequest();
	    			xhr.responseType = 'text';
	    			xhr.onload = function() {

	    				AllRequests.push(xhr.response);
	    				console.log(xhr.response.split("</tr>").length);
	    				FirstRow = LastRow;
	    				LastRow += FetchSize;

	    				if(LastRow > RowCount){

	    					LastRow = RowCount;
	    				}

	    				FetchReportData(FirstRow,LastRow);
	    			};

	    			xhr.open('GET', "https://"+ window.location.hostname +"/webapps/lnoh-AIEPMTOOL-BBLEARN/app/InstructorAccessReport?Sede=" + document.getElementById("Headquarters").value + "&Modalidad=" + document.getElementById("Modalidades").value + "&firstRow="+ FirstRow +"&lastRow=" + LastRow);
	    			xhr.send();
	    		}
	    		else{
	    			
	    			FirstRow = LastRow;
    				LastRow += FetchSize;

    				if(LastRow > RowCount){

    					LastRow = RowCount;
    				}

    				FetchReportData(FirstRow,LastRow);
	    		}
	    	}
	    	else{
	    		var num = 0;
	    		AllRequests.forEach(function(c){ num++; console.log(num); $("#grid-basic-Report-Data").find("tbody").append(c); console.log($("#grid-basic-Report-Data").find("tbody")[0].children.length)});
	    		window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#ReportData').html()));
	    		console.log("FINISHED REQUESTS: " + NumRequests);
	    	}
	    }

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
	
	