<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>投稿検索</title>
    <style>
        body { font-family: sans-serif; padding: 2em; }
        form { max-width: 600px; margin: 0 auto; }
        label { display: block; margin-top: 1em; }
        input[type="text"], select { width: 100%; padding: 0.5em; }
        .checkbox-group { margin-top: 0.5em; }
        .checkbox-group label { display: inline-block; margin-right: 1em; }
        button { margin-top: 1em; margin-right: 1em; }
    </style>
</head>
<body>

<h1>投稿検索</h1>

<form action="OnboardResult" method="post">
    <!-- 都道府県 -->
    <label for="pref">都道府県</label>
    <input type="text" id="pref" name="pref">

    <!-- 市区町村 -->
    <label for="city">市区町村</label>
    <input type="text" id="city" name="city">

    <!-- タグ -->
    <label>タグ（複数選択可）</label>
    <div class="checkbox-group">
        <label><input type="checkbox" name="tags" value="運動"> 運動</label>
        <label><input type="checkbox" name="tags" value="集会"> 集会</label>
        <label><input type="checkbox" name="tags" value="お裾分け"> お裾分け</label>
        <label><input type="checkbox" name="tags" value="日記"> 日記</label>
    </div>

    <button type="submit">検索</button>
</form>

</body>
</html>
