<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(!"employee".equals(session.getAttribute("user")) ) {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?errorMsg=Invalid Acess");
		return;
	}
%>


<%@ include file="../theme/header.jsp" %>
	<div>
		<%@ include file="managementList.jsp" %>
	</div>
<%@ include file="../theme/footer.jsp" %>