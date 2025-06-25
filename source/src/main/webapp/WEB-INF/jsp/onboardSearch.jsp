<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>投稿検索</title>
<style>
body {
	margin: 0;
	padding: 0;
	padding-top: 100px;
	color: #041117;
	font-family: 'Noto Sans JP', sans-serif;
	background: #FFFEEF;
}

header {
	width: 100%;
	height: 100px;
	background: #FFFEEF;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding-left: 30px;
	padding-right: 30px;
	position: fixed;
	top: 0;
	box-sizing: border-box;
	z-index: 100;
}

#logo img {
	width: 120px;
	height: 100px;
	object-fit: contain;
}
.header-button-row {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 2em;
	margin-top: 1em;
	flex-wrap: wrap;
}


.header-button-row .font-resize-buttons button,
.header-button-row .post-buttons button {
	font-size: 1.6rem;
	padding: 1.0em 1.5em;
}

ul#nav {
	list-style: none;
	display: flex;
	margin: 0;
	padding: 0;
}

ul#nav li {
	display: inline-block;
}

ul#nav li a {
	font-size: 1.3rem;
	padding: 10px 15px;
	color: #46B1E1;
	text-decoration: none;
	font-weight: bold;
	white-space: nowrap;
	display: flex;
	align-items: center;
	transition: background 0.16s;
	border-radius: 10px;
}

ul#nav li a:hover {
	background: #ecf6fc;
}

@media (max-width: 700px) {
	ul#nav {
		overflow-x: auto;
		white-space: nowrap;
		-webkit-overflow-scrolling: touch;
		width: 100vw;
		margin-right: -30px;
		margin-left: -30px;
		padding-left: 30px;
		padding-right: 30px;
	}
	ul#nav li a {
		font-size: 1.05rem;
		padding: 10px 10px;
	}
}

ul#nav::-webkit-scrollbar { display: none; }
ul#nav { scrollbar-width: none; -ms-overflow-style: none; }

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

/*画面遷移ボタン*/
.button-center {
	text-align: center;
	margin-top: 18px;
	margin-bottom: 5px;
}
.seni {
	display: inline-block;
	background: #A9C9E1;
	color: #22292F;
	text-decoration: none;
	border-radius: 9px;
	padding: 0.6em 1.7em;
	margin-bottom: 22px;
	margin-top: 8px;
	font-size: 1em;
	font-weight: bold;
	transition: background 0.2s;
	text-decoration: none !important;
}
.seni:hover {
	background: #7BA9C9;
	color: #fff;
	text-decoration: none !important;
}

/* 新しいコントロール行のスタイル */
.post-controls {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 2em auto;
	max-width: 880px;
	flex-wrap: wrap;
	gap: 1.5em;
}

.post-controls .font-resize-buttons {
	display: flex;
	gap: 10px;
}

.post-controls .post-buttons {
	display: flex;
	gap: 15px;
}

header .btn {
	font-size: 4em;
	padding: 1.2em 3em;
}

</style>
</head>
<body>

<%@ include file="/WEB-INF/jsp/header.jsp"%>
<header>
	<h1 id="logo">
		<a href="${pageContext.request.contextPath}/OmoiyalinkHome"> 
			<img src="${pageContext.request.contextPath}/img/logo.png" alt="おもいやリンク">
		</a>
	</h1>
	<ul id="nav">
		<li><a href="${pageContext.request.contextPath}/OmoiyalinkHome"><i class="fa-solid fa-house"></i>&nbsp;ホーム</a></li>
		<li><a href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist"><i class="fa-solid fa-heart-pulse"></i>&nbsp;体調管理</a></li>
		<li><a href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist"><i class="fa-solid fa-capsules"></i>&nbsp;服薬管理</a></li>
		<li><a href="${pageContext.request.contextPath}/OnboardSearch"><i class="fa-solid fa-comments"></i>&nbsp;掲示板</a></li>
		<li><a href="?logout=1"><i class="fa-solid fa-right-from-bracket"></i>&nbsp;ログアウト</a></li>
	</ul>
</header>


<div class="sub-header">
	<h2>検索フォーム</h2></div>
	<div class="header-button-row">
		<div class="font-resize-buttons">
			<button onclick="resizeText(20)">標準</button>
			<button onclick="resizeText(28)">大</button>
			<button onclick="resizeText(36)">特大</button>
		</div>
		<div class="button-center">
			<a class="seni" href="OnboardRegist"><button type="button" class="btn">投稿へ移動</button></a>
			<a class="seni" href="OmoiyalinkMyPost"><button type="button" class="btn">マイ投稿へ移動</button></a>
		</div>
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


<%@ include file="/WEB-INF/jsp/footer.jsp"%>

<script>
const PREF_CITY = {
	"北海道": ["札幌市", "函館市", "旭川市"],
	"東京都": ["千代田区", "中央区", "港区", "新宿区", "世田谷区", "八王子市", "町田市"],
	"大阪府": ["大阪市", "堺市", "東大阪市"]
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
