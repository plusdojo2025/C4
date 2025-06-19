<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ結果発表</title>
<style>
body {
	font-family: 'メイリオ', 'Meiryo', sans-serif;
	background: #f6fcff;
	color: #264;
	padding: 38px;
}

h1 {
	font-size: 2em;
	color: #2692c7;
	margin-bottom: 10px;
}

h2 {
	font-size: 1.2em;
	margin-bottom: 18px;
	color: #187dab;
}

.result-box {
	background: #fff9ed;
	border-left: 7px solid #ffd35b;
	padding: 19px 30px;
	margin-bottom: 18px;
	border-radius: 9px;
	font-size: 1.2em;
	box-shadow: 0 1px 6px #e9c96e44;
}

.detail {
	margin-top: 6px;
	font-size: 1.1em;
}

.count-box {
	margin: 17px 0 27px 0;
	font-size: 1.13em;
	background: #e7f8ff;
	border-radius: 9px;
	display: inline-block;
	padding: 11px 20px;
	color: #1993d1;
	font-weight: bold;
}

.history-box {
	background: #fff;
	border: 1.5px solid #bbe;
	border-radius: 8px;
	margin: 18px 0 24px 0;
	padding: 12px 22px;
	box-shadow: 0 0 8px #eaeaea;
	max-width: 440px;
}

.history-title {
	color: #5370c1;
	font-weight: bold;
	font-size: 1em;
	margin-bottom: 7px;
}

ul.history-list {
	padding-left: 20px;
	margin: 0;
	font-size: 1em;
}

.button-row {
	margin-top: 32px;
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
	margin-bottom: 6px;
	text-decoration: none;
}

button:hover, .menu-btn:hover {
	background: #217fcf;
}
</style>
</head>
<body>
	<h1>結果発表</h1>
	<div class="result-box">
		<strong> <c:choose>
				<c:when test="${not empty result}">
					<c:out value="${result}" />
				</c:when>
				<c:otherwise>
                （結果不明）
            </c:otherwise>
			</c:choose>
		</strong>
		<div class="detail">
			<span>あなた：<c:out value="${userHand}" />
			</span> <span>CPU：<c:out value="${cpuHand}" /></span>
		</div>
	</div>
	<div class="count-box">
		勝利回数：
		<c:out value="${winCount}" />
		回
	</div>

	<c:if test="${not empty history}">
		<div class="history-box">
			<div class="history-title">今回セッション内の履歴</div>
			<ul class="history-list">
				<c:forEach var="rec" items="${history}">
					<li><c:out value="${rec}" /></li>
				</c:forEach>
			</ul>
		</div>
	</c:if>

	<div class="button-row">
		<!-- もう一度プレイ -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTraPlay"
			method="get" style="display: inline;">
			<button type="submit">もう一度プレイ</button>
		</form>
		<!-- 履歴閲覧 -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTraMng"
			method="get" style="display: inline;">
			<button type="submit">履歴閲覧</button>
		</form>
		<!-- メニューへ戻る -->
		<a href="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
			class="menu-btn">メニューへ戻る</a>
	</div>
</body>
</html>
