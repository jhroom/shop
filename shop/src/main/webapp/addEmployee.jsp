<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<%
		if(request.getParameter("errorMsg") != null) {
	%>
			<p><%=request.getParameter("errorMsg") %></p>
	<%
		}
	%>
	<h3>직원 회원가입 폼</h3>
	<!-- id check form -->
	<form action="<%=request.getContextPath() %>/idCheckAction.jsp" method="post" id="idForm">
		<input type="hidden" name="employee"  value="addEmployee" >
		<div>
			아이디중복검사
			<input type="text" name="checkId" id="unckeckId">
			<button type="button" id="duplbtn" >중복확인</button>
		</div>
	</form>
	
	<!-- 직원가입 form -->
	<%
		String ckeckedId = "";
		if( request.getParameter("checkedId") != null) {
			ckeckedId = request.getParameter("checkedId");
		}
	%>
	
	<form action="<%=request.getContextPath() %>/addEmployeeAction.jsp" method="post" id="form">
			
			
			<div>employee id
				<input type="text" name="employeeId" id="id" readonly="readonly" value="<%=ckeckedId%>" ></div>
				
			<div>employee pass
			
				<input type="password" name="employeePass" id="pass"></div>
				
			<div>employee name
				<input type="text" name="employeeName" id="name"></div>
			
			<button type="button" id="btn">회원가입</button>
	</form>

</body>
<script>
	// 회원가입 빈칸검사
	$('#duplbtn').click(function(){
		
		if( $('#unckeckId').val().length < 4 ) {
			alert('아이디를 4글자 이상 입력하시오');
			$('#unckeckId').focus();
			return;
		} else {
			idForm.submit();
		}
	});
	
	$('#btn').click(function(){
		
		if( $('#id').val() == "" ) {
			alert('아이디를 입력해주세요');
			$('#unckeckId').focus();
			return;
		}
		else if( $('#pass').val().length < 4 ) {
			alert('비밀번호를 입력해주세요');
			$('#pass').focus();
			return;
		}
		else if( $('#name').val() == "" ) {
			alert('이름를 입력해주세요');
			$('#name').focus();
			return;
		} else {
			$('#form').submit();
		}
		
	});
</script>
</html>






