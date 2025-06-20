<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>おもいやリンク ホーム</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<style>
body {
	font-family: 'メイリオ', sans-serif;
	background: #f9fafb;
}

.container {
	width: 98%;
	max-width: 540px;
	margin: 44px auto;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 2px 20px #eef1f4;
	padding: 36px 18px 44px 18px;
}

.container h2 {
	margin: 10px 0 28px 0;
	font-size: 1.5em;
	color: #2666b5;
}

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

.menu-area {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 24px;
	margin-top: 22px;
}

.menu-btn {
	width: 150px;
	height: 150px;
	background: #f0f6ff;
	border-radius: 18px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	color: #204078;
	font-size: 1.2em;
	box-shadow: 0 2px 8px #e7eef7;
	transition: background 0.18s, box-shadow 0.15s;
}

.menu-btn:hover {
	background: #e0eaff;
	color: #3a66a7;
	box-shadow: 0 4px 16px #b9d6ff;
}

.menu-btn i {
	font-size: 2.6em;
	margin-bottom: 16px;
}

/*iframeのスタイル*/
.iframe-area {
	margin-top: 40px;
	display: flex;
	justify-content: center;
}

iframe.braintra {
	width: 100%;
	max-width: 520px;
	height: 480px;
	border: 2px solid #46B1E1;
	border-radius: 12px;
	background: #fff;
	box-shadow: 0 1px 8px #cce7fa;
}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="sub-header">
		<h2>ホーム</h2>
	</div>
	<div class="container">
		<h2>
			ようこそ、<span style="color: #3275be;"><c:out value="${userName}" /></span>
			さん
		</h2>

		<div class="menu-area">
			<a class="menu-btn"
				href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist">
				<i class="fa-solid fa-heart-pulse"></i> 体調管理
			</a> <a class="menu-btn"
				href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist"> <i
				class="fa-solid fa-capsules"></i> 服薬管理
			</a> <a class="menu-btn"
				href="${pageContext.request.contextPath}/OnboardSearch"> <i
				class="fa-solid fa-comments"></i> 掲示板
			</a>
			<!-- 脳トレボタンは一旦非表示にしてみた
			<a class="menu-btn"
				href="${pageContext.request.contextPath}/OmoiyalinkBrainTra"> <i
				class="fa-solid fa-brain"></i> 脳トレ
			</a>
			-->
		</div>
		<div class="iframe-area">
			<iframe class="braintra"
				src="${pageContext.request.contextPath}/OmoiyalinkBrainTra"
				title="脳トレ"></iframe>

		</div>
	</div>
</body>