<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>新規投稿</title>
<style>
.post-controls {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 20px;
	margin: 1.5em 0 2em 0;
	flex-wrap: wrap;
}

.post-controls .font-size-buttons button, .post-controls .my-post-button button
	{
	font-size: 1.6em;
	padding: 1.0em 1.5em;
}

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

body.high-contrast input, body.high-contrast textarea, body.high-contrast select
	{
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

input[type="text"], textarea, select {
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
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
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
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
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

.gotop {
	text-align: center;
}

.copyright {
	margin-top: 20px;
	margin-bottom: 0;
	padding-top: 75px;
	padding-bottom: 75px;
	background-color: #46B1E1;
	color: #FFFEEF;
	text-align: center;
	font-size: 1.3rem;
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
  
  window.addEventListener('DOMContentLoaded', () => {
	    const titleInput = document.getElementById('title');
	    const contentInput = document.getElementById('content');
	    const clientError = document.createElement('div');
	    clientError.className = 'error';
	    titleInput.form.insertBefore(clientError, titleInput.form.firstChild); // フォームの一番上に表示

	    const TITLE_MAX = 100;
	    const CONTENT_MAX = 1000;

	    const updateValidation = () => {
	      const titleLength = titleInput.value.length;
	      const contentLength = contentInput.value.length;

	      let errorMessages = [];

	      // タイトル制限
	      if (titleLength > TITLE_MAX) {
	        titleInput.value = titleInput.value.substring(0, TITLE_MAX);
	        errorMessages.push(`タイトルは${TITLE_MAX}100文字以内で入力してください`);
	      }

	      // 本文制限
	      if (contentLength > CONTENT_MAX) {
	        contentInput.value = contentInput.value.substring(0, CONTENT_MAX);
	        errorMessages.push(`投稿内容は${CONTENT_MAX}1000文字以内で入力してください`);
	      }

	      // 表示更新
	      clientError.innerHTML = errorMessages.join('<br>');
	    };

	    titleInput.addEventListener('input', updateValidation);
	    contentInput.addEventListener('input', updateValidation);
	  });
</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/header.jsp"%>

	<div class="sub-header">
		<h2>投稿フォーム</h2>
	</div>


	<div class="post-controls">
		<div class="font-size-buttons">
			<button onclick="changeFontSize(20)">標準</button>
			<button onclick="changeFontSize(28)">大</button>
			<button onclick="changeFontSize(36)">特大</button>
		</div>
	</div>
	<div class="button-center">
		<a class="seni" href="OmoiyalinkMyPost"> 自分の投稿を見る </a> <a class="seni"
			href="OnboardSearch">検索する</a>
	</div>



	<c:if test="${not empty errorMessage}">
		<div class="error">${errorMessage}</div>
	</c:if>

	<form action="OnboardRegist" method="post" id="postForm">
		<label>タグ（複数選択可） <span style="color: red;">*</span></label>
		<div class="checkbox-group">
			<label><input type="checkbox" name="tags" value="運動">
				運動</label> <label><input type="checkbox" name="tags" value="集会">
				集会</label> <label><input type="checkbox" name="tags" value="お裾分け">
				お裾分け</label> <label><input type="checkbox" name="tags" value="日記">
				日記</label>
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

		<label for="title">タイトル <span style="color: red;">*</span></label> <input
			type="text" id="title" name="title" required maxlength="100">

		<label for="content">投稿内容 <span style="color: red;">*</span></label>
		<textarea id="content" name="content" rows="6" maxlength="1000"
			required></textarea>

		<div class="center-button">
			<button type="submit">投稿する</button>
		</div>
	</form>


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
