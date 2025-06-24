<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>新規投稿</title>
<style>
  body {
    font-family: 'メイリオ', 'Meiryo', sans-serif;
    padding: 2em;
    font-size: 20px;
    line-height: 1.8;
    background: #FFFEEF;
    color: #22292F;
    margin: 0;
    box-sizing: border-box;
    min-height: 100vh;
  }

  body.high-contrast {
    background: #000 !important;
    color: #FFF !important;
  }
  body.high-contrast input,
  body.high-contrast textarea,
  body.high-contrast select {
    background: #000 !important;
    color: #FFF !important;
    border-color: #FFF !important;
  }
  body.high-contrast a {
    color: #0ff !important;
  }

  form {
    max-width: 100%;
    width: 90%;
    margin: 0 auto;
  }

  label, .label {
    display: block;
    font-weight: bold;
    font-size: 1.6em;
    color: #22292F;
    margin-top: 1em;
  }

  input[type="text"],
  textarea,
  select {
    width: 100%;
    padding: 1em;
    font-size: 1.4em;
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

  .checkbox-group label {
    font-size: 1.5em;
    margin-right: 1.5em;
    margin-bottom: 0.8em;
    display: inline-flex;
    align-items: center;
    cursor: pointer;
  }

  .error {
    color: red;
    margin-top: 1em;
    font-size: 1.4em;
  }

  button, .btn {
    background: #46B1E1;
    color: #fff;
    border: none;
    border-radius: 9px;
    padding: 1em 2em;
    margin: 0.5em 0;
    cursor: pointer;
    font-size: 1.6em;
    font-family: inherit;
    transition: background 0.22s;
    box-shadow: 0 2px 5px rgba(0,0,0,0.15);
  }

  button:hover, .btn:hover {
    background: #2d7ea3;
  }

  .sub-header {
    background-color: #46B1E1;
    color: #FFFEEF;
    padding: 15px 30px;
    margin-top: 0;
    text-align: center;
  }

  .sub-header h2 {
    margin: 0;
    font-size: 2.4rem;
  }

  .center-button {
    display: flex;
    justify-content: center;
    margin-top: 2em;
  }

  .bottom-right-button {
    position: fixed;
    bottom: 100px;
    right: 30px;
    background: #46B1E1;
    color: #fff;
    border: none;
    border-radius: 9px;
    padding: 1em 2em;
    cursor: pointer;
    font-size: 1.6em;
    font-family: inherit;
    transition: background 0.22s;
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    z-index: 1000;
  }

  .bottom-right-button:hover {
    background: #2d7ea3;
  }

  .location-row {
    display: flex;
    gap: 20px;
    margin-top: 1.5em;
    flex-wrap: wrap;
  }

  .location-item {
    flex: 1;
    min-width: 250px;
  }

  .font-size-buttons {
    margin: 1em 0;
    display: flex;
    gap: 10px;
    justify-content: center;
  }
  .font-size-buttons button {
    padding: 0.6em 1em;
    font-size: 1.4em;
  }
  .contrast-toggle {
    margin: 1em 0;
    text-align: center;
  }
  .contrast-toggle button {
    padding: 0.6em 1em;
    font-size: 1.4em;
    background: #222;
    color: #fff;
    border-radius: 6px;
    border: none;
    cursor: pointer;
  }
  .contrast-toggle button:hover {
    background: #444;
  }
   .gotop{
    text-align :center;
    }
.copyright{
    margin-top: 20px;
    margin-bottom: 0;
    padding-top: 75px;
    padding-bottom: 75px;
    background-color: #46B1E1;
    color: #FFFEEF;
    text-align: center;
    font-size: 1.3rem;
    }
</style>
<script>
  const PREF_CITY = {
    "北海道": ["札幌市", "函館市", "旭川市", "小樽市", "帯広市"],
    "東京都": ["千代田区", "中央区", "港区", "新宿区", "世田谷区", "八王子市", "町田市"],
    "大阪府": ["大阪市", "堺市", "東大阪市"]
    // 他の都道府県も必要に応じて追加
  };

  window.addEventListener('DOMContentLoaded', function () {
    const prefSelect = document.getElementById('pref');
    const citySelect = document.getElementById('city');

    for (const pref in PREF_CITY) {
      const option = document.createElement('option');
      option.value = pref;
      option.textContent = pref;
      prefSelect.appendChild(option);
    }

    prefSelect.addEventListener('change', function () {
      const selectedPref = this.value;
      citySelect.innerHTML = '<option value="">市区町村で絞り込む</option>';
      if (PREF_CITY[selectedPref]) {
        citySelect.disabled = false;
        PREF_CITY[selectedPref].forEach(function (city) {
          const option = document.createElement('option');
          option.value = city;
          option.textContent = city;
          citySelect.appendChild(option);
        });
      } else {
        citySelect.disabled = true;
      }
    });
  });

  function changeFontSize(size) {
    document.body.style.fontSize = size + 'px';
  }

  function toggleContrast() {
    document.body.classList.toggle('high-contrast');
  }
</script>
</head>
<body>
  <%@ include file="/WEB-INF/jsp/header.jsp" %>

  <div class="sub-header">
    <h2>投稿フォーム</h2>
  </div>

  <div class="font-size-buttons">
    <button onclick="changeFontSize(20)">標準</button>
    <button onclick="changeFontSize(28)">大きめ</button>
    <button onclick="changeFontSize(36)">特大</button>
  </div>


  <c:if test="${not empty errorMessage}">
    <div class="error">${errorMessage}</div>
  </c:if>

  <form action="OnboardRegist" method="post" id="postForm">
    <label>タグ（複数選択可） <span style="color: red;">*</span></label>
    <div class="checkbox-group">
      <label><input type="checkbox" name="tags" value="運動"> 運動</label>
      <label><input type="checkbox" name="tags" value="集会"> 集会</label>
      <label><input type="checkbox" name="tags" value="お裾分け"> お裾分け</label>
      <label><input type="checkbox" name="tags" value="日記"> 日記</label>
    </div>

    <div class="location-row">
      <div class="location-item">
        <label for="pref">都道府県を選択 <span style="color: red;">*</span></label>
        <select id="pref" name="pref" required>
          <option value="">都道府県を選択してください</option>
        </select>
      </div>
      <div class="location-item">
        <label for="city">市区町村を選択 <span style="color: red;">*</span></label>
        <select id="city" name="city" required disabled>
          <option value="">市区町村で絞り込む</option>
        </select>
      </div>
    </div>

    <label for="title">タイトル <span style="color: red;">*</span></label>
    <input type="text" id="title" name="title" required maxlength="100">

    <label for="content">投稿内容 <span style="color: red;">*</span></label>
    <textarea id="content" name="content" rows="6" maxlength="1000" required></textarea>

    <div class="center-button">
      <button type="submit">投稿する</button>
    </div>
  </form>

  <a href="OmoiyalinkMyPost">
    <button type="button" class="bottom-right-button">マイ投稿へ移動</button>
  </a>
  <!-- フッター -->
	<footer>
	<div class="gotop">
        <a href="#top"><img src="img/gotop.svg" alt="ページトップへ戻る"></a>
    </div>	
		<p class="copyright">&copy; Collect Force Inc.</p>
	</footer>
	<!-- フッターここまで -->
</body>
</html>
