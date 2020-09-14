<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
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
<style>
.box-radio-input input[type="radio"]{
    display:none;
}

.box-radio-input input[type="radio"] + span{
    display:inline-block;
    background:none;
    border:1px solid #dfdfdf;    
    padding:0px 10px;
    text-align:center;
    height:35px;
    line-height:33px;
    font-weight:500;
    cursor:pointer;
}

.box-radio-input input[type="radio"]:checked + span{
    border:1px solid #000000;
    background:#BDBDBD;
    color:#fff;
}
</style>
</head>
<body>

<%
	String userID=null;
if(session.getAttribute("userID")!= null){
	userID = (String)session.getAttribute("userID");
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
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="text-align:center; border: 1px soild #dddddd">
				<thead>
					<tr>
					<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글쓰기 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr >
						<td colspan="2"><input type="text" class="form-control" placeholder="글제목" name="title" maxlength="50"></td>
					</tr>
					<tr>
						<td style="width:75%"><input type="text" class="form-control" placeholder="영상주소" name="content" ></td>
						<td style="width:25%; vertical-align:middle;" rowspan="2">
							<h3>
								<label class="box-radio-input"><input type="radio" name="ctg" value="게임"><span>게임</span></label>
								<label class="box-radio-input"><input type="radio" name="ctg" value="공포"><span>공포</span></label>
								<label class="box-radio-input"><input type="radio" name="ctg" value="동물"><span>동물</span></label><br>
								<label class="box-radio-input"><input type="radio" name="ctg" value="영화"><span>영화</span></label>
								<label class="box-radio-input"><input type="radio" name="ctg" value="유머"><span>유머</span></label>
								<label class="box-radio-input"><input type="radio" name="ctg" value="음악"><span>음악</span></label>
							</h3>	
						</td>
					</tr>
					<tr>
					<td><textarea class="form-control" placeholder="글내용" name="content2" maxlength="4000" style="heigth:300px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-default pull-right" value="글쓰기">
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>