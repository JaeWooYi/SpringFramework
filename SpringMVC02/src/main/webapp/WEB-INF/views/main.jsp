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
  }
  
  function goForm(){
	  $("#view").css("display", "none");	// 감추기
	  $("#wform").css("display", "block");	// 보이기
  }
  
  function goList(){
	  $("#view").css("display", "block");
	  $("#wform").css("display", "none");
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
    	<form action="boardInsert.do" method="post">
	    	<table class="table">
	    		<tr>
	    			<td>Title</td>
	    			<td><input type="text" name="title" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td>Content</td>
	    			<td><textarea rows="5" class="form-control" name="content"></textarea></td>
	    		</tr>
	    		<tr>
	    			<td>Writer</td>
	    			<td><input type="text" name="writer" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="submit" class="btn btn-success btn-sm">Registration</button>
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
