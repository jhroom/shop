<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(!"employee".equals(session.getAttribute("user")) ) {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?errorMsg=Invalid Acess");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>관리자페이지</h3>
	<div><!-- 상단메뉴 -->
		<ul>
		<li><a href="<%=request.getContextPath() %>/admin/employee/employeeList.jsp">사원관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/goods/adminGoodsList.jsp">상품관리페이지</a></li><!-- 상품목록/등록/수정 -->
		<li><a href="<%=request.getContextPath() %>/admin/adminOrderList.jsp">주문관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/customer/customerList.jsp">고객관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp">공지관리페이지</a></li>
		</ul>
	</div>
</body>
</html>