<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

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
<meta name="viewport" content="width=device-width" initial-scale="1">
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
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	int num = 0;
	if (request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	if (num == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	
	Bbs bbs = new BbsDAO().getBbs(num);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
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
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><i class="fas fa-users-cog"></i>&nbsp;회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp"><i class="fas fa-user-slash"></i>&nbsp;로그아웃</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?num=<%= num %>">
				<table class="table table-striped"
					style="text-align: center; border: 1px soild #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2"><input type="text" class="form-control" placeholder="글제목" name="title" maxlength="50" value="<%= bbs.getTitle() %>"></td>
						</tr>
						
						<tr>
						<td><input type="text" class="form-control" placeholder="영상주소" name="content"  value="<%= bbs.getContent() %>"></td>
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
					<td><input type="text" class="form-control" placeholder="설명" name="content2" value="<%= bbs.getContent2()%>"></td>
					
					</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-default pull-right" value="글수정">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>