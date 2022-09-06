<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  <h2>Panel Heading</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    
    <div class="panel-body">
    
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
