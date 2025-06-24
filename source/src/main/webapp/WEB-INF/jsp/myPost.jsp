<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>マイ投稿</title>
  <style>
/* --- スタイルはご提示どおり（省略可） --- */
body {
	margin: 0; padding: 0; padding-top: 100px;
	color: #041117; font-family: 'Noto Sans JP', sans-serif;
	background: #FFFEEF;
}
/* ... 中略（先ほどのCSSを貼付 or 省略でもOK） ... */
.post {
	background-color: #fff;
	border: 2px solid #ccc;
	border-radius: 10px;
	padding: 2em;
	margin: 1em auto;
	width: 95%;
	max-width: 1000px;
	box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
.post h3 { color: #2a82a2; font-size: 1.6em; margin-bottom: 0.5em; }
.post p { font-size: 1.1em; margin-bottom: 0.5em; }
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
.likeBtn:hover { background-color: #2d7ea3; }
.likeCount { margin-left: 10px; margin-right: 10px; font-weight: bold; }
.likeUsers { color: #646060; font-size: 0.95em; margin-left: 8px; }
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

  <div class="font-size-buttons">
    <button onclick="changeFontSize(20)">標準</button>
    <button onclick="changeFontSize(28)">大きめ</button>
    <button onclick="changeFontSize(36)">特大</button>
  </div>

  <c:if test="${empty myPosts}">
    <p class="empty-message">該当する投稿が見つかりませんでした。</p>
  </c:if>

  <c:forEach var="post" items="${myPosts}">
    <div class="post" data-post-id="${post.id}">
      <h3>${post.title}</h3>
      <p><strong>投稿日:</strong> ${post.createdAt}</p>
      <p><strong>場所:</strong> ${post.pref} / ${post.city}</p>
      <p><strong>タグ:</strong> ${post.tag}</p>
      <p>${post.content}</p>
      <div>
        <button class="likeBtn"
          data-liked="${post.likedByCurrentUser ? 'true' : 'false'}">
          ${post.likedByCurrentUser ? "いいね解除" : "いいね"}
        </button>
        <span class="likeCount">${post.likeCount}件</span>
        <span class="likeUsers">
          <c:forEach var="name" items="${post.likedUsers}" varStatus="status">
            ${name}<c:if test="${!status.last}">, </c:if>
          </c:forEach>
        </span>
      </div>
    </div>
  </c:forEach>
</main>

<!-- 右下に固定された投稿ボタン -->
<div class="nav-buttons">
  <a href="OnboardRegist">
    <button type="button">掲示板投稿へ</button>
  </a>
</div>

<footer>
	<%@ include file="/WEB-INF/jsp/footer.jsp" %>
</footer>

<script>
  // フォントサイズ切り替え
  function changeFontSize(size) {
    document.body.style.fontSize = size + "px";
  }
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
          div.querySelector(".likeCount").textContent = data.count + "件";
          div.querySelector(".likeUsers").textContent = data.users.length > 0 ? "（" + data.users.join("、") + "）" : "";
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
