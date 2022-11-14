<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/>
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
  
  	function goUpdate(){
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
	<div class="panel-heading">Modify My Info</div>
	
	<div class="panel-body">
		<form name="frm" method="post" action="${contextPath}/memUpdate.do">
		<input type="hidden" name="memID" id="memID" value="${mvo.member.memID}" />
		<input type="hidden" name="memPASSWORD" id="memPASSWORD" value="" />
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
				<tr>
					<td style="width:110px; vertical-align: middle;">ID</td>
					<td>${mvo.member.memID}</td>
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
					<td colspan=2><input id='memNAME' name='memNAME' class="form-control" type='text' placeholder='Input your name!' maxlength='20' value="${mvo.member.memNAME}" /></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Age</td>
					<td colspan=2><input id='memAGE' name='memAGE' class="form-control" type='number' placeholder='Input your Age!' maxlength='20' value="${mvo.member.memAGE}" /></td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Gender</td>
					<td colspan=2>
						<div class='form-group' style='text-align: center; margin: 0 auto;'>
							<div class='btn-group' data-toggle='buttons'>
								<label class="btn btn-primary <c:if test="${mvo.member.memGENDER eq 'male'}">active</c:if>">
									<input type='radio' id='memGENDER' name='memGENDER' autocomplete='off' value='male'
									<c:if test="${mvo.member.memGENDER eq 'male'}">checked</c:if> />Male
								</label>
								<label class="btn btn-primary <c:if test="${mvo.member.memGENDER eq 'female'}">active</c:if>">
									<input type='radio' id='memGENDER' name='memGENDER' autocomplete='off' value='female'
									<c:if test="${mvo.member.memGENDER eq 'female'}">checked</c:if> />Female
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:110px; vertical-align: middle;">Email</td>
					<td colspan=2><input  id='memEMAIL' name='memEMAIL' class="form-control" type='text' placeholder='Input your Email!' maxlength='20' value="${mvo.member.memEMAIL}"/></td>
				</tr>
				
				<!-- MVC05에서 추가 : 선택한 권한 출력하기 -->
				<tr>
					<td style="width:110px; vertical-align: middle;">사용자 권한</td>
					<td colspan=2>
						<input type="checkbox" name="authList[0].auth" value="ROLE_USER" 
							<c:forEach items="${mvo.member.authList}" var="authVO" >
								<c:if test="${authVO.auth eq 'ROLE_USER'}">
									checked
								</c:if>
							</c:forEach>
						/> ROLE_USER
						
						<input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER" 
							<c:forEach items="${mvo.member.authList}" var="authVO" >
								<c:if test="${authVO.auth eq 'ROLE_MANAGER'}">
									checked
								</c:if>
							</c:forEach>
						/> ROLE_MANAGER
						<input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN" 
							<c:forEach items="${mvo.member.authList}" var="authVO" >
								<c:if test="${authVO.auth eq 'ROLE_ADMIN'}">
									checked
								</c:if>
							</c:forEach>
						/> ROLE_ADMIN
					</td>
				</tr>
				
				<tr>
					<td colspan=3 style='text-align:left;'>
						<span id="passMessage" style="color:red;"></span>
						<input type='button' class='btn btn-primary btn-sm pull-right' value='Update' onclick="goUpdate()" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
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