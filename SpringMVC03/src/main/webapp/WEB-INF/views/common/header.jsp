<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />	<!-- contextPath가 m03하고 같은거 -->

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${contextPath}">Spring Good</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${contextPath}/">Home</a></li>
        <li><a href="boardMain.do">Go Board</a></li>
        <li><a href="#">Page 2</a></li>
      </ul>
      
      <c:if test="${empty mvo}">	<!-- 로그인을 하지 않은 경우 -->
	      <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
	          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Do Connect<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="${contextPath}/memLoginForm.do">Sign In</a></li>
	            <li><a href="${contextPath}/memJoin.do">Sign Up</a></li>
	          </ul>
	        </li>
	      </ul>
      </c:if>
      
      <c:if test="${!empty mvo}">	<!-- 로그인을 한 경우 -->
	      <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
	          <a class="dropdown-toggle" data-toggle="dropdown" href="#">Management Me<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="${contextPath}/memUpdateForm.do">My Page</a></li>
	            <li><a href="#">My Profile Picture</a></li>
	            <li><a href="${contextPath}/memLogout.do">Log Out</a></li>
	          </ul>
	        </li>
	      </ul> 
      </c:if>
      
    </div>
  </div>
</nav>