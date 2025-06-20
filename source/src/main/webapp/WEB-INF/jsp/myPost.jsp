<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>マイ投稿</title>
</head>
<body>
<header>
    <h1>マイ投稿</h1>
</header>
<main>
    <c:if test="${empty myPosts}">
        <p>該当する投稿が見つかりませんでした。</p>
    </c:if>

    <c:forEach var="post" items="${myPosts}">
        <div class="post">
        <h3>${post.title}</h3>
        <p><strong>投稿日:</strong> ${post.createdAT}</p>
        <p><strong>場所:</strong> ${post.pref} / ${post.city}</p>
        <p><strong>タグ:</strong> ${post.tag}</p>
        <p>${post.content}</p>
        </div>
    </c:forEach>
    <a href="OnboardRegist">
        <button type="button">掲示板投稿へ</button>
    </a>
</main>
</body>
</html>