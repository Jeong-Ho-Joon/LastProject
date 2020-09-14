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
	int num = 0;
	if(request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	if(num == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	PrintWriter outt = response.getWriter();
	Bbs bbs = new BbsDAO().getBbs(num);
	
	String sn1 = "img.youtube.com/vi/";
	String sn2 = "/mqdefault.jpg";
	
	String resu = bbs.getContent().substring(bbs.getContent().lastIndexOf("=")+1);
	
			
%>
<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">FVB</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp"><i class="fas fa-home"></i>&nbsp;Home</a></li>
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
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border: 1px soild #dddddd">
				<thead>
					<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align:center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
					</tr> 	
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td style="width: 30%; text-align: center;">
						<a href="<%=bbs.getContent()%>" target="_blank" class="indexArticle">
 							<img src="https://img.youtube.com/vi/<%= resu %>/mqdefault.jpg" class="youtube_img" alt="유투브 영상" data-href="<%=bbs.getContent()%>">
  						</a>
  						</td>
						<td style="text-align: left; width:auto;">
  							<%=bbs.getContent2().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\n", "<br>")%>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-info">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a href="update.jsp?num=<%= num %>" class="btn btn-info">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?num=<%= num %>" class="btn btn-info">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>