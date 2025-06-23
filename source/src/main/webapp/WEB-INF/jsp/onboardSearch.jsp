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
	font-size: 2rem;
	text-align: center;
}

label {
	display: block;
	margin-top: 1em;
	color: #22292F;
	font-weight: bold;
	font-size: 28px;
}

input[type="text"], textarea, select {
	width: 98%;
	padding: 1em;
	font-size: 1.2em;
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
	font-size: 30px;
	display: inline-flex;
	align-items: center;
}

button, .btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 0.65em 1.6em;
	margin: 6px 0;
	cursor: pointer;
	font-size: 1.4em;
	font-family: inherit;
	transition: background 0.22s;
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

.font-resize-buttons {
	display: flex;
	justify-content: flex-start;
	gap: 0.5em;
	margin-top: 1em;      /* ← 上にスペース追加 */
	margin-bottom: 1em;
}



.font-resize-buttons button {
	font-size: 1.3em;
	padding: 1.0em 1.6em;
	background: #46B1E1;      
	color: #fff;              
	border: none;
	border-radius: 6px;
	cursor: pointer;
	margin: 0 0.5em;
	transition: background 0.2s;
}

.font-resize-buttons button:hover {
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
  align-items: flex-end;  /* 右寄せ */
  margin-left: auto;      
   margin-top: -100px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div class="sub-header">
	<h2>検索フォーム</h2>
</div>

<div class="font-resize-buttons">
	<button onclick="resizeText(50)">文字を大きく</button>
	<button onclick="resizeText(17)">元に戻す</button>
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

	<!-- ボタン -->
	<div class="button-row">
		<button type="submit">検索</button>
	</div>
</form>


<div class="right-bottom-buttons">
  <a href="OnboardRegist"><button type="button" class="side-button">投稿へ移動</button></a>
  <a href="OmoiyalinkMyPost"><button type="button" class="side-button">マイ投稿へ移動</button></a>
</div>













<%@ include file="/WEB-INF/jsp/footer.jsp"%>

<script>
const PREF_CITY = {
	"北海道": ["札幌市", "函館市", "旭川市"],
	"東京都": ["千代田区", "中央区", "港区"],
	"大阪府": ["大阪市", "堺市", "東大阪市"]
	// 必要に応じて残りも追加
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

function resizeText(size) {
	document.body.style.fontSize = size + 'px';
}
</script>
</body>
</html>
