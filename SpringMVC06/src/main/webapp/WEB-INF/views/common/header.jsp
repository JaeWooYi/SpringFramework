<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />	<!-- contextPath가 m03하고 같은거 -->


<!-- <nav class="navbar navbar-inverse" style="margin-top : 10px;"> -->	<!-- 검정색 -->
<nav class="navbar navbar-default" style="margin-top : 10px;">	<!-- 약간회색 -->
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
        <!-- <li><a href="#">Page 2</a></li> -->
      </ul>
      
      <c:if test="${empty mvo}">	<!-- 로그인을 하지 않은 경우 -->
	      <ul class="nav navbar-nav navbar-right"> 
            <li><a href="${contextPath}/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> Sign In</a></li>
            <li><a href="${contextPath}/memJoin.do"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
	      </ul>
      </c:if>
      
      <c:if test="${!empty mvo}">	<!-- 로그인을 한 경우 -->
	      <ul class="nav navbar-nav navbar-right">
            <li><a href="${contextPath}/memUpdateForm.do"><span class="glyphicon glyphicon-cog"></span> My Page</a></li>
            <li><a href="${contextPath}/memImageForm.do"><span class="glyphicon glyphicon-picture"></span> My Image Picture</a></li>
            <li><a href="${contextPath}/memLogout.do"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
            
			<!-- Login -->
			<c:if test="${!empty mvo}">
				<%-- <c:if test="${mvo.memPROFILE eq ''}"> --%>
				<c:if test="${empty mvo.memPROFILE}">	<!-- 이게 위에보다 더 정확한 null체크야 -->
					<li><img class="img-circle" src="${contextPath}/resources/images/person.png" style="width:50px; height:50px;"/>${mvo.memNAME} welcome!!(
					<c:forEach var="authVO" items="${mvo.authList}" >
						<c:if test="${authVO.auth eq 'ROLE_USER'}">(User)</c:if>
						<c:if test="${authVO.auth eq 'ROLE_MANAGER'}">(Manger)</c:if>
						<c:if test="${authVO.auth eq 'ROLE_ADMIN'}">(Admin)</c:if>
					</c:forEach>
					)</li>
				</c:if>
				<c:if test="${!empty mvo.memPROFILE}">
			    <%-- <c:if test="${mvo.memProfile ne ''}"> --%>		<!-- !=말고 ne로 해도 된다(jstl문법) -->
					<li><img class="img-circle" src="${contextPath}/resources/upload/${mvo.memPROFILE}" style="width:50px; height:50px; margin:2px;"/>${mvo.memNAME} welcome!!(
					<c:forEach var="authVO" items="${mvo.authList}" >
						<c:if test="${authVO.auth eq 'ROLE_USER'}">(User)</c:if>
						<c:if test="${authVO.auth eq 'ROLE_MANAGER'}">(Manger)</c:if>
						<c:if test="${authVO.auth eq 'ROLE_ADMIN'}">(Admin)</c:if>
					</c:forEach>
					)</li>
				</c:if>
				<%-- <label>${mvo.memNAME} visit my board.</label> --%>
			</c:if>            
            
	      </ul>
      </c:if>
      
    </div>
  </div>
</nav>