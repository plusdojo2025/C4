<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>検索結果</title>
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
ul#nav::-webkit-scrollbar {
	display: none;
}

ul#nav {
	scrollbar-width: none;
	-ms-overflow-style: none;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	font-family: 'メイリオ', 'Meiryo', sans-serif;
	font-size: 20px;
	line-height: 1.8;
	background: #FFFEEF;
	color: #22292F;
}

body.high-contrast {
	background: #000 !important;
	color: #FFF !important;
}

body.high-contrast .post, body.high-contrast input, body.high-contrast button
	{
	background: #000 !important;
	color: #FFF !important;
	border-color: #FFF !important;
}

body.high-contrast a {
	color: #0ff !important;
}

h1 {
	text-align: center;
	color: #46B1E1;
	font-size: 2.2em;
	margin: 1.2em 0;
}

.post {
	background-color: #fff;
	border: 2px solid #ccc;
	border-radius: 10px;
	padding: 2em;
	margin: 1em auto;
	width: 95%;
	max-width: 1000px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.post h3 {
	color: #2a82a2;
	font-size: 1.6em;
	margin-bottom: 0.5em;
}

.post p {
	font-size: 1.1em;
	margin-bottom: 0.5em;
}

.likeForm button {
	background-color: #46B1E1;
	color: white;
	padding: 0.6em 1.4em;
	border: none;
	border-radius: 6px;
	font-size: 1.2em;
	cursor: pointer;
}

.likeForm button:hover {
	background-color: #2d7ea3;
}

.nav-buttons {
	position: fixed;
	bottom: 20px; /* 画面下からの距離 */
	right: 20px; /* 画面右からの距離 */
	display: flex;
	flex-direction: column; /* 縦並びに変更（必要に応じて） */
	gap: 12px;
	z-index: 1000;
}

.nav-buttons button {
	font-size: 1.6em; /* ← 大きくする */
	padding: 0.8em 2em; /* ← 高さと幅を広げる */
	background-color: #46B1E1;
	color: white;
	border: none;
	border-radius: 12px;
	cursor: pointer;
	transition: background 0.22s, transform 0.1s;
}

.nav-buttons button:hover {
	background-color: #2d7ea3;
	transform: scale(1.05);
}

.nav-buttons button:hover {
	background-color: #2d7ea3;
}

.nav-buttons button:hover {
	background-color: #2d7ea3;
}

.empty-message {
	font-size: 1.4em;
	margin-top: 2em;
	color: #555;
	text-align: center;
}

.font-size-buttons {
	display: flex;
	justify-content: center;
	margin: 1.5em 0;
	gap: 10px;
}

.font-size-buttons button, .contrast-toggle button {
	font-size: 1.2em;
	padding: 0.5em 1em;
	border-radius: 6px;
	border: none;
	cursor: pointer;
}

.contrast-toggle {
	text-align: center;
	margin-bottom: 1.5em;
}

.contrast-toggle button {
	background-color: #333;
	color: #fff;
}

.contrast-toggle button:hover {
	background-color: #555;
}

.fixed-font-buttons {
	position: fixed;
	bottom: 120px; /* ← かぶらないように下からの距離を長くする */
	right: 20px;
	z-index: 1000;
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.fixed-font-buttons button {
	font-size: 1.6em; /* ← 大きくする */
	padding: 0.8em 1.6em; /* ← 高さと幅を増す */
	border-radius: 12px; /* ← 丸み強調 */
	border: none;
	cursor: pointer;
	background-color: #46B1E1;
	color: white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
	transition: background 0.2s, transform 0.1s;
}

.fixed-font-buttons button:hover {
	background-color: #2d7ea3;
	transform: scale(1.05); /* ← ホバー時に少し拡大 */
}

.gotop {
	text-align: center;
}

.copyright {
	margin-top: 20px;
	margin-bottom: 0;
	padding-top: 75px;
	padding-bottom: 75px;
	background-color: #46B1E1;
	color: #FFFEEF;
	text-align: center;
	font-size: 1.3rem;
}
 .sub-header {
  background-color: #46B1E1;
  color: #FFFEEF;
  padding: 15px 30px;
  margin-top: 100px; /* ← ここを追加！ */
  text-align: center;
}


  .sub-header h2 {
    margin: 0;
    font-size: 2.4rem;
  }

.search-controls {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 20px;
  margin-bottom: 2em;
}

.search-controls .font-size-buttons button,
.search-controls .nav-buttons-inline button {
  font-size: 1.6em;
  padding: 1.0em 1.5em;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  background-color: #46B1E1;
  color: white;
  transition: background 0.2s;
}

.search-controls .font-size-buttons button:hover,
.search-controls .nav-buttons-inline button:hover {
  background-color: #2d7ea3;
}

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
	<!-- ヘッダここまで -->
	<!-- メイン -->
	<main>
	<div class="sub-header">
	<h2>検索結果一覧</h2>
	</div>

<div class="search-controls">
  <div class="font-size-buttons">
    <button onclick="document.body.style.fontSize='20px'">標準</button>
    <button onclick="document.body.style.fontSize='28px'">大</button>
    <button onclick="document.body.style.fontSize='36px'">特大</button>
  </div>
  <div class="nav-buttons-inline">
    <button onclick="location.href='OnboardSearch'">検索に戻る</button>
    <button onclick="location.href='OmoiyalinkHome'">ホームへ戻る</button>
  </div>
</div>


		

		<c:if test="${empty postsList}">
			<p class="empty-message">該当する投稿が見つかりませんでした。</p>
		</c:if>

		<c:forEach var="post" items="${postsList}">
			<div class="post" data-post-id="${post.id}">
				<h3>${post.title}</h3>
				<p>
					<strong>投稿者:</strong> ${post.userName}
				</p>				
				<p>
					<strong>場所:</strong> ${post.pref} / ${post.city}
				</p>
				<p>
					<strong>タグ:</strong> ${post.tag}
				</p>
				<p>
					${post.content}
				</p>
				<p>
					<strong>投稿日:</strong> ${post.createdAt}
				</p>
				<div>
					<!-- いいねボタンと件数・ユーザーリストをclass付きで配置！ -->
					<button class="likeBtn"
						data-liked="${post.likedByCurrentUser ? 'true' : 'false'}">
						${post.likedByCurrentUser ? "いいね解除" : "いいね"}</button>
					<span class="likeCount">${post.likeCount}件</span> <span
						class="likeUsers"> <c:forEach var="name"
							items="${post.likedUsers}" varStatus="status">
            				${name}<c:if test="${!status.last}">, </c:if>
						</c:forEach>
					</span>
				</div>
			</div>
		</c:forEach>
	</main>
	<!-- メインここまで -->
	<!-- フッター -->
	<footer>
		<div class="gotop">
			<a href="#top"><img src="img/gotop.svg" alt="ページトップへ戻る"></a>
		</div>
		<p class="copyright">&copy; Collect Force Inc.</p>
	</footer>
	<!-- フッターここまで -->

	<script>
document.querySelectorAll(".likeBtn").forEach(btn => {
  btn.addEventListener("click", function() {
    const div = btn.closest(".post");
    const postId = div.dataset.postId;
    const liked = btn.getAttribute("data-liked") === "true";
    fetch("ReactionsServlet", {
      method: "POST",
      credentials: "same-origin",
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: "postId=" + encodeURIComponent(postId) + "&action=" + (liked ? "unlike" : "like")
    })
    .then(r => r.json())
    .then(data => {
      if (data.status === "ok") {
        btn.textContent = data.liked ? "いいね解除" : "いいね";
        btn.setAttribute("data-liked", data.liked);
        div.querySelector(".likeCount").textContent = data.count;
        div.querySelector(".likeUsers").textContent = "（" + data.users.join("、") + "）";
      } else if (data.status === "login_required") {
        alert("ログインしてください");
        location.href = "OmoiyalinkLogin";
      }
    });
  });
});
</script>
</body>
</html>