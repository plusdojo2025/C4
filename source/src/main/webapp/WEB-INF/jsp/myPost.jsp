<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>マイ投稿</title>
<style>
.sub-header {
	background-color: #46B1E1;
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 0;
}

.sub-header h2 {
	margin: 0;
	font-size: 2.4rem;
	text-align: center;
}

body {
	margin: 0;
	padding: 0;
	padding-top: 100px;
	color: #041117;
	font-family: 'Noto Sans JP', sans-serif;
	background: #FFFEEF;
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

.likeBtn {
	background-color: #46B1E1;
	color: white;
	padding: 0.6em 1.4em;
	border: none;
	border-radius: 6px;
	font-size: 1.2em;
	cursor: pointer;
	transition: background 0.16s;
}

.likeBtn:hover {
	background-color: #2d7ea3;
}

.likeCount {
	margin-left: 10px;
	margin-right: 10px;
	font-weight: bold;
}

.likeUsers {
	color: #646060;
	font-size: 0.95em;
	margin-left: 8px;
}

.nav-buttons {
	position: fixed;
	bottom: 150px; /* ← ここがフッターとかぶらないための余白 */
	right: 20px;
	z-index: 1000;
}

/* ボタン共通 */
/* ボタン共通（大きめバージョン） */
button, .btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 1.0em 3.0em; /* ← 少し大きめに */
	margin: 6px 0;
	cursor: pointer;
	font-size: 2.0em; /* ← フォントサイズもUP */
	font-family: inherit;
	transition: background 0.22s;
}

button:hover, .btn:hover {
	background: #2d7ea3;
	color: #fff;
}

/*画面遷移ボタン*/
.button-center {
	text-align: center;
	margin-top: 18px;
	margin-bottom: 5px;
}

.seni {
	display: inline-block;
	background: #A9C9E1;
	color: #22292F;
	text-decoration: none;
	border-radius: 9px;
	padding: 0.6em 1.7em;
	margin-bottom: 22px;
	margin-top: 8px;
	font-size: 1em;
	font-weight: bold;
	transition: background 0.2s;
	text-decoration: none !important;
}

.seni:hover {
	background: #7BA9C9;
	color: #fff;
	text-decoration: none !important;
}

.vertical-right {
	position: fixed;
	top: 200px; /* 必要に応じて調整。ヘッダーにかぶらない位置 */
	left: 20px;
	display: flex;
	flex-direction: column; /* ← 縦並びにする */
	gap: 10px; /* ボタン同士の間隔 */
	z-index: 1000;
}
/* 削除ボタンの設定 */
.delete-area {
	float: right; /* 右端に寄せる */
	margin-left: 24px;
}

.deleteBtn {
	background: #FF6368;
	color: #fff;
	padding: 0.2em 0.65em;
	border-radius: 7px;
	border: none;
	cursor: pointer;
	transition: background 0.18s;
}

.deleteBtn:hover {
	background: #d82d3a;
}

.control-bar {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 30px; /* ボタン間のスペース */
	margin: 20px auto;
	flex-wrap: wrap;
}

.font-size-buttons-inline button, .post-button-inline .btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 8px;
	padding: 1.3em 1.8em;
	cursor: pointer;
	transition: background 0.2s;
}

.font-size-buttons-inline button:hover, .post-button-inline .btn:hover {
	background-color: #2d7ea3;
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
		<!-- サブヘッダーのすぐ下 -->
		<div class="control-bar">
			<div class="font-size-buttons-inline">
				<button onclick="changeFontSize(20)">標準</button>
				<button onclick="changeFontSize(28)">大</button>
				<button onclick="changeFontSize(36)">特大</button>
			</div>


			<div class="button-center">
				<a class="seni" href="OnboardRegist">投稿する</a> <a class="seni"
					href="OnboardSearch">検索する</a>
			</div>
		</div>


		<c:if test="${empty myPosts}">
			<p class="empty-message">該当する投稿が見つかりませんでした。</p>
		</c:if>

		<c:forEach var="post" items="${myPosts}">
			<div class="post" data-post-id="${post.id}">
				<h3>${post.title}</h3>
				<p>
					<strong>場所: ${post.pref} / ${post.city}</strong>
				</p>
				<p>
					<strong>タグ: ${post.tag}</strong>
				</p>
				<p>
					<strong>投稿内容：</strong><br>
					<span style="white-space: pre-wrap; word-break: break-all;"><c:out
							value="${fn:replace(post.content, '&#10;', '<br>')}"
							escapeXml="false" /> </span>
				</p>


				<p>
					<strong>投稿日:</strong>
					<fmt:formatDate value="${post.createdAt}" pattern="yyyy/M/d H:mm" />
				</p>
				<div>
					<button class="likeBtn"
						data-liked="${post.likedByCurrentUser ? 'true' : 'false'}">
						${post.likedByCurrentUser ? "いいね解除" : "いいね"}</button>
					<span class="likeCount">${post.likeCount}件</span> <span
						class="likeUsers"> <c:forEach var="name"
							items="${post.likedUsers}" varStatus="status">
            				${name}
            					<c:if test="${!status.last}">, </c:if>
						</c:forEach>
					</span><span class="delete-area">
						<form method="post" style="display: inline;">
							<input type="hidden" name="deletePostId" value="${post.id}" />
							<button type="submit" class="deleteBtn"
								onclick="return confirm('本当に削除しますか？');">削除</button>
						</form>
					</span>

				</div>
			</div>
		</c:forEach>
	</main>

	<footer>
		<%@ include file="/WEB-INF/jsp/footer.jsp"%>
	</footer>

	<script>
  // フォントサイズ切り替え
  function changeFontSize(size) {
    document.body.style.fontSize = size + "px";
  }
  // いいねボタン即時反映
	// いいねボタン即時反映
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
        div.querySelector(".likeCount").textContent = data.count + "件";;
        div.querySelector(".likeUsers").textContent = data.users.join("、");
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

