<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@page import="service.GoodsService"%>
<%@page import="vo.Goods"%>
<%@page import="vo.GoodsImg"%>
<%
	String folder = request.getServletContext().getRealPath("/upload");
	int max = 10*1024*1024;
	
	MultipartRequest mrequest =  new MultipartRequest(request,folder,max,"utf8",new DefaultFileRenamePolicy());
	
	String goodsName = mrequest.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(mrequest.getParameter("goodsPrice"));
	String soldOut = mrequest.getParameter("soldOut");
	
	String contentType = mrequest.getContentType("goodsFile");
		System.out.println(contentType);
	String originName = mrequest.getOriginalFileName("goodsFile");
		System.out.println(originName);
	String systemFileName = mrequest.getFilesystemName("goodsFile");
		System.out.println(systemFileName);
	
	GoodsService goodsService = new GoodsService();
	Goods goods = new Goods();
	
	//굿즈 객체에 담기
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
		System.out.println("goods 입력된 객체 : " + goods);
	
	GoodsImg goodsImg = new GoodsImg();
	goodsImg.setContentType(contentType);
	goodsImg.setFileName(systemFileName);
	goodsImg.setOriginFileName(originName);
		System.out.println("goodsImg 입력된 객체 : " + goodsImg);
	
	// 업데이트할 굿즈 객체를 
	boolean result = new GoodsService().modifyGoods(goods);
	
	if(result){
		response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp?updateSuccess");
	}
	
%>