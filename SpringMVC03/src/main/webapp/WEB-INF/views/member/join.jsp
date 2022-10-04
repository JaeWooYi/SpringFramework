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
  
  	function registerCheck(){
  		var memID = $("#memID").val();
  		$.ajax({
  			url : "${contextPath}/memRegisterCheck.do",
  			type : "get",
  			data : {"memID" : memID},
  			success : function(result){
  				// 중복유무 체크(result에 따라서 : result가 1이면 사용가능, 0일시 중복)
  				/* alert(result); */
  				if(result == 1){
  					$("#checkMessage").html("Id available!");
  					$("#checkType").attr("class", "modal-content panel-success");
  				}else {
  					$("#checkMessage").html("Id not available..");
  					$("#checkType").attr("class", "modal-content panel-warning");
  				}
  				$("#myModal").modal("show");
  			},
  			error : function(){
  				alert("Error!");
  			}
  		});
  	}
  	
  	function passwordCheck(){
  		var memPASSWORD1 = $("#memPASSWORD1").val();
  		var memPASSWORD2 = $("#memPASSWORD2").val();
  		if(memPASSWORD1 != memPASSWORD2){
  			$("#passMessage").html("The passwords do not match each other.");
  		}else{
  			$("#passMessage").html("");
  			$("#memPASSWORD").val(memPASSWORD1);
  		}
  	}
  
  	function goInsert(){
  		var memAGE = $("#memAGE").val();
  		if(memAGE == null || memAGE == "" || memAGE == 0){
  			alert("Input Age..");
  			return false;
  		}
  		document.frm.submit();	// 전송
  	}
  	
  </script>
  
</head>
<body>
 
<div class="container">
<jsp:include page="../common/header.jsp" />
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
	<div class="panel-heading">Sign Up</div>
	
	<div class="panel-body">
		<form name="frm" method="post" action="${contextPath}/memberRegister.do">
		<input type="hidden" name="memPASSWORD" id="memPASSWORD" value="" />
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
				<tr>
					<td style="width:110px; vertical-align: middle;">ID</td>
					<td><input id='memID' name='memID' class="form-control" type='text' placeholder='Input desired ID!' maxlength='20' /></td>
					<td style="width:110px; vertical-align: middle;"><button type="button" onclick="registerCheck()" class="btn btn-primary btn-sm">Overlap Check</button></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Password</td>
					<td colspan=2><input onkeyup="passwordCheck()" id='memPASSWORD1' name='memPASSWORD1' class="form-control" type='password' placeholder='Input desired password!' maxlength='20' /></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Password Check</td>
					<td colspan=2><input onkeyup="passwordCheck()" id='memPASSWORD2' name='memPASSWORD2' class="form-control" type='password' placeholder='Confirm Your Password!' maxlength='20' /></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Name</td>
					<td colspan=2><input id='memNAME' name='memNAME' class="form-control" type='text' placeholder='Input your name!' maxlength='20' /></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Age</td>
					<td colspan=2><input id='memAGE' name='memAGE' class="form-control" type='number' placeholder='Input your Age!' maxlength='20' /></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Gender</td>
					<td colspan=2>
						<div class='form-group' style='text-align: center; margin: 0 auto;'>
							<div class='btn-group' data-toggle='buttons'>
								<label class='btn btn-primary active'>
									<input type='radio' id='memGENDER' name='memGENDER' autocomplete='off' value='male' checked/>Male
								</label>
								<label class='btn btn-primary'>
									<input type='radio' id='memGENDER' name='memGENDER' autocomplete='off' value='female'/>Female
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Email</td>
					<td colspan=2><input  id='memEMAIL' name='memEMAIL' class="form-control" type='text' placeholder='Input your Email!' maxlength='20' /></td>
				</tr>
				<tr>
					<td colspan=3 style='text-align:left;'>
						<span id="passMessage" style="color:red;"></span>
						<input type='button' class='btn btn-primary btn-sm pull-right' value='Register' onclick="goInsert()" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- 다이얼로그 창(모달창) -->
	<!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content" id="checkType">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>	<!-- &times;	-> 이게 x야 -->
	        <h4 class="modal-title">Message Confirm.</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
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
	
	<div class="panel-footer">Spring(YJW)</div>
  </div>
</div>

</body>
</html>