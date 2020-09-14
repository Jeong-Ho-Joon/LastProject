<%@ page import = "java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="bbs.Bbs" %>
    <%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<style>
body { 
  background: url(image/bg7.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>
 <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>FVB</title>
</head>
<body>
<%
	String userID=null;
if(session.getAttribute("userID")!= null){
	userID = (String)session.getAttribute("userID");
}
String content = null;
if(request.getParameter("content") != null) {
	content = request.getParameter("content");
}

Bbs bbs = new BbsDAO().getContent(content);

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String uid = "kosea";
String pwd = "kosea2019a";
String sql = "SELECT * FROM (SELECT content FROM BBS_TBL ORDER BY dbms_random.value) WHERE rownum < 4";
%>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">FVB</a>
		</div>
		<div class="collapse navbar-collapse" 
		id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp"><i class="fas fa-home"></i>&nbsp;Home</a></li>
				<li><a href="bbs.jsp"><i class="fas fa-list"></i>&nbsp;All</a></li>
				<li><a href="game.jsp"><i class="fas fa-gamepad"></i>&nbsp;Game</a></li>
				<li><a href="horror.jsp"><i class="fas fa-ghost"></i>&nbsp;Horror</a></li>
				<li><a href="animal.jsp"><i class="fas fa-paw"></i>&nbsp;Animal</a></li>
				<li><a href="movie.jsp"><i class="fas fa-film"></i>&nbsp;Movie</a></li>
				<li><a href="humor.jsp"><i class="fas fa-grin-squint"></i>&nbsp;Humor</a></li>
				<li><a href="music.jsp"><i class="fas fa-music"></i>&nbsp;Music</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fas fa-plug"></i>&nbsp;접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i>&nbsp;로그인</a></li>
						<li><a href="join.jsp"><i class="fas fa-user-alt"></i>&nbsp;회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><i class="fas fa-users-cog"></i>&nbsp;회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp"><i class="fas fa-user-slash"></i>&nbsp;로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<table align="center">
	<tr>
	
	<%
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, uid , pwd);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			/* String resu = rs.getContent().substring(rs.getContent().lastIndexOf("=")+1);		 */
			out.println("<td><a href='" + rs.getString("content") + "'" + " target='_blank' class='indexArticle'>" + 
			"<img src = 'http://img.youtube.com/vi/" + rs.getString("content").substring(rs.getString("content").lastIndexOf("=")+1) + "/mqdefault.jpg'" + " class='youtube_img' alt = '유투브 영상' data-href='"+ rs.getString("content")+"'>" + "</td>");
			out.println("<td style='width:50px'>"+"</td>");
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	</tr>
	<tr>
	<%
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, uid , pwd);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			/* String resu = rs.getContent().substring(rs.getContent().lastIndexOf("=")+1);		 */
			out.println("<td><a href='" + rs.getString("content") + "'" + " target='_blank' class='indexArticle'>" + 
			"<img src = 'http://img.youtube.com/vi/" + rs.getString("content").substring(rs.getString("content").lastIndexOf("=")+1) + "/mqdefault.jpg'" + " class='youtube_img' alt = '유투브 영상' data-href='"+ rs.getString("content")+"'>" + "</td>");
			out.println("<td style='width:50px'>"+"</td>");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	</tr>
	
	<tr>
	<%
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, uid , pwd);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			/* String resu = rs.getContent().substring(rs.getContent().lastIndexOf("=")+1);		 */
			out.println("<td><a href='" + rs.getString("content") + "'" + " target='_blank' class='indexArticle'>" + 
			"<img src = 'http://img.youtube.com/vi/" + rs.getString("content").substring(rs.getString("content").lastIndexOf("=")+1) + "/mqdefault.jpg'" + " class='youtube_img' alt = '유투브 영상' data-href='"+ rs.getString("content")+"'>" + "</td>");
			out.println("<td style='width:50px'>"+"</td>");
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	</tr>
	
	</table>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>