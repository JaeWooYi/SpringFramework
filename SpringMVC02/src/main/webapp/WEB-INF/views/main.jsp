<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC02</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function(){
	  loadList();
  });
  
  function loadList(){
	  // 서버와 통신 : 게시판 리스트 가져오기
	  $.ajax({
		  url : "boardList.do",
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
		  listHtml += "<td>"+ obj.title +"</td>";
		  listHtml += "<td>"+ obj.writer +"</td>";
		  listHtml += "<td>"+ obj.indate +"</td>";
		  listHtml += "<td>"+ obj.count +"</td>";
		  listHtml += "</tr>";
	  });
	  
	  listHtml += "<tr>";
	  listHtml += "<td colspan='5'>";
	  listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>Board Write!</button>";
	  listHtml += "</td>";
	  listHtml += "</tr>";
	  
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
		  url : "boardInsert.do",
		  type : "post", 
		  data : fData,
		  success : loadList,
		  error : function(){
			  alert("error");
			  }
	  });
	 
	  /* fData = fData.val(""); */	/* 이렇게하면 안되네.... */
	  $("#title").val("");
	  $("#content").val("");
	  $("#writer").val("");
  }
  </script>
  
</head>
<body>
 
<div class="container">
  <h2>Good Spring</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    
    <div class="panel-body" id="view">
    	HI
    </div>
    
    <div class="panel-body" id="wform" style="display:none" >
    	<form id="frm">
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
	    			<td><input type="text" id="writer" name="writer" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">Registration</button>
	    				<button type="reset" class="btn btn-warning btn-sm">Cancle</button>
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
