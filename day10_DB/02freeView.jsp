<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<%@include file="/WEB-INF/inc/header.jsp"%>
<body>
	<%@include file="/WEB-INF/inc/top.jsp"%>
	<%
	String boNo = request.getParameter("boNo");
	
	try {
		// 1. 드라이버 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (ClassNotFoundException e) {
		System.out.println("OracleDriver를 찾을수 없음");
	}
	Connection conn = null;	// 연결하는 객체
	Statement stmt = null;	// 쿼리수행 객체
	ResultSet rs = null;		// select의 경우 결과 저장 객체
	
	try {
		// 2. 연결
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","jsp","oracle");
		
		// 3. 쿼리 수행
		stmt = conn.createStatement();
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT											 ");
		sb.append("      bo_no       , bo_title , bo_category ");
		sb.append("    , bo_writer   , bo_pass  , bo_content  ");
		sb.append("    , bo_ip       , bo_hit   , bo_reg_date ");
		sb.append("    , bo_mod_date , bo_del_yn				 ");
		sb.append("FROM											 ");
		sb.append("    free_board								 ");
		sb.append(" WHERE bo_no	 = " + "'" + boNo + "'"		  );
		
		rs = stmt.executeQuery(sb.toString()); // 세미콜론(;) 쓰지 않음
		
		if (rs.next()) {
			FreeBoardVO free = new FreeBoardVO();
			free.setBoNo(rs.getInt("bo_no"));free.setBoTitle(rs.getString("bo_title"));free.setBoCategory(rs.getString("bo_category"));
			free.setBoWriter(rs.getString("bo_writer"));free.setBoPass(rs.getString("bo_pass"));free.setBoContent(rs.getString("bo_content"));
			free.setBoIp(rs.getString("bo_ip"));free.setBoHit(rs.getInt("bo_hit"));free.setBoRegDate(rs.getString("bo_reg_date"));
			free.setBoModDate(rs.getString("bo_mod_date"));free.setBoDelYn(rs.getString("bo_del_yn"));
			
			request.setAttribute("free", free);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		// 4. 종료
		if(conn != null) {try{conn.close();}catch(Exception e){}}
		if(stmt != null) {try{stmt.close();}catch(Exception e){}}
		if(rs != null) {try{rs.close();}catch(Exception e){}}
	}
	%>
	<table class="table table-striped table-bordered">
		<tr>
			<th>boNo</th>
			<td>${free.boNo }</td>
		</tr>
		<tr>
			<th>boTitle</th>
			<td>${free.boTitle }</td>
		</tr>
		<tr>
			<th>boCategory</th>
			<td>${free.boCategory }</td>
		</tr>
		<tr>
			<th>boWriter</th>
			<td>${free.boWriter }</td>
		</tr>
		<tr>
			<th>boContent</th>
			<td>${free.boContent }</td>
		</tr>
		<tr>
			<th>boHit</th>
			<td>${free.boHit }</td>
		</tr>
		<tr>
			<th>boRegDate</th>
			<td>${free.boRegDate }</td>
		</tr>
		<tr>
			<th>boModDate</th>
			<td>${free.boModDate }</td>
		</tr>
	</table>
</body>
</html>