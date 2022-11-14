<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />	<!-- contextPath가 m03하고 같은거 -->

<!-- 인증이 끝난 후 써먹을 변수 -->
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/>

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}"
	function logout(){
		$.ajax({
			url : "${contextPath}/logout",
			type : "post",
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			success : function(){
				location.href = "${contextPath}/"
			},
			error : function(){
				alert("error!!!");
			}
		});
	}
</script>

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
      
      <%-- <c:if test="${empty mvo}"> --%>	<!-- 로그인을 하지 않은 경우 -->
      <security:authorize access="isAnonymous()">	<!-- 시큐리티로 바꿨기때문에 수정을 해줘야 해(위에꺼 바꾼거야) 아래도 동일하게 바꿔줘 -->
	      <ul class="nav navbar-nav navbar-right"> 
            <li><a href="${contextPath}/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> Sign In</a></li>
            <li><a href="${contextPath}/memJoin.do"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
	      </ul>
	  </security:authorize>
      <%-- </c:if> --%>
      
      <security:authorize access="isAuthenticated()">	<!-- 로그인을 한 경우 -->
	      <ul class="nav navbar-nav navbar-right">
            <li><a href="${contextPath}/memUpdateForm.do"><span class="glyphicon glyphicon-cog"></span> My Page</a></li>
            <li><a href="${contextPath}/memImageForm.do"><span class="glyphicon glyphicon-picture"></span> My Image Picture</a></li>
            <li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
            
			<!-- Login -->
				<!-- mvo.member.memPROFILE : Memberuser에 Member member에 member를 찍어준거야 -->
				<c:if test="${empty mvo.member.memPROFILE}">	<!-- 프로필이 있던지 없던지 -->
					<li><img class="img-circle" src="${contextPath}/resources/images/person.png" style="width:50px; height:50px;"/>
				</c:if>
				<c:if test="${!empty mvo.member.memPROFILE}">	<!-- 프로필이 있던지 없던지 -->
					<li><img class="img-circle" src="${contextPath}/resources/upload/${mvo.member.memPROFILE}" style="width:50px; height:50px;"/>
				</c:if>
					${mvo.member.memNAME}님
					(
					<security:authorize access="hasRole('ROLE_USER')">
					U,
					</security:authorize>
					<security:authorize access="hasRole('ROLE_MANAGER')">
					M,
					</security:authorize>
					<security:authorize access="hasRole('ROLE_ADMIN')">
					A
					</security:authorize>
					) 환영 합니다.
					</li>
            
	      </ul>
      </security:authorize>
      
    </div>
  </div>
</nav>