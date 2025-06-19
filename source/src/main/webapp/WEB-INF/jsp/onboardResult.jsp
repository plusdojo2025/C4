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
    </style>
</head>
<body>

<h1>検索結果一覧</h1>

<c:if test="${empty postsList}">
    <p>該当する投稿が見つかりませんでした。</p>
</c:if>

<c:forEach var="post" items="${postsList}">
    <div class="post">
        <h3>${post.title}</h3>
        <p>${post.content}</p>
        <p><strong>場所:</strong> ${post.pref} / ${post.city}</p>
        <p><strong>タグ:</strong> ${post.tags}</p>
        <p><strong>投稿日:</strong> ${post.postDate}</p>
    </div>
</c:forEach>

<button onclick="location.href='OnboardSearch'">検索に戻る</button>
<button onclick="location.href='OmoiyalinkHome'">ホームへ戻る</button>

</body>
</html>
