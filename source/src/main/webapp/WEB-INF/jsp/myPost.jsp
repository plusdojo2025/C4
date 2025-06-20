<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>マイ投稿</title>
<style>
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
    text-align: center;
}

a {
	color: #46B1E1;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
	color: #286e93;
}

h1, h2, h4, h5 {
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
.container, .login-container, .form-box, .post {
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
 <!-- サブタイトルのCSS -->
.sub-header {
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
	  <h2>マイ投稿</h2>
	</div>

    <c:if test="${empty myPosts}">
        <p>該当する投稿が見つかりませんでした。</p>
    </c:if>

    <c:forEach var="post" items="${myPosts}">
        <div class="post">
        <h3>${post.title}</h3>
        <p><strong>投稿日:</strong> ${post.createdAt}</p>
        <p><strong>場所:</strong> ${post.pref} / ${post.city}</p>
        <p><strong>タグ:</strong> ${post.tag}</p>
        <p>${post.content}</p>
        </div>
    </c:forEach>
    <a href="OnboardRegist">
        <button type="button">掲示板投稿へ</button>
    </a>
</main>
<footer>
	<%@ include file="/WEB-INF/jsp/footer.jsp" %>
</footer>
</body>
</html>