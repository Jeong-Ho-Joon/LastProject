<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
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
<style type="text/css">
 	a, a:hover {
 		color: #000000;
 		text-decoration: none;
 	}
</style>
</head>
<body>
	<%
	String userID=null;
	if(session.getAttribute("userID")!= null){
		userID = (String)session.getAttribute("userID");
	}
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
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
				<li class="active"><a href="animal.jsp"><i class="fas fa-paw"></i>&nbsp;Animal</a></li>
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
			<table class="table table-hover"
				style="text-align: center; border: 1px soild #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">카테고리</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> listanimal = bbsDAO.getListanimal(pageNumber);
					for(int i = 0; i < listanimal.size(); i++) {
						
					%>
					<tr>
						<td><%= listanimal.get(i).getNum() %></td>
						<td><a href="view.jsp?num=<%= listanimal.get(i).getNum() %>"><%= listanimal.get(i).getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></a></td>
						<td><%= listanimal.get(i).getUserID() %></td>
						<td><%= listanimal.get(i).getCtg() %></td>
						<td><%= listanimal.get(i).getBbsDate().substring(0, 11) + listanimal.get(i).getBbsDate().substring(11, 13) + "시" + listanimal.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href= "animal.jsp?pageNumber=<%=pageNumber - 1 %>"class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="animal.jsp?pageNumber=<%=pageNumber + 1 %>"class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-default pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>