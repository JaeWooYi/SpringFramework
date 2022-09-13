<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
 
<div class="container">
  <h2>Good Spring</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    
    <div class="panel-body">
    	<table class="table talbe-bordered table-hover">
    		<tr>
    			<td>Num</td>
    			<td>Title</td>
    			<td>Writer</td>
    			<td>Date</td>
    			<td>Count</td>
    		</tr>
    		<c:forEach var="vo" items="${list}">
    			<tr>
	    			<td>${vo.idx}</td>
	    			<td><a href="boardContent.do?idx=${vo.idx}">${vo.title}</a></td>
	    			<td>${vo.writer}</td>
	    			
	    			<%-- <td>${vo.indate}</td> --%>
	    			<!-- 위에꺼 시분초 뺄까? -->
	    			<td>${fn:split(vo.indate," ")[0]}</td>
	    			
	    			<td>${vo.count}</td>
    			</tr>	
    		</c:forEach>
    	</table>
    	
    	<a href="boardForm.do" class="btn btn-primary btn-sm">Write</a>
    	
    </div>
    
    <div class="panel-footer">Inflearn_Spring1_JW</div>
  </div>
</div>

</body>
</html>
