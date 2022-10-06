<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function(){
		if(${!empty msgType}){
			$("#messageType").attr("class", "modal-content panel-warning");
			$("#myMessage").modal("show");
		}
	});
  </script>
  
</head>
<body>
 
<div class="container">
<jsp:include page="../common/header.jsp" />
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
  
  	<div class="panel-heading">Profile Image Register</div>
    
    <div class="panel-body">
    	<form method="post" action="${contextPath}/memImageUpdate.do" enctype="multipart/form-data">
    		<input type="hidden" name="memID" value="${mvo.memID}" />
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
				<tr>
					<td style="width:110px; vertical-align: middle;">ID</td>
					<td>${mvo.memID}</td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Image Upload</td>
					<td colspan=2>
						<span class="btn btn-default">
							Upload Your Image.<input type="file" name="memPROFILE" />
						</span>
					</td>
				</tr>
				<tr>
					<td colspan=2 style='text-align:left;'>
						<input type='submit' class='btn btn-primary btn-sm pull-right' value='Register'/>
					</td>
				</tr>
			</table>
		</form>
    </div>
    
    <!-- FAIL MESSAGE -->
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
    
    <div class="panel-footer">Spring(YJW)</div>
    
  </div>
</div>

</body>
</html>