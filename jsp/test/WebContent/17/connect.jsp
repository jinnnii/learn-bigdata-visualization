<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String user = "scott";
		String password = "tiger";

		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);
		out.print("데이터베이스 연결이 성공했습니다.");
		
		String sql="SELECT * FROM STUDENT";
		stmt = conn.createStatement();
		rs =stmt.executeQuery(sql);

		while(rs.next()){
			String name = rs.getString("name");
			out.print(name);
		}
	} catch (SQLException e) {
		out.print("데이터베이스 연결에 실패했습니다.<br>");
		out.print("SQLException:" + e.getMessage());
	} finally {
		if(rs !=null) rs.close();
		if(stmt !=null) stmt.close();
		if(conn !=null) conn.close();
	}
	%>
</body>
</html>