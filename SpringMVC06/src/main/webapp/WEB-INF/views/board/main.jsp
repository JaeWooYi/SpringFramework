<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC03</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
  /* csrf토큰! */
  var csrfHeaderName = "${_csrf.headerName}";
  var csrfTokenValue = "${_csrf.token}";
  
  $(document).ready(function(){
	  loadList();
  });
  
  function loadList(){
	  // 서버와 통신 : 게시판 리스트 가져오기
	  $.ajax({
		  url : "board/all",
		  type : "get",
		  dataType : "json",
		  success : makeView,
		  error : function(){alert("error!!!")}
	  });
  }
  
  function makeView(data){	/* data -> [{},...{}] 형식으로 */
	  /* alert(data); */	/* 데이터 확인 */
	  var listHtml = "<table class = 'table table-bordered'>";
	  listHtml += "<tr>";
	  listHtml += "<td>Num</td>";
	  listHtml += "<td>Title</td>";
	  listHtml += "<td>Writer</td>";
	  listHtml += "<td>Date</td>";
	  listHtml += "<td>Cnt</td>";
	  listHtml += "</tr>";
	  $.each(data, function(index, obj){
		  listHtml += "<tr>";
		  listHtml += "<td>"+ obj.idx +"</td>";
		  listHtml += "<td id='t"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+ obj.title +"</a></td>";
		  listHtml += "<td>"+ obj.writer +"</td>";
		  listHtml += "<td>"+ obj.indate.split(' ')[0] +"</td>";
		  listHtml += "<td id='cnt"+obj.idx+"'>"+ obj.count +"</td>";
		  listHtml += "</tr>";
		  
		  listHtml += "<tr id='c"+ obj.idx +"' style='display:none'>";
		  listHtml += "<td>Content!</td>";
		  listHtml += "<td colspan='4'>Content!";
		  /* listHtml += "<textarea id='ta"+obj.idx+"' readonly='readonly' rows='7' class ='form-control'>"+ obj.content +"</textarea>"; */
		  listHtml += "<textarea id='ta"+obj.idx+"' readonly='readonly' rows='7' class ='form-control'></textarea>";
		
		  if("${mvo.member.memID}"==obj.memID){
			  listHtml += "<br/>";
			  listHtml += "<span id='up"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>Modify</button></span>&nbsp";
			  listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>Delete</button>";
		  }else{
			  listHtml += "<br/>";
			  listHtml += "<span id='up"+obj.idx+"'><button disabled class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>Modify</button></span>&nbsp";
			  listHtml += "<button disabled class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>Delete</button>";
		  }
		  
		  listHtml += "</td>";
		  listHtml += "</tr>";
	  });
	  
	  // 로그인을 해야 글쓰기가 보여야함
	  if(${!empty mvo.member}){
	  listHtml += "<tr>";
	  listHtml += "<td colspan='5'>";
	  listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>Board Write!</button>";
	  listHtml += "</td>";
	  listHtml += "</tr>";
	  }
	  
	  listHtml += "</talbe>";
	  $("#view").html(listHtml);
	  
	  $("#view").css("display", "block");
	  $("#wform").css("display", "none");
  }
  
  function goForm(){
	  $("#view").css("display", "none");	// 감추기
	  $("#wform").css("display", "block");	// 보이기
  }
  
  function goList(){
	  $("#view").css("display", "block");
	  $("#wform").css("display", "none");
  }
  
  function goInsert(){
	  /* var title = $("#title").val();
	  var content = $("#content").val();
	  var writer = $("#writer").val(); */	/* 개별로 한개씩 가지고와도 되지만!! 밑에 더 편리한 방범(한번에 가져오기) */
	  
	  var fData = $("#frm").serialize();	/* form안에 모든 파라메터를 직렬화 할수있어 serialize함수를 통해서 */
	  /* alert(fData); */
	  
	  $.ajax({
		  /* url : "boardInsert.do", 	기존 */
		  url : "board/new",
		  type : "post", 
		  data : fData,
		  
		  /* 이거로 맨위에 글로벌 변수를 보내준다. */
		  beforeSend: function(xhr){
			  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			  },
		  
		  success : loadList,
		  error : function(){
			  alert("error");
			  }
	  });
	 
	  /* fData = fData.val(""); */	/* 이렇게하면 안되네.... */
	  /* $("#title").val("");
	  $("#content").val("");
	  $("#writer").val(""); */
	  /* 취소버튼을 누르면 클리어가 되자나 그거로 해도 되? */
	  $("#fclear").trigger("click");
  }
  
  function goContent(idx){
	  if($("#c"+idx).css("display")=="none"){
		
		$.ajax({
			url : "board/"+idx,
			type : "get",
			/* data : {"idx" : idx}, */
			dataType : "json",
			success : function(data){
				$("#ta" + idx).val(data.content);
			},
			error : function(){
				alert("error!!");
			}
		});
		  
	  	$("#c"+idx).css("display", "table-row")	// 보이게!!
	  	$("#ta"+idx).attr("readonly", true);
	  }else{
		$("#c"+idx).css("display", "none")	// 안보이게!!
		
		$.ajax({
			url : "board/count/"+idx,
			type : "put",	/* put은 일종의 post방식 그래서 아래 beforeSend가 필요한거야, 아래 수정과 삭제에도 넣어주자! */
			beforeSend: function(xhr){
				  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				  },
			/* data : {"idx" : idx}, */
			dataType : "json",
			success : function(data){
				$("#cnt"+idx).html(data.count);
				/* $("#cnt"+idx).text(data.count); */ /* 로 해도 된다 */
			},
			error : function(){
				alert("error!!");
			},
		});
		
	  }
  }
  
  function goDelete(idx){
	  $.ajax({
		  url : "board/"+idx,
		  /* type : "get", */
		  type : "delete",
		  /* data : {"idx" : idx}, */
		  beforeSend: function(xhr){
			  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			  },
		  success : loadList,
		  error : function(){
			  alert("error!!");
		  }
	  });
  }
  
  function goUpdateForm(idx){
	  $("#ta"+idx).attr("readonly", false);
	  
	  var title = $("#t"+idx).text();
	  var newInput = "<input id='nt"+idx+"' type='text' class='form-control' value='"+title+"' />"
	  $("#t"+idx).html(newInput);
	  
	  var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>Update!</button>"
	  $("#up"+idx).html(newButton);
  }
  
  function goUpdate(idx){
	  var newTitle = $("#nt"+idx).val();
	  var newContent = $("#ta"+idx).val();
	  $.ajax({
		 url : "board/update",
		 type : "put",
		 contentType : 'application/json;charset=utf-8',
		 data : JSON.stringify({"idx":idx, "title":newTitle, "content":newContent}),
		 beforeSend: function(xhr){
			  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			  },
		 success : loadList,
		 error : function(){
			 alert("error");
		 }
	  });
  }
  
  </script>
  
</head>
<body>
 
<div class="container">
<jsp:include page="../common/header.jsp" />
  <h3>Good Spring Board</h3>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    
    <div class="panel-body" id="view">
    	HI
    </div>
    
    <div class="panel-body" id="wform" style="display:none" >
    	<form id="frm">
    		<input type="hidden" value="${mvo.member.memID}" name="memID" id="memID" />
	    	<table class="table">
	    		<tr>
	    			<td>Title</td>
	    			<td><input type="text" id="title" name="title" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td>Content</td>
	    			<td><textarea rows="5" id="content" class="form-control" name="content"></textarea></td>
	    		</tr>
	    		<tr>
	    			<td>Writer</td>
	    			<td><input type="text" id="writer" name="writer" class="form-control" readonly="readonly" value="${mvo.member.memID}"/></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">Registration</button>
	    				<button type="reset" class="btn btn-warning btn-sm" id="fclear">Cancle</button>
	    				<button type="button" class="btn btn-info btn-sm" onclick="goList()" >Go List</button>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
    </div>
    
    <div class="panel-footer">Inflearn_Spring1_JW</div>
  </div>
</div>

</body>
</html>
