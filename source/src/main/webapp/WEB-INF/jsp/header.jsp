<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  body {
  margin: 0;
  padding: 0;
  padding-top: 100px; /* ← これを追加したよ */
  color: #041117;
  font-family: 'Noto Sans JP', sans-serif;
  background: #FFFEEF;
;
}



header {
  width: 100%;
  height: 100px;
  background: #FFFEEF;
  display: flex; /* ヘッターをページ上部に固定 */
  align-items: center; /* 上下中央に揃える */
  justify-content: space-between; /* 両端に配置 */
  padding-left: 30px;
  padding-right: 30px;
  position: fixed;
  top: 0;
  box-sizing: border-box;
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
 <!-- サブタイトルのCSS　ここまで -->
</style>
</head>

<body>
 <!-- ヘッダー（ここから） -->
<header>
  <h1 id="logo" >
   <a href="${pageContext.request.contextPath}/OmoiyalinkHome">
   <img src="${pageContext.request.contextPath}/img/logo.png"  width="120" height="100" alt="おもいやリンク"></a>
  </h1>
  <ul id="nav">
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkHome">
    			<i class="fa-solid fa-house"></i>ホーム</a></li>
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist">
				<i class="fa-solid fa-heart-pulse"></i>体調管理</a></li>
    <li><a href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist"> <i
				class="fa-solid fa-capsules"></i>服薬管理</a></li>
    <li><a href="${pageContext.request.contextPath}/OnboardRegist">
				<i class="fa-solid fa-comments"></i>掲示板</a></li>
    <!-- <li><a href="${pageContext.request.contextPath}/OmoiyalinkBrainTra"> <i
				class="fa-solid fa-brain"></i> 脳トレ</a></li>-->
    <li><a href="?logout=1">
    			<i class="fa-solid fa-right-from-bracket"></i>ログアウト</a></li>
  </ul>

</header>
  <!-- ヘッダー（ここまで） -->

<!-- サブタイトル 　上のCSSも一緒にこぴぺしてください↓

<div class="sub-header">
  <h2>ページの名前</h2>
</div>

  -->
</body>
</html>