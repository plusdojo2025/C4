<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>投稿検索</title>
<style>
body {
 font-family: sans-serif; padding: 2em; 
 }
form {
 max-width: 600px; margin: 0 auto;
  }
label { 
display: block; margin-top: 3em;
 }
input[type="text"], select {
 width: 100%; padding: 0.5em;
  }
.checkbox-group {
 margin-top: 0.5em;
  }
.checkbox-group label {
 display: inline-block; margin-right: 1em;
  }
button {
 margin-top: 1em; margin-right: 1em;
  }
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

 

<form action="OnboardSearch" method="post">
	<!-- タグ -->
    <p>タグ（複数選択可）<br>
    <div class="checkbox-group">
        <input type="checkbox" name="tags" value="運動">運動 
       <input type="checkbox" name="tags" value="集会"> 集会
        <input type="checkbox" name="tags" value="お裾分け"> お裾分け
        <input type="checkbox" name="tags" value="日記"> 日記
        
    	<!-- 都道府県 -->
		<label for="pref">都道府県</label>
		<select id="pref" name="pref" onchange="loadCities()">
    		<option value="">選択してください</option>
    		<option value="東京都">東京都</option>
    		<option value="大阪府">大阪府</option>
    		<option value="北海道">北海道</option>
    		<option value="福岡県">福岡県</option>
    		<!-- 他の都道府県も追加 -->
		</select>

		<!-- 市区町村 -->
		<label for="city">市区町村</label>
		<select id="city" name="city">
		    <option value="">都道府県を選択してください</option>
		</select>
	</div>
    <button type="submit">検索</button>
    
    <a href="OnboardRegist">
    <button type="button">投稿へ移動</button>
    </a>
    <a href="OmoiyalinkMyPost">
    <button type="button">マイ投稿へ移動</button>
    </a>
    
</form>
</main>
<%@ include file="/WEB-INF/jsp/footer.jsp" %>

<script>
    // 都道府県に応じた市区町村の選択肢（例）
    const cityData = {
        "東京都": ["新宿区", "渋谷区", "港区"],
        "大阪府": ["大阪市", "堺市", "東大阪市"],
        "北海道": ["札幌市", "函館市", "旭川市"],
        "福岡県": ["福岡市", "北九州市", "久留米市"]
        // 必要に応じて追加
    };

    function loadCities() {
        const prefSelect = document.getElementById("pref");
        const citySelect = document.getElementById("city");
        const selectedPref = prefSelect.value;

        // 一旦市区町村プルダウンをクリア
        citySelect.innerHTML = "<option value=''>選択してください</option>";

        if (selectedPref && cityData[selectedPref]) {
            cityData[selectedPref].forEach(city => {
                const option = document.createElement("option");
                option.value = city;
                option.textContent = city;
                citySelect.appendChild(option);
            });
        }
    }
    
</script>

</body>

</html>

