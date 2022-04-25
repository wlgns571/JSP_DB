<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="oracle.jdbc.driver.OracleDriver"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%request.setCharacterEncoding("UTF-8"); %>
<%@include file="/WEB-INF/inc/header.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/inc/top.jsp" %>
<%
	String driver = request.getParameter("driver");
	Class.forName(driver);
	// Class.forName("oracle.jdbc.driver.OracleDriver");
	// OracleDriver oracle = new OracleDriver();
	
	// 언제 로드가 되든 로드가 되면, DriverManager에 oracleDriver가 등록
	// static{},
	
	Connection conn = null;	// 연결하는 객체
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","jsp","oracle");	// 2. 연결
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM free_board WHERE bo_no = 1");
		if(rs.next()){
			FreeBoardVO freeBoard = new FreeBoardVO();
			freeBoard.setBoNo(rs.getInt("bo_no"));
			freeBoard.setBoTitle(rs.getString("bo_title"));
			request.setAttribute("freeBoard", freeBoard);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		if(rs != null)  {try{rs.close();}  catch(Exception e){}}
		if(stmt != null){try{stmt.close();}catch(Exception e){}}
		if(conn != null){try{conn.close();}catch(Exception e){}}
	}
		
%>
${freeBoard }



</body>
</html>