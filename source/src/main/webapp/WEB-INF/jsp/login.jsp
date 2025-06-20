<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>おもいやリンク ログイン</title>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background: #FFFEEF;
	color: #22292F;
	font-family: 'メイリオ', 'Meiryo', 'sans-serif';
	font-size: 17px;
	line-height: 1.8;
}

h2 {
	color: #fff;
	margin: 0;
	font-size: 2rem;
	text-align: center;
	font-weight: bold;
}

a {
	text-decoration: none;
}

.sub-header {
	background-color: #46B1E1;
	color: #fff;
	padding: 15px 30px 10px 30px;
}

.login-container {
	max-width: 450px;
	margin: 50px auto 0 auto;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 2px 18px #eef1f4;
	padding: 34px 18px 44px 18px;
}

label {
	color: #22292F;
	font-weight: bold;
	display: block;
	margin-top: 1em;
	margin-bottom: 0.3em;
}

input {
	width: 98%;
	padding: 0.48em;
	font-size: 1.05em;
	margin-bottom: 1.2em;
	border: 1px solid #a3cde2;
	border-radius: 8px;
	background: #FFFEF9;
	color: #22292F;
	box-sizing: border-box;
}

input:focus {
	outline: none;
	border-color: #46B1E1;
	background: #fcf8f0;
}
/* -------- ボタン共通 -------- */
.btn-main {
	display: block;
	margin: 16px auto 0 auto;
	padding: 0.62em 1.5em;
	font-size: 1em;
	border-radius: 9px;
	background: #46B1E1;
	color: #fff;
	border: none;
	font-family: inherit;
	cursor: pointer;
	transition: background 0.18s, box-shadow 0.18s, transform 0.13s;
	min-width: 120px;
	text-align: center;
}

.btn-main:hover {
	background: #2d7ea3;
	color: #fff;
}

.rgstbtn {
	display: block;
	font-size: 1em;
	border-radius: 9px;
	background: rgb(127, 127, 127);
	color: #fff;
	border: none;
	font-family: inherit;
	cursor: pointer;
	transition: background 0.18s, box-shadow 0.18s, transform 0.13s;
	min-width: 120px;
	text-align: center;
	width: 240px;
	margin: 50px auto 50px auto;
}

.rgstbtn:hover {
	background: rgb(108, 108, 108);
	color: #fff;
}

.error {
	color: #ec8888;
	font-size: 0.95em;
	margin: 1em 0;
	text-align: center;
}

@media ( max-width : 600px) {
	html, body {
		font-size: 15px;
	}
	.login-container {
		max-width: 99vw;
		padding: 6vw 2vw;
	}
	
		h1, h2 {
		font-size: 1.25em !important;
	}
}
</style>
</head>
<body>
	<div class="sub-header">
		<h2>おもいやリンクへようこそ</h2>
	</div>
	<div class="login-container">
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<form action="OmoiyalinkLogin" method="post" autocomplete="off">
			<label for="user_id">ID（半角数字）</label> <input type="text" id="user_id"
				name="user_id" maxlength="10" required> <label for="name">名前</label>
			<input type="text" id="name" name="name" maxlength="50" required>
			<label for="birth_date">生年月日（8桁：例 20000101）</label> <input
				type="text" id="birth_date" name="birth_date" maxlength="8" required>
			<button type="submit" class="btn-main">ログイン</button>
		</form>

	</div>
	<a
		href="${pageContext.request.contextPath}/OmoiyalinkUserRegistServlet"
		class="rgstbtn" style="margin-top: 10px;">新規登録はこちら</a>
	<%@ include file="footer.jsp"%>
</body>
</html>
