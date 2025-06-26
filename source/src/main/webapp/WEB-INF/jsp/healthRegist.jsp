<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>体調登録</title>
<style>
/* === ページ全体ベース === */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background: #FFFEEF; /* 背景色指定 */
	color: #22292F; /* 薄めの黒（ややグレー系：#22292F） */
	font-family: 'メイリオ', 'Meiryo', 'sans-serif';
	font-size: 17px;
	line-height: 1.8;
}

a {
	color: #46B1E1;
	text-decoration: none;
}

a:hover {
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
button {
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

button:hover {
	background: #2d7ea3;
	color: #fff;
}

.btn {
	display: inline-block;
	background: #A9C9E1;
	color: #22292F;
	text-decoration: none;
	border-radius: 9px;
	padding: 0.6em 1.7em;
	margin-bottom: 22px;
	margin-top: 8px;
	font-size: 1em;
	font-weight: bold;
	transition: background 0.2s;
}

.btn:hover {
	background: #7ba9c9;
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

<!--
サブタイトルのCSS -->.sub-header {
	background-color: #46B1E1; /* 青色 */
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 100px !important; /* ヘッダーがfixedなので被らないようにする */
}

.sub-header h2 {
	margin: 0;
	font-size: 2rem;
	text-align: center;
	color: #FFFEEF;
	background-color: #46B1E1;
}
</style>
</head>

<body>
	<header>
		<%@ include file="/WEB-INF/jsp/header.jsp"%>
	</header>
	<main>
		<div class="sub-header">
			<h2>体調登録</h2>
		</div>
		<h2>本日の体調を入力してください！</h2>
		<div style="text-align: center; margin-top: 18px;">
			<a href="OmoiyalinkHealthMng" class="btn"> 一覧を見る </a>
		</div>
		<c:if test="${not empty healthMessage}">
		    <div style="color:red; text-align: center;">${healthMessage}</div>
		</c:if>
		<form method="POST"
			action="${pageContext.request.contextPath}/OmoiyalinkHealthRegist"
			autocomplete="off" id="regist_form" class="form-box"
			accept-charset="UTF-8">
			<label> 日付 <input type="date" name="createdAt" required
				value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
			</label> <label> 体温(℃) （必須項目）<input type="text" name="temperature" required
				pattern="\d+(\.\d+)?" placeholder="例：36.6">
			</label> <label> 最大血圧 <input type="text" name="highBp" pattern="\d*"
				placeholder="例：120">
			</label> <label> 最小血圧 <input type="text" name="lowBp" pattern="\d*"
				placeholder="例：80">
			</label> <label> 脈拍(bpm) <input type="text" name="pulseRate"
				pattern="\d*" placeholder="例：70">
			</label> <label> 血中酸素濃度(%) <input type="text" name="pulseOx"
				pattern="\d+(\.\d+)?" placeholder="例：98.2">
			</label> <label> 睡眠休養感（必須項目） <select name="sleep" required>
					<option value="">選択してください</option>
					<option value="5">よく眠れた</option>
					<option value="4">まぁまぁ眠れた</option>
					<option value="3">普通</option>
					<option value="2">あまり眠れなかった</option>
					<option value="1">全然眠れなかった</option>
			</select>
			</label> <label> メモ <input type="text" name="memo"
				placeholder="例：薬を飲んだ。頭痛あり。良く眠れた。"></label>
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
    const temperature = this.temperature.value;
    const sleep = this.sleep.value;
    const createdAt = this.createdAt.value;
    if (temperature === '' || sleep === '' || createdAt === '') {
        document.getElementById('regist').textContent = '日付・体温・睡眠休養感は必須です';
        event.preventDefault();
    }
    // 体温の数字バリデーション
    if (!/^\d+(\.\d+)?$/.test(temperature)) {
        document.getElementById('regist').textContent = '体温は数字で入力してください';
        event.preventDefault();
    }
}
</script>
</body>
</html>