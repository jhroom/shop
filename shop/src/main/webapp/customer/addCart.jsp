<%@page import="service.CartService"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println("\r\naddCart.jsp 시작");

	//구매하는 사람 상품 정보 받아오기
	String customerId = request.getParameter("customerId");
	System.out.println("customerId : " + customerId);
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	System.out.println("goodsNo : " + goodsNo);
	
	int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
	System.out.println("cartQuantity : " + cartQuantity);
	
	//구매할 데이터 담을 cart 객체
	Cart cart = new Cart();
	
	cart.setCustomerId(customerId);
	cart.setGoodsNo(goodsNo);
	cart.setCartQuantity(cartQuantity);
	
	CartService cartService = new CartService();
	
	//cart객체 서비스 성공시  true반환
	boolean result = cartService.addCart(cart);
	
	if(result){
		System.out.println("카트담기성공");
		response.sendRedirect(request.getContextPath()+"/customer/customerGoodsOne.jsp?goodsNo="+goodsNo);
	} else{
		System.out.println("카트담기실패");
	}
%>
