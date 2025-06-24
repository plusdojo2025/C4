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
    color: #22292F;       /* 薄めの黒（ややグレー系：#22292F*/
    font-family: 'メイリオ', 'Meiryo', 'sans-serif';
    font-size: 17px;
    line-height: 1.8;
   	 background-image: url('<%=request.getContextPath()%>/img/IMG_5589.jpeg');
    background-position: center 21px ;
}


h1 {
	font-size: 2em;
	color: #fff;
	margin-bottom: 18px;
	text-align: center;
	background: #46B1E1;
	margin-top: 0;
	margin-bottom:70px;
}

.result-box {
	background:#EFEFEF;
	border-left: 7px solid #F4B5B2;
	padding: 22px 30px;
	margin-bottom: 10px;
	border-radius: 9px;
	font-size: 1.23em;
	text-align: center;
}
.button-row {
	margin-top: 36px;
	margin-left: 120px;

	display: flex;
	gap: 22px;
	flex-wrap: wrap;
	
}

button, .menu-btn {
	padding: 13px 32px;
	padding-left: 30px;
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
}

button:hover, .menu-btn:hover {
	background:#46B1E1;
}

.saveMsg {
	color: #FFF;
	font-size: 1.05em;
	margin-bottom: 8px;
	text-align: center;
}




</style>


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
