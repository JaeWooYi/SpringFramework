<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring Framework03</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
    
	$(document).ready(function(){
		if(${!empty msgType}){
			$("#messageType").attr("class", "modal-content panel-success");
			$("#myMessage").modal("show");
		}
	});
	
  </script>
  
</head>
<body>
  
<div class="container">
<jsp:include page="common/header.jsp" />

  <!-- Not Login -->
  <c:if test="${empty mvo}">
  	<h2>Spring MVC03</h2>
  </c:if>  
  <!-- Login -->
  <c:if test="${!empty mvo}">
  	<c:if test="${mvo.memPROFILE eq ''}">
  		<img src="${contextPath}/resources/images/person.png" style="width:50px; height:50px;"/>
  	</c:if>
  	<c:if test="${mvo.memPROFILE != ''}">
  	<%-- <c:if test="${mvo.memProfile ne ''}"> --%>		<!-- !=말고 ne로 해도 된다(jstl문법) -->
  		<img src="${contextPath}/resources/upload/${mvo.memPROFILE}" style="width:50px; height:50px; margin-bottom:5px;"/>
  	</c:if>
  	<label>${mvo.memNAME} visit my board.</label>
  </c:if>
  
  <div class="panel panel-default">
  
  	<div class="panel-heading">
  		<img src="${contextPath}/resources/images/SpringImage.png" style="width:100%; height:500px;" />
  	</div>
  	
    <div class="panel-body">
    	<ul class="nav nav-tabs">
		  <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
		  <li><a data-toggle="tab" href="#menu1">Board</a></li>
		  <li><a data-toggle="tab" href="#menu2">Notice</a></li>
		</ul>
		
		<div class="tab-content">
		  <div id="home" class="tab-pane fade in active">
		    <h3>HOME</h3>
		    <p>Some content.</p>
		  </div>
		  <div id="menu1" class="tab-pane fade">
		    <h3>Board</h3>
		    <p>Some content in menu 1.</p>
		  </div>
		  <div id="menu2" class="tab-pane fade">
		    <h3>Notice</h3>
		    <p>Some content in menu 2.</p>
		  </div>
		</div>
    </div>
    
    <div class="panel-footer">Spring(YJW)</div>
    
  </div>
</div>

	<!-- Modal (Fail Message)-->
	<div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content panel-info" id="messageType">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>	<!-- &times;	-> 이게 x야 -->
	        <h4 class="modal-title">${msgType}</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg}</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
	  </div>
	</div>

</body>
</html>
    