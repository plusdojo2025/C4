<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>検索結果</title>
    <style>
        body { font-family: sans-serif; padding: 2em; }
        .post { border-bottom: 1px solid #ccc; padding: 1em 0; }
        .post h3 { margin: 0 0 0.5em; }
        .post p { margin: 0.2em 0; }
        button { margin-top: 2em; }
        /* === ページ全体ベース === */
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

a { color: #46B1E1; text-decoration: none; }
a:hover { text-decoration: underline; color: #286e93; }

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
    <p><strong>場所:</strong> ${post.pref} / ${post.city}</p>
    <p><strong>タグ:</strong> ${post.tag}</p>
    <p><strong>投稿日:</strong> ${post.createdAt}</p>

    <form class="likeForm" action="ReactionsServlet" method="post">
      <input type="hidden" name="id" value="${post.id}">
      <input type="hidden" name="type" value="LIKE">
      <button type="submit">いいね</button>
    </form>
  </div>
</c:forEach>

<button onclick="location.href='OnboardSearch'">検索に戻る</button>
<button onclick="location.href='OmoiyalinkHome'">ホームへ戻る</button>

</body>
<script>
document.querySelectorAll(".likeForm").forEach(form => {
  form.addEventListener("submit", function(event) {
    event.preventDefault();  // フォームの通常送信を止める

    const formData = new FormData(form);
    const action = form.action;
    const method = form.method;

    fetch(action, {
      method: method,
      body: formData,
      credentials: "same-origin"  // セッション維持のため
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "ok") {
        // 例: ボタンの色を変える、テキストを変えるなど
        const button = form.querySelector("button");
        button.textContent = "いいね済み";
        button.disabled = true;
      } else {
        alert("いいね登録に失敗しました");
      }
    })
    .catch(error => {
      console.error("通信エラー:", error);
      alert("通信エラーが発生しました");
    });
  });
});
</script>

</html>