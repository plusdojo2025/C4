<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>検索結果</title>
<style>
body {
	font-family: sans-serif;
	padding: 2em;
}

.post {
	border-bottom: 1px solid #ccc;
	padding: 1em 0;
}

.post h3 {
	margin: 0 0 0.5em;
}

.post p {
	margin: 0.2em 0;
}

button {
	margin-top: 2em;
}
/* === ページ全体ベース === */
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
}

a {
	color: #46B1E1;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
	color: #286e93;
}

h1, h2, h3, h4, h5 {
	color: #46B1E1;
	margin-top: 1em;
	margin-bottom: .7em;
	font-weight: bold;
}

label, .label {
	color: #22292F;
	font-weight: bold;
}

.liked {
	color: #ec8888;
	font-weight: bold;
}
</style>
</head>
<body>

	<h1>検索結果一覧</h1>

	<c:if test="${empty postsList}">
		<p>該当する投稿が見つかりませんでした。</p>
	</c:if>

	<c:forEach var="post" items="${postsList}">
		<div class="post" data-post-id="${post.id}">
			<h3>${post.title}</h3>
			<p>${post.content}</p>
			<p>
				<strong>場所:</strong> ${post.pref} / ${post.city}
			</p>
			<p>
				<strong>タグ:</strong> ${post.tag}
			</p>
			<p>
				<strong>投稿日:</strong> ${post.createdAt}
			</p>
			<div>
				<button class="likeBtn"
					data-liked="${post.likedByCurrentUser ? 'true' : 'false'}">${post.likedByCurrentUser ? "いいね解除" : "いいね"}</button>
				<span class="likeCount">${post.likeCount}</span>件 <span
					class="likeUsers"> <c:forEach var="name"
						items="${post.likedUsers}" varStatus="status">
    ${name}<c:if test="${!status.last}">, </c:if>
					</c:forEach>
				</span>

			</div>
		</div>
	</c:forEach>

	<button onclick="location.href='OnboardSearch'">検索に戻る</button>
	<button onclick="location.href='OmoiyalinkHome'">ホームへ戻る</button>

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
