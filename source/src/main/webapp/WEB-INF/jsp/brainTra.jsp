<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ選択画面</title>

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

h1, h2, h3, h4, h5 {
    color: #fff;
    margin-top: ;
    margin-bottom:px;
    font-weight: bold;
    background: #46B1E1;
}

header {
  width: 100%;
  background: #FFFEEF;
  display: flex; /* ヘッターをページ上部に固定 */
  align-items: center; /* 上下中央に揃える */
  justify-content: space-between; /* 両端に配置 */
  /*padding-left: 30px;*/
  /*padding-right: 30px;*/
  /*position: fixed;*/
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

</style>
</head>

<body>

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

	<h2>後出しじゃんけん</h2>

	<div class="rule">
		<h3>～ルール説明～</h3>
		<ul>
			<li>制限時間は1分間</li>
			<li>表示されている手に<strong>勝つ</strong>手を選ぼう！
			</li>
			<li>手を選択してじゃんけんに勝利を目指そう！</li>
		</ul>
	</div>

	<div class="buttons">
		<!-- POSTでaction="start" を送る -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
			method="post">
			<button type="submit" name="action" value="start">ゲーム開始</button>
		</form>
		<!-- POSTでaction="history" を送る -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
			method="post">
			<button type="submit" name="action" value="history">履歴閲覧</button>
		</form>
	</div>
</body>
</html>
