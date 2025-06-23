<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<style>
body {
	margin: 0;
	padding: 0;
	padding-top: 100px; /* ヘッダー分の余白 */
	color: #041117;
	font-family: 'Noto Sans JP', sans-serif;
	background: #FFFEEF;
}

header {
	width: 100%;
	height: 100px;
	background: #FFFEEF;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding-left: 30px;
	padding-right: 30px;
	position: fixed;
	top: 0;
	box-sizing: border-box;
	z-index: 100;
}

#logo img {
	width: 120px;
	height: 100px;
	object-fit: contain;
}

ul#nav {
	list-style: none;
	display: flex;
	margin: 0;
	padding: 0;
	/* ↓通常時はflexで横並び */
	/* ↓狭いときは下の@mediaで上書き */
}

ul#nav li {
	display: inline-block;
}

ul#nav li a {
	font-size: 1.3rem;
	padding: 10px 15px;
	color: #46B1E1;
	text-decoration: none;
	font-weight: bold;
	white-space: nowrap; /* 折り返し防止 */
	display: flex;
	align-items: center;
	transition: background 0.16s;
	border-radius: 10px;
}

ul#nav li a:hover {
	background: #ecf6fc;
}

/* 横幅が狭いときはulに横スクロールを付ける！ */
@media ( max-width : 700px) {
	ul#nav {
		overflow-x: auto;
		white-space: nowrap;
		-webkit-overflow-scrolling: touch;
		width: 100vw;
		margin-right: -30px; /* ヘッダー右padding分で右端も見える */
		margin-left: -30px; /* 左も同様 */
		padding-left: 30px;
		padding-right: 30px;
	}
	ul#nav li {
		display: inline-block;
		margin-right: 0;
	}
	ul#nav li a {
		font-size: 1.05rem;
		padding: 10px 10px;
	}
}

/* スクロールバー消す（スマホではもともと目立たない）*/
ul#nav::-webkit-scrollbar { display: none; }
ul#nav { scrollbar-width: none; -ms-overflow-style: none; }

</style>
</head>
<body>
	<!-- ヘッダー -->
	<header>
		<h1 id="logo">
			<a href="${pageContext.request.contextPath}/OmoiyalinkHome"> <img
				src="${pageContext.request.contextPath}/img/logo.png" alt="おもいやリンク">
			</a>
		</h1>
		<ul id="nav">
			<li><a href="${pageContext.request.contextPath}/OmoiyalinkHome">
					<i class="fa-solid fa-house"></i>&nbsp;ホーム
			</a></li>
			<li><a
				href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist">
					<i class="fa-solid fa-heart-pulse"></i>&nbsp;体調管理
			</a></li>
			<li><a
				href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist">
					<i class="fa-solid fa-capsules"></i>&nbsp;服薬管理
			</a></li>
			<li><a href="${pageContext.request.contextPath}/OnboardSearch">
					<i class="fa-solid fa-comments"></i>&nbsp;掲示板
			</a></li>
			<%-- <li><a href="${pageContext.request.contextPath}/OmoiyalinkBrainTra">
				<i class="fa-solid fa-brain"></i>&nbsp;脳トレ</a></li> --%>
			<li><a href="?logout=1"> <i
					class="fa-solid fa-right-from-bracket"></i>&nbsp;ログアウト
			</a></li>
		</ul>
	</header>

</body>
</html>
