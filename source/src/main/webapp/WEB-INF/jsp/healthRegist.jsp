<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</style>
</head>
<body>
<header>
	<!-- ヘッダー-->
    <!-- 共通ヘッダー -->
    <%-- <%@ include file="/WEB-INF/jsp/header.jsp" %> --%>
    <h1>体調登録</h1>
    <!-- ヘッダーここまで -->
</header>    

    <main>
        <h2>本日の体調を入力してください！</h2>
        <form method="POST" action="${pageContext.request.contextPath}/OmoiyalinkHealthRegist" autocomplete="off" 
        id="regist_form" class="form-box">
            <label>
                体温（必須項目）
                <input type="text" name="temperature"><br>
            </label>
            <label>
                最大血圧
                <input type="text" name="highBp"><br>
            </label>
            <label>
                最小血圧
                <input type="text" name="lowBp"><br>
            </label>
            <label>
                脈拍
                <input type="text" name="pulseRate"><br>
            </label>
            <label>
                血中酸素濃度
                <input type="text" name="pulseOx"><br>
            </label>
            <label>
            	睡眠休養感(必須項目)
            <select name="sleep" required>
                <option value="">選択してください</option>
                <option value="5">よく眠れた</option>
                <option value="4">まぁまぁ眠れた</option>
                <option value="3">普通</option>
                <option value="2">あまり眠れなかった</option>
                <option value="1">全然眠れなかった</option>
            </select><br>
            </label>
            <label>
                メモ
                <input type="text" name="memo"><br>
            </label>
            <p id="regist"></p>
            <button type="submit">登録する</button>
        </form>

	</main>
    <!-- メインここまで -->

<footer>
    <!-- フッター -->
     <%-- <%@ include file="/WEB-INF/jsp/footer.jsp" %> --%>
    <!-- フッターここまで -->
</footer>

    <!-- Javascriptの設定 -->
    <script>
    'use strict';
    document.getElementById('regist_form').onsubmit= function(){
    	const temperature = document.getElementById('regist_form').temperature.value;
    	const sleep = document.getElementById('regist_form').sleep.value;
        if (temperature ==='' || sleep ===''){
            document.getElementById('regist').textContent ='体温と睡眠休養感を入力してください';
            event.preventDefault();
        }
    }
    </script>	
</body>
</html>