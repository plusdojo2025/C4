<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>結果発表</title>
<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    background: #FFFEEF;  /* 背景色指定 */
    color: #22292F;       /* 薄めの黒（ややグレー系：#22292F） */
    font-family: 'メイリオ', 'Meiryo', 'sans-serif';
    font-size: 17px;
    line-height: 1.8;
}

h1 {
	font-size: 2em;
	color: #fff;
	margin-bottom: 18px;
	text-align: center;
	background: #46B1E1;
}

.result-box {
	background: #fff9ed;
	border-left: 7px solid #ffd35b;
	padding: 22px 30px;
	margin-bottom: 22px;
	border-radius: 9px;
	font-size: 1.23em;
	text-align: center;
}

.button-row {
	margin-top: 36px;
	display: flex;
	gap: 22px;
	flex-wrap: wrap;
	
}

button, .menu-btn {
	padding: 13px 32px;
	font-size: 1.1em;
	background: #47aaf2;
	color: #fff;
	border: none;
	border-radius: 9px;
	box-shadow: 0 2px 8px #ccd8f0;
	cursor: pointer;
	transition: background .2s;
	text-decoration: none;
	margin-bottom: 8px;
	text-align: center;
}

button:hover, .menu-btn:hover {
	background:#46B1E1;
}

.saveMsg {
	color: #c24b3b;
	font-size: 1.05em;
	margin-bottom: 8px;
}

html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    background: #FFFEEF;  /* 背景色指定 */
    color: #22292F;       /* 薄めの黒（ややグレー系：#22292F） */
    font-family: 'メイリオ', 'Meiryo', 'sans-serif';
    font-size: 17px;
    line-height: 1.8;
}

header {
  width: 100%;
  background: #FFFEEF;
  display: flex; /* ヘッターをページ上部に固定 */
  align-items: center; /* 上下中央に揃える */
  justify-content: space-between; /* 両端に配置 */
  /*padding-left: 30px;
  padding-right: 30px;
  top: 0;*/
}
ul {
  list-style: none;
  display: flex;
}
ul li a {
  font-size: 1.3rem;
  padding: 10px 15px;
  color: #46B1E1;
  text-decoration: none;
  font-weight: bold;
}
ul li a:hover {
  text-decoration: underline;
}

<!-- サブタイトルのCSS -->
.sub-header {
  background-color: #46B1E1; /* 青色 */
  color: #FFFEEF;
  padding: 15px 30px;
  margin-top: 100px; /* ヘッダーがfixedなので被らないようにする */
}

.sub-header h2 {
  margin: 0;
  font-size: 2rem;
  text-align: center; 
}
</style>

<header>
  <h1 id="logo" >
   <a href="${pageContext.request.contextPath}/OmoiyalinkHome">
   <img src="${pageContext.request.contextPath}/img/logo.png"  width="130" height="100" alt="おもいやリンク"></a>
  </h1>
  <ul id="nav">
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkHome">
    			<i class="fa-solid fa-house"></i>ホーム</a></li>
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist">
				<i class="fa-solid fa-heart-pulse"></i>体調管理</a></li>
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkMedMng"> <i
				class="fa-solid fa-capsules"></i>服薬管理</a></li>
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkOnboardRegist">
				<i class="fa-solid fa-comments"></i>掲示板</a></li>
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkBrainTra"> <i
				class="fa-solid fa-brain"></i> 脳トレ</a></li>
    <li><a href="?logout=1">
    			<i class="fa-solid fa-right-from-bracket"></i>ログアウト</a></li>
  </ul>

</header>
</head>
<body>
	<h1>結果発表</h1>
	<div class="result-box">
		あなたの勝利回数：<strong><c:out value="${winCount}" /></strong> 回
	</div>
	<div class="saveMsg">
		<c:out value="${saveResult}" />
	</div>
	<div class="button-row">
		<!-- リトライ（もう一度プレイ） -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTraPlay"
			method="get" style="display: inline;">
			<button type="submit">リトライ</button>
		</form>
		<!-- 履歴閲覧 -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTraMng"
			method="get" style="display: inline;">
			<button type="submit">履歴閲覧</button>
		</form>
	</div>
</body>
</html>
