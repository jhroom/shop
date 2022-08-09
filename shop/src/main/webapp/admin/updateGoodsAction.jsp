<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@page import="vo.GoodsImg"%>
<%
	String dir = request.getServletContext().getRealPath("/upload");
	int max = 10*1024*1024;
	
	MultipartRequest mrequest =  new MultipartRequest(request,dir,max,"utf8",new DefaultFileRenamePolicy());
	
	int goodsNo = Integer.parseInt(mrequest.getParameter("goodsNo"));
	
	String goodsName = mrequest.getParameter("goodsName");
		System.out.println("goodsName : " + goodsName);
		
	int goodsPrice = Integer.parseInt(mrequest.getParameter("goodsPrice"));
		System.out.println("goodsPrice : " + goodsPrice);
		
	String soldOut = mrequest.getParameter("soldOut");
		System.out.println("soldOut : " + soldOut);

	String contentType = mrequest.getContentType("goodsFile");
		System.out.println("contentType : " + contentType);
		
	String originName = mrequest.getOriginalFileName("goodsFile");
		System.out.println("originName : " + originName);
		
	String systemFileName = mrequest.getFilesystemName("goodsFile");
		System.out.println("systemFileName : " + systemFileName);
		
	if( !(contentType.equals("image/jpeg") || contentType.equals("image/gif") || contentType.equals("image/png")) ){
		File file = new File(dir +"/"+ systemFileName);
		if( file.exists()) {
			file.delete();
		}
		response.sendRedirect(request.getContextPath() +"/admin/updateGoodsForm.jsp?goodsNo="+goodsNo+"&InvalidFile");
		return;
	}
	
	GoodsService goodsService = new GoodsService();
	Goods goods = new Goods();
	
	//굿즈 객체에 담기
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
		System.out.println("goods 입력된 객체 : " + goods);
	
	GoodsImg goodsImg = new GoodsImg();
	//굿즈 이미지객체 담기
	goodsImg.setContentType(contentType);
	goodsImg.setFileName(systemFileName);
	goodsImg.setOriginFileName(originName);
		System.out.println("goodsImg 입력된 객체 : " + goodsImg);
	
	// 업데이트할 굿즈 객체를 
	boolean result = new GoodsService().modifyGoods(goods, goodsImg);
	
	if(result){
		response.sendRedirect(request.getContextPath()+"/admin/selectGoodsOne.jsp?goodsNo="+goodsNo+"&addSuccess");
	} else {
		response.sendRedirect(request.getContextPath()+"/adimin/selectGoodsOne.jsp?goodsNo="+goodsNo+"&addFail");
	}
	
%>