<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 회원가입</title>
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
	<h3>고객 회원가입 폼</h3>
	<!-- id check form -->
	
		<div>
			아이디중복검사
			<input type="text" name="idck" id="idck">
			<button type="button" id="idckBtn">중복확인</button>
		</div>
	
	<!-- 고객가입 form -->
	
	<form action="<%=request.getContextPath() %>/login/addCustomerAction.jsp" method="post" id="form">
			
		
			<div>customer id
			<input type="text" name="customerId" id="id" readonly="readonly"></div>
			
			<div>customer pass
			<input type="password" name="customerPass" id="pass"></div>
			
			<div>customer name
			<input type="text" name="customerName" id="name"></div>
			
			<div>customer Adress
			<input type="text" name="customerAdress" id="adress"></div>
			
			<div>customer Tel
			<input type="text" name="customerTel" id="tel"></div>
			
			<button type="button" id="btn">회원가입</button>
	</form>

</body>
<script>
	// 회원가입 빈칸검사
	$('#idckBtn').click(function() {
		if($('#idck').val().length < 4 || $('#idck').val().length > 13) {
			alert('ID는 4자이상 13자 이하입니다.');
		} else {
			$.ajax({
				url : '/shop/idckController',
				type : 'post',
				data : {idck : $('#idck').val()},
				success : function(json) {
					if(json == 'y') {
						alert('사용가능한 아이디 입니다.');
						$('#customerId').val($('#idck').val());
					} else {
						alert('이미 사용중인 아이디 입니다.');
						$('#customerId').val('');
					}
				}
			});
		}
	});
	
	$('#btn').click(function(){
		
		if( $('#id').val() == "" ) {
			alert('아이디중복검사를 해주세요');
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
		}
		else if( $('#adress').val() == "" ) {
			alert('주소를 입력해주세요');
			$('#adress').focus();
			return;
		}
		else if( $('#tel').val() == "" ) {
			alert('번호를 입력해주세요');
			$('#tel').focus();
			return;
		} else {
			$('#form').submit();
		}
		
	});
</script>
</html>






