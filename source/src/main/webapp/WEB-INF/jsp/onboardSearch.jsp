<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>投稿検索</title>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background: #FFFEEF;
	color: #22292F;
	font-family: 'メイリオ', 'Meiryo', sans-serif;
	font-size: 20px;
	line-height: 1.8;
}

/* 高コントラストモード */
body.high-contrast {
	background: #000 !important;
	color: #FFF !important;
}
body.high-contrast input,
body.high-contrast select,
body.high-contrast textarea {
	background: #000 !important;
	color: #FFF !important;
	border-color: #FFF !important;
}
body.high-contrast a,
body.high-contrast label {
	color: #0FF !important;
}

form {
	max-width: 880px;
	margin: 0 auto;
	padding: 2em;
}

.sub-header {
	background-color: #46B1E1;
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 0;
}

.sub-header h2 {
	margin: 0;
	font-size: 2.4rem;
	text-align: center;
}

label {
	display: block;
	margin-top: 1em;
	color: #22292F;
	font-weight: bold;
	font-size: 1.6em;
}

input[type="text"], textarea, select {
	width: 100%;
	padding: 1em;
	font-size: 1.3em;
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

.checkbox-group {
	margin-top: 0.5em;
	display: flex;
	flex-wrap: wrap;
	gap: 2em;
}

.checkbox-group label {
	font-size: 1.5em;
	display: inline-flex;
	align-items: center;
}

button, .btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 0.8em 2em;
	cursor: pointer;
	font-size: 1.5em;
	font-family: inherit;
	transition: background 0.22s;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

button:hover, .btn:hover {
	background: #2d7ea3;
}

.button-row {
	display: flex;
	gap: 1.5em;
	flex-wrap: wrap;
	margin-top: 2em;
	justify-content: center;
}

.font-resize-buttons,
.contrast-toggle {
	display: flex;
	justify-content: center;
	gap: 1em;
	margin: 1.2em 0;
}

.font-resize-buttons button,
.contrast-toggle button {
	font-size: 1.3em;
	padding: 0.8em 1.6em;
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.2s;
}

.font-resize-buttons button:hover,
.contrast-toggle button:hover {
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

.right-bottom-buttons {
  display: flex;
  flex-direction: column;
  gap: 10px;
  justify-content: flex-start;
  align-items: flex-end;
  margin-left: auto;
  margin-top: 2em;
}
</style>
</head>
<body>

<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div class="sub-header">
	<h2>検索フォーム</h2>
</div>

<!-- フォントサイズ変更 + 高コントラスト -->
<div class="font-resize-buttons">
	<button onclick="resizeText(20)">標準</button>
	<button onclick="resizeText(28)">大</button>
	<button onclick="resizeText(36)">特大</button>
</div>



<form action="OnboardSearch" method="post">
	<!-- タグ -->
	<label>タグ（複数選択可）</label>
	<div class="checkbox-group">
		<label><input type="checkbox" name="tags" value="運動"> 運動</label>
		<label><input type="checkbox" name="tags" value="集会"> 集会</label>
		<label><input type="checkbox" name="tags" value="お裾分け"> お裾分け</label>
		<label><input type="checkbox" name="tags" value="日記"> 日記</label>
	</div>

	<!-- 都道府県と市区町村 -->
	<div class="location-row">
		<div class="location-item">
			<label for="pref">都道府県</label>
			<select id="pref" name="pref">
				<option value="">選択してください</option>
			</select>
		</div>

		<div class="location-item">
			<label for="city">市区町村</label>
			<select id="city" name="city" disabled>
				<option value="">都道府県を選んでください</option>
			</select>
		</div>
	</div>

	<!-- 検索ボタン -->
	<div class="button-row">
		<button type="submit">検索</button>
	</div>
</form>

<!-- 右下固定ボタン -->
<div class="right-bottom-buttons">
  <a href="OnboardRegist"><button type="button" class="btn">投稿へ移動</button></a>
  <a href="OmoiyalinkMyPost"><button type="button" class="btn">マイ投稿へ移動</button></a>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp"%>

<script>
const PREF_CITY = {
	"北海道": ["札幌市", "函館市", "旭川市"],
	"東京都": ["千代田区", "中央区", "港区", "新宿区", "世田谷区", "八王子市", "町田市"],
	"大阪府": ["大阪市", "堺市", "東大阪市"]
	// 必要に応じて他県も追加可能
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
		citySelect.innerHTML = '<option value="">市区町村を選んでください</option>';
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

// フォントサイズ変更
function resizeText(size) {
	document.body.style.fontSize = size + 'px';
}


</script>
</body>
</html>
