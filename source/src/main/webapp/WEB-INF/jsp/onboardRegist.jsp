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

/* 入力フォーム */
select, textarea {
    width: 98%;
    padding: 0.48em;
    font-size: 1.05em;
    margin-bottom: 1.2em;
    border: 1px solid #a3cde2;
    border-radius: 8px;
    background: #FFFEF9;
    color: #22292F;
    box-sizing: border-box;
}
input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: #46B1E1;
    background: #fcf8f0;  
}

/* ボタン共通 */
button, .btn {
    background: #46B1E1;
    color: #fff;
    border: none;
    border-radius: 9px;
    padding: 0.65em 1.6em;
    margin: 6px 0;
    cursor: pointer;
    font-size: 1em;
    font-family: inherit;
    transition: background 0.22s;
}
button:hover, .btn:hover {
    background: #2d7ea3;
    color: #fff;
}
<!-- サブタイトルのCSS -->
.sub-header {
  background-color: #46B1E1; /* 青色 */
  color: #FFFEEF;
  padding: 15px 30px;
  margin-top: 100px; /* ヘッダーがfixedなので被らないようにする */
}

.sub-header h2 {
  margin: 0;
   background-color: #46B1E1; /* 青色 */
  color: #FFFEEF;
  font-size: 2rem;
  text-align: center; 
}
 <!-- サブタイトルのCSS　ここまで -->
 
</style>
</head>
<main>
<body>


 

<!-- サブタイトル 　上のCSSも一緒にこぴぺしてください↓ -->
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<div class="sub-header">
  <h2>検索</h2>
</div>

    </style>
    
</head>
<body>

<h1>投稿フォーム</h1>

<c:if test="${not empty errorMessage}">
    <div class="error">${errorMessage}</div>
</c:if>

<form action="OnboardRegist" method="post" id="postForm">

    <!-- 都道府県と市区町村は自動表示（読み取り専用） -->
    <!--<label>都道府県</label>
    <div class="readonly-info">${pref != null ? pref : sessionScope.pref}</div>
    <label>市区町村</label>
    <div class="readonly-info">${city != null ? city : sessionScope.city}</div>

    
    <!-- hiddenで値をサーバーに送る -->
    <!-- <input type="hidden" name="pref" value="${pref != null ? pref : sessionScope.pref}">
    <input type="hidden" name="city" value="${city != null ? city : sessionScope.city}">-->
     <!-- 都道府県 -->
    <!--<label for="title">都道府県 <span style="color:red;">*</span></label>
    <input type="text" id="pref" name="pref" required maxlength="100">
    
    
    <!-- タグ（複数選択可） -->
    <label>タグ（複数選択可） <span style="color:red;">*</span></label>
    <div class="checkbox-group">
        <label><input type="checkbox" name="tags" value="運動"> 運動</label>
        <label><input type="checkbox" name="tags" value="集会"> 集会</label>
        <label><input type="checkbox" name="tags" value="お裾分け"> お裾分け</label>
        <label><input type="checkbox" name="tags" value="日記"> 日記</label>
    </div>
 <!--都道府県 -->
    <label for="pref">都道府県 <span style="color:red;">*</span></label>
    <textarea id="pref" name="pref" maxlength="100" required></textarea>
 <!--市区町村 -->
    <label for="city">都道府県 <span style="color:red;">*</span></label>
    <textarea id="city" name="city" maxlength="100" required></textarea>

    <!-- タイトル -->
    <label for="title">タイトル <span style="color:red;">*</span></label>
    <input type="text" id="title" name="title" required maxlength="100">

    <!-- 内容 -->
    <label for="content">投稿内容 <span style="color:red;">*</span></label>
    <textarea id="content" name="content" rows="6" maxlength="1000" required></textarea>

    <button type="submit">投稿する</button>
    
    <a href="OmoiyalinkMyPost">
    <button type="button">マイ投稿へ移動</button>
    </a>
   </form>
   </body>
</html>