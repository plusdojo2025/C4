<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>新規投稿</title>
    <style>
        body { font-family: sans-serif; padding: 2em; }
        form { max-width: 600px; margin: 0 auto; }
        label { display: block; margin-top: 1em; }
        input[type="text"], textarea { width: 100%; padding: 0.5em; }
        .checkbox-group { margin-top: 0.5em; }
        .checkbox-group label { display: inline-block; margin-right: 1em; }
        .readonly-info { background: #f4f4f4; padding: 0.5em; }
        .error { color: red; margin-top: 1em; }
        button { margin-top: 1em; }
    </style>
</head>
<body>

<h1>投稿フォーム</h1>

<c:if test="${not empty errorMessage}">
    <div class="error">${errorMessage}</div>
</c:if>

<form action="OnboardRegist" method="post" id="postForm">

    <!-- 都道府県と市区町村は自動表示（読み取り専用） -->
    <label>都道府県</label>
    <div class="readonly-info">${prefecture != null ? prefecture : sessionScope.pref}</div>
    <label>市区町村</label>
    <div class="readonly-info">${city != null ? city : sessionScope.city}</div>

    <!-- hiddenで値をサーバーに送る -->
    <input type="hidden" name="pref" value="${prefecture != null ? prefecture : sessionScope.pref}">
    <input type="hidden" name="city" value="${city != null ? city : sessionScope.city}">

    <!-- タグ（複数選択可） -->
    <label>タグ（複数選択可） <span style="color:red;">*</span></label>
    <div class="checkbox-group">
        <label><input type="checkbox" name="tags" value="運動"> 運動</label>
        <label><input type="checkbox" name="tags" value="集会"> 集会</label>
        <label><input type="checkbox" name="tags" value="お裾分け"> お裾分け</label>
        <label><input type="checkbox" name="tags" value="日記"> 日記</label>
    </div>

    <!-- タイトル -->
    <label for="title">タイトル <span style="color:red;">*</span></label>
    <input type="text" id="title" name="title" required maxlength="100">

    <!-- 内容 -->
    <label for="content">投稿内容 <span style="color:red;">*</span></label>
    <textarea id="content" name="content" rows="6" maxlength="1000" required></textarea>

    <button type="submit">投稿する</button>
    <button type="button" onclick="location.href='OmoiyalinkMyPosts'">マイ投稿へ</button>
   
