<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>新規投稿</title>
<style>
body {
	font-family: sans-serif;
	padding: 2em;
}

form {
	max-width: 880px;
	margin: 0 auto;
}

label {
	display: block;
	margin-top: 1em;
}

input[type="text"],
textarea,
select {
	width: 98%;
	padding: 1em;
	font-size: 1.2em;
	margin-bottom: 1.2em;
	border: 1px solid #a3cde2;
	border-radius: 8px;  /* 丸角 */
	background: #FFFEF9; /* やさしい白ベース */
	color: #22292F;
	box-sizing: border-box;
}

.checkbox-group {
	margin-top: 0.2em;
}

.checkbox-group label {
	margin-right: 1.5em;
	margin-bottom: 0.8em;
	font-size: 30px; /* ← チェックボックスの文字を大きくしたいなら追加 */
	display: inline-flex;
	align-items: center;
}

.readonly-info {
	background: #f4f4f4;
	padding: 0.5em;
}

.error {
	color: red;
	margin-top: 1em;
}

button {
	margin-top: 1em;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background: #FFFEEF;
	color: #22292F;
	font-family: 'メイリオ', 'Meiryo', 'sans-serif';
	font-size: 20px;
	line-height: 1.8;
}

a {
	color: #46B1E1;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
	color: #286e93;
}

h1, h2, h3, h4, h5 {
	color: #46B1E1;
	margin-top: 1em;
	margin-bottom: .7em;
	font-weight: bold;
}

label, .label {
	color: #22292F;
	font-weight: bold;
	font-size: 28px; 
}



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


button, .btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 0.65em 1.0em;
	margin: 6px 0;
	cursor: pointer;
	font-size: 1.6em;
	font-family: inherit;
	transition: background 0.22s;  
	
	

	
}

button:hover, .btn:hover {
	background: #2d7ea3;
	color: #fff;
}

.sub-header {
	background-color: #46B1E1;
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 0px;
}

.sub-header h2 {
	margin: 0;
	background-color: #46B1E1;
	color: #FFFEEF;
	font-size: 2rem;
	text-align: center;
}







/* ボタンの位置 */
.center-button {
	display: flex;
	justify-content: center;
	margin-top: 2em;
	bottom: 200px; /* ← 少し上に */
	padding: 0.85em 4em; /* ← 少し大きめに */
	font-size: 1.2em; /* ← フォントサイズUP */
}
  
.bottom-right-button {
    position: fixed;
    bottom: 100px; /* ← 少し上に */
    right: 200px;  /* ← 少し左に */
    background: #46B1E1;
    color: #fff;
    border: none;
    border-radius: 9px;
    padding:1.0em 4em; /* ← 少し大きめに */
    cursor: pointer;
    font-size: 1.2em; /* ← フォントサイズ大 */
    font-family: inherit;
    transition: background 0.22s;
    box-shadow: 0px 4px 10px rgba(0,0,0,0.15); /* ← オプション：浮き感を追加 */
}


.bottom-right-button:hover {
    background: #2d7ea3;
}

.location-row {
	display: flex;
	gap: 20px;          /* 都道府県と市区町村の間に余白 */
	margin-top: 1.5em;  /* 少し上にスペース */
	flex-wrap: wrap;    /* スマホ対応：狭い画面で縦並びに戻す */
}

.location-item {
	flex: 1;
	min-width: 250px;   /* 最低幅：画面が狭くても崩れにくい */
}

}

</style>
<script>
	const PREF_CITY = {
		"北海道" : [ "札幌市", "函館市", "旭川市", "小樽市", "帯広市" ],
		"青森県" : [ "青森市", "弘前市", "八戸市" ],
		"岩手県" : [ "盛岡市", "宮古市", "一関市" ],
		"宮城県" : [ "仙台市", "石巻市", "塩竈市" ],
		"秋田県" : [ "秋田市", "能代市", "横手市" ],
		"山形県" : [ "山形市", "米沢市", "鶴岡市" ],
		"福島県" : [ "福島市", "会津若松市", "郡山市" ],
		"茨城県" : [ "水戸市", "日立市", "土浦市" ],
		"栃木県" : [ "宇都宮市", "足利市", "小山市" ],
		"群馬県" : [ "前橋市", "高崎市", "太田市" ],
		"埼玉県" : [ "さいたま市", "川越市", "熊谷市" ],
		"千葉県" : [ "千葉市", "船橋市", "柏市" ],
		"東京都" : [ "千代田区", "中央区", "港区", "新宿区", "世田谷区", "八王子市", "町田市" ],
		"神奈川県" : [ "横浜市", "川崎市", "相模原市", "横須賀市", "藤沢市" ],
		"新潟県" : [ "新潟市", "長岡市", "上越市" ],
		"富山県" : [ "富山市", "高岡市", "魚津市" ],
		"石川県" : [ "金沢市", "小松市", "加賀市" ],
		"福井県" : [ "福井市", "敦賀市", "小浜市" ],
		"山梨県" : [ "甲府市", "富士吉田市", "山梨市" ],
		"長野県" : [ "長野市", "松本市", "上田市" ],
		"岐阜県" : [ "岐阜市", "大垣市", "高山市" ],
		"静岡県" : [ "静岡市", "浜松市", "沼津市" ],
		"愛知県" : [ "名古屋市", "豊橋市", "岡崎市", "一宮市" ],
		"三重県" : [ "津市", "四日市市", "伊勢市" ],
		"滋賀県" : [ "大津市", "彦根市", "長浜市" ],
		"京都府" : [ "京都市", "宇治市", "舞鶴市" ],
		"大阪府" : [ "大阪市", "堺市", "東大阪市" ],
		"兵庫県" : [ "神戸市", "姫路市", "西宮市", "尼崎市" ],
		"奈良県" : [ "奈良市", "大和郡山市", "天理市" ],
		"和歌山県" : [ "和歌山市", "田辺市", "橋本市" ],
		"鳥取県" : [ "鳥取市", "米子市", "倉吉市" ],
		"島根県" : [ "松江市", "出雲市", "浜田市" ],
		"岡山県" : [ "岡山市", "倉敷市", "津山市" ],
		"広島県" : [ "広島市", "福山市", "呉市" ],
		"山口県" : [ "山口市", "下関市", "宇部市" ],
		"徳島県" : [ "徳島市", "鳴門市", "阿南市" ],
		"香川県" : [ "高松市", "丸亀市", "坂出市" ],
		"愛媛県" : [ "松山市", "今治市", "新居浜市" ],
		"高知県" : [ "高知市", "四万十市", "宿毛市" ],
		"福岡県" : [ "福岡市", "北九州市", "久留米市" ],
		"佐賀県" : [ "佐賀市", "唐津市", "鳥栖市" ],
		"長崎県" : [ "長崎市", "佐世保市", "諫早市" ],
		"熊本県" : [ "熊本市", "八代市", "天草市" ],
		"大分県" : [ "大分市", "別府市", "中津市" ],
		"宮崎県" : [ "宮崎市", "都城市", "延岡市" ],
		"鹿児島県" : [ "鹿児島市", "霧島市", "薩摩川内市" ],
		"沖縄県" : [ "那覇市", "沖縄市", "浦添市" ]
	};
	window.addEventListener('DOMContentLoaded', function() {
		const prefSelect = document.getElementById('pref');
		const citySelect = document.getElementById('city');
		for ( const pref in PREF_CITY) {
			const option = document.createElement('option');
			option.value = pref;
			option.textContent = pref;
			prefSelect.appendChild(option);
		}
		prefSelect.addEventListener('change', function() {
			const selectedPref = this.value;
			citySelect.innerHTML = '<option value="">市区町村で絞り込む</option>';
			if (PREF_CITY[selectedPref]) {
				citySelect.disabled = false;
				PREF_CITY[selectedPref].forEach(function(city) {
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
	

</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/header.jsp"%>
	<div class="sub-header">
		<h2>投稿フォーム</h2>
	</div>
	
	<button onclick="document.body.style.fontSize='40px'">文字を大きく</button>
	<button onclick="document.body.style.fontSize='17px'">元に戻す</button>

	<c:if test="${not empty errorMessage}">
		<div class="error">${errorMessage}</div>
	</c:if>
	<form action="OnboardRegist" method="post" id="postForm">
		<!-- タグ（複数選択可） -->
		<label>タグ（複数選択可） <span style="color: red;">*</span></label>
		<div class="checkbox-group">
			<label><input type="checkbox" name="tags" value="運動">
				運動</label> <label><input type="checkbox" name="tags" value="集会">
				集会</label> <label><input type="checkbox" name="tags" value="お裾分け">
				お裾分け</label> <label><input type="checkbox" name="tags" value="日記">
				日記</label>
		</div>
		<!-- 都道府県 -->
		<div class="location-row">
  <div class="location-item">
    <label for="pref">都道府県を選択 <span style="color: red;">*</span></label>
    <select id="pref" name="pref" required>
      <option value="">都道府県を選択してください</option>
      <!-- JSで追加 -->
    </select>
  </div>

  <div class="location-item">
    <label for="city">市区町村を選択 <span style="color: red;">*</span></label>
    <select id="city" name="city" required disabled>
      <option value="">市区町村で絞り込む</option>
    </select>
  </div>
</div>

		</select>
		<!-- タイトル -->
		<label for="title">タイトル <span style="color: red;">*</span></label> <input
			type="text" id="title" name="title" required maxlength="100">
		<!-- 内容 -->
		<label for="content">投稿内容 <span style="color: red;">*</span></label>
		<textarea id="content" name="content" rows="6" maxlength="1000"
			required></textarea>
			
		<!-- <button type="submit">投稿する</button>
		<a href="OmoiyalinkMyPost">
			<button type="button">マイ投稿へ移動</button> -->	
			
			
		<!-- 投稿するボタン -->
<div class="center-button">
    <button type="submit">投稿する</button>
</div>
<!-- マイ投稿へ移動ボタン -->
<a href="OmoiyalinkMyPost">
    <button type="button" class="bottom-right-button">マイ投稿へ移動</button>
</a>

	</form>
</body>
</html>
