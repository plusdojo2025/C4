<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>薬の編集・削除</title>
<style>
/* === ページ全体ベース === */
form {
    max-width: 600px; margin: 0 auto;
 }
label {
    display: block; margin-top: 1em;
}
        
input[type="text"], textarea {
    width: 100%; padding: 0.5em;
}
.checkbox-group {
margin-top: 0.5em;
}
.checkbox-group label {
    display: inline-block; margin-right: 1em;
}
.readonly-info {
    background: #f4f4f4; padding: 0.5em;
}
.error {
    color: red; margin-top: 1em;
}
button {
    margin-top: 1em;
}

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
input[name="delete"], input[name="submit"]{
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
.button-group {
  display: flex;
  gap: 10px; /* ボタンの間隔 */
}

.button-group form {
  margin: 0;
}
</style>
</head>
<body>
<header>
    <!-- 共通ヘッダー -->
<%@ include file="/WEB-INF/jsp/header.jsp"%>
    <h1>薬の編集・削除</h1>
</header>
<main>
    <h2>登録されているお薬の一覧</h2>
    <c:forEach var="e" items="${cardList}" >
        <form method="POST" action="${pageContext.request.contextPath}/OmoiyalinkMedMng" id="regist_form">
            <label>
                薬の正式名称
                <input type="text" name="formalName" value="${e.formalName}"><br>
            </label>
            <label>
                薬の愛称
                <input type="text" name="nickName" value="${e.nickName}"><br>
            </label>
            <label>
                服薬時間
                <input type="time" name="intake_time" value="${e.intake_time}"><br>
            </label>
            <label>
                用量
                <input type="text" name="formalName" value="${e.nickName}"><br>
            </label>
            <label>
                メモ
                <input type="text" name="memo" value="${e.memo}"><br>
            </label>
            <label class="button-group">
                <input type="submit" name="submit" value="更新">
                <input type="submit" name="delete" value="削除">
            </label>        
        </form>
        <p id="regist"></p>
    </c:forEach>
    <c:if test="${empty cardList}">
	<p>指定された条件に一致するデータはありません。</p>
	</c:if>
</main>

<footer>
    <%@ include file="/WEB-INF/jsp/footer.jsp"%>
</footer>
<!-- Javascriptの設定 -->
<script>
'use strict';
    document.getElementById('regist_form').onsubmit= function(){
    	const formalName = document.getElementById('regist_form').formalName.value;
    	const intake_time = document.getElementById('regist_form').intake_time.value;
        if (formalName ==='' || intake_time ===''){
            document.getElementById('regist').textContent ='体温と睡眠休養感を入力してください';
            event.preventDefault();
        }
    }
</script>
</body>
</html>