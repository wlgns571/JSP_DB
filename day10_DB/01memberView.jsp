<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.member.vo.MemberVO"%>
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
		String memId = request.getParameter("memId");
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
		sb.append(" SELECT	mem_id 								  ");
		sb.append("    , mem_pass    , mem_name     , mem_bir     ");
		sb.append("    , mem_zip     , mem_add1     , mem_add2    ");
		sb.append("    , mem_hp      , mem_mail     , mem_job     ");
		sb.append("    , mem_hobby   , mem_mileage  , mem_del_yn  ");
		sb.append(" FROM  member 									  ");
		sb.append(" WHERE mem_id	 = " + "'" + memId + "'"				);
		
		rs = stmt.executeQuery(sb.toString()); // 세미콜론(;) 쓰지 않음
		
		if (rs.next()) {
			MemberVO member = new MemberVO();
			member.setMemId(rs.getString("mem_id"));member.setMemPass(rs.	getString("mem_pass"));member.setMemName(rs.getString("mem_name"));
			member.setMemBir(rs.getString("mem_bir"));member.setMemZip(rs.getString("mem_zip"));member.setMemAdd1(rs.getString("mem_add1"));
			member.setMemAdd2(rs.getString("mem_add2"));member.setMemHp(rs.getString("mem_hp"));member.setMemMail(rs.getString("mem_mail"));
			member.setMemJob(rs.getString("mem_job"));member.setMemHobby(rs.getString("mem_hobby"));member.setMemMileage(rs.getInt("mem_mileage"));
			member.setMemDelYn(rs.getString("mem_del_yn"));
			
			request.setAttribute("member", member);
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
			<th>memId</th>
			<td>${member.memId }</td>
		</tr>
		<tr>
			<th>memName</th>
			<td>${member.memName }</td>
		</tr>
		<tr>
			<th>memBir</th>
			<td>${member.memBir }</td>
		</tr>
		<tr>
			<th>memZip</th>
			<td>${member.memZip }</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${member.memAdd1 } ${member.memAdd2 }</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${member.memHp }</td>
		</tr>
		<tr>
			<th>메일</th>
			<td>${member.memMail }</td>
		</tr>
		<tr>
			<th>직업</th>
			<td>${member.memJob }</td>
		</tr>
		<tr>
			<th>취미</th>
			<td>${member.memHobby }</td>
		</tr>
	</table>
</body>
</html>