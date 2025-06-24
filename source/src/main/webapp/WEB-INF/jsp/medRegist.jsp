<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>薬の新規登録</title>
<style>
form {
	max-width: 600px;
	margin: 0 auto;
}

label {
	display: block;
	margin-top: 1em;
}

input[type="text"], textarea {
	width: 100%;
	padding: 0.5em;
}

.checkbox-group {
	margin-top: 0.5em;
}

.checkbox-group label {
	display: inline-block;
	margin-right: 1em;
}

.readonly-info {
	background: #f4f4f4;
	padding: 0.5em;
}

.error {
	color: red;
	margin-top: 1em;
}

button {
	margin-top: 1em;
}

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

a {
	color: #46B1E1;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
	color: #286e93;
}

h1, h2, h3, h4, h5 {
	color: #46B1E1;
	margin-top: 1em;
	margin-bottom: .7em;
	font-weight: bold;
	text-align: center;
}

label, .label {
	color: #22292F;
	font-weight: bold;
}
/* === レスポンシブ設計 === */
@media ( max-width : 600px) {
	html, body {
		font-size: 15px;
		padding: 0;
	}
	.container, .login-container, .form-box {
		max-width: 99vw;
		padding: 6vw 2vw;
		box-sizing: border-box;
	}
	input, select, button, textarea {
		font-size: 1em !important;
	}
	h1, h2 {
		font-size: 1.25em !important;
	}
}
/* ボタン共通 */
button, .btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 0.65em 1.6em;
	margin: 6px 0;
	cursor: pointer;
	font-size: 1em;
	font-family: inherit;
	transition: background 0.22s;
}

button:hover, .btn:hover {
	background: #2d7ea3;
	color: #fff;
}
/* コンテナ */
.container, .login-container, .form-box {
	max-width: 450px;
	margin: 50px auto;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 2px 18px #eef1f4;
	padding: 34px 18px 44px 18px;
}
/* 入力フォーム */
input, select, textarea {
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

input:focus, select:focus, textarea:focus {
	outline: none;
	border-color: #46B1E1;
	background: #fcf8f0;
}

#regist {
	text-align: center;
	font-size: 1.5rem;
	color: #FF6368;
}
/* ナビゲーションボタン */
.button-nav {
	display: flex;
	justify-content: center;
	gap: 18px;
	margin: 22px 0 10px 0;
}

.button-nav a {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 0.65em 1.6em;
	font-size: 1em;
	font-family: inherit;
	text-decoration: none;
	transition: background 0.22s;
	display: inline-block;
}

.button-nav a:hover {
	background: #2d7ea3;
}
</style>
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/jsp/header.jsp"%>
		<h1>薬の新規登録</h1>
	</header>

	<!-- ナビゲーションボタン -->
	<div class="button-nav">
		<a href="${pageContext.request.contextPath}/OmoiyalinkMedMng">登録した薬の一覧</a>
		<a href="${pageContext.request.contextPath}/OmoiyalinkTlkMedMng">服薬一覧</a>
		<a href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist">服薬登録</a>
	</div>

	<main>
		<form method="POST"
			action="${pageContext.request.contextPath}/OmoiyalinkMedRegist"
			autocomplete="off" id="regist_form" class="form-box"
			accept-charset="UTF-8">
			<label> 薬の正式名称（必須項目） <input type="text" name="formalName"><br>
			</label> <label> 薬の愛称 <input type="text" name="nickName"><br>
			</label> <label> 服薬時間(必須項目) <input type="time" name="intake_time"><br>
			</label> <label> 用量 <input type="text" name="dosage"><br>
			</label> <label> メモ <input type="text" name="memo"><br>
			</label>
			<p id="regist"></p>
			<button type="submit">登録する</button>
		</form>
	</main>

	<footer>
		<%@ include file="/WEB-INF/jsp/footer.jsp"%>
	</footer>

	<script>
'use strict';
    document.getElementById('regist_form').onsubmit = function(event){
        const formalName = document.getElementById('regist_form').formalName.value;
        const intake_time = document.getElementById('regist_form').intake_time.value;
        if (formalName ==='' || intake_time ===''){
            document.getElementById('regist').textContent ='薬の正式名称と服薬時間を入力してください';
            event.preventDefault();
        }
    }
</script>
</body>
</html>
