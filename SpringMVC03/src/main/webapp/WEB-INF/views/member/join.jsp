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
	
  	function registerCheck(){
  		var memID = $("#memID").val();
  		$.ajax({
  			url : "${contextPath}/memRegisterCheck.do",
  			type : "get",
  			data : {"memID" : memID},
  			success : function(result){
  				// 중복유무 체크(result에 따라서 : result가 1이면 사용가능, 0일시 중복)
  				alert(result);
  			},
  			error : function(){
  				alert("Error!");
  			}
  		});
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
		<form method="post" action="${contextPath}/memberRegister.do">
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
					<td colspan=2><input id='memAGE' name='memAGE' class="form-control" type='text' placeholder='Input your Age!' maxlength='20' /></td>
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
					<td colspan=3 style='text-align:right;'>
						<input type='submit' class='btn btn-primary' value='Register' />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="panel-footer">Spring(YJW)</div>
  </div>
</div>

</body>
</html>