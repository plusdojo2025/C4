<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>新規登録</title>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background: #FFFEEF;
	color: #22292F;
	font-family: 'メイリオ', 'Meiryo', 'sans-serif';
	font-size: 17px;
	line-height: 1.8;
}

.sub-header {
	background-color: #46B1E1;
	color: #fff;
	padding: 15px 30px 10px 30px;
}

h2 {
	color: #fff;
	margin: 0;
	font-size: 2rem;
	text-align: center;
	font-weight: bold;
}

label {
	color: #22292F;
	font-weight: bold;
	display: block;
	margin-top: 1em;
	margin-bottom: 0.3em;
}

a {
	color: #46B1E1;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
	color: #286e93;
}

.container {
	max-width: 450px;
	margin: 50px auto;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 2px 18px #eef1f4;
	padding: 34px 18px 44px 18px;
}

input, select, textarea {
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
button {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 9px;
	padding: 0.65em 1.6em;
	margin: 6px 0;
	cursor: pointer;
	font-size: 1em;
	font-family: inherit;
	transition: background 0.18s, box-shadow 0.18s, transform 0.13s;
}

button:hover {
	background: #2d7ea3;
	color: #fff;
}

.error {
	color: #ec8888;
	font-size: 0.95em;
	margin: 1em 0;
	text-align: center;
}
/* レスポンシブ */
@media ( max-width : 600px) {
	html, body {
		font-size: 15px;
	}
	.container {
		max-width: 99vw;
		padding: 6vw 2vw;
	}
	h1, h2 {
		font-size: 1.25em !important;
	}
}
/*画面遷移ボタン*/
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

	window.addEventListener('DOMContentLoaded', function() {
		const prefSelect = document.getElementById('pref');
		const citySelect = document.getElementById('city');
		const form = document.querySelector('form');
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
		form.addEventListener('submit',
				function(e) {
					let valid = true;
					const requiredIds = [ 'name', 'pref', 'city', 'birthdate',
							'email' ];
					requiredIds.forEach(function(id) {
						const elem = document.getElementById(id);
						if (!elem.value || (elem.disabled && id === 'city')) {
							elem.style.background = '#fff7e0';
							valid = false;
						} else {
							elem.style.background = '';
						}
					});
					if (!valid) {
						alert('全ての必須項目を入力してください。');
						e.preventDefault();
					}
					const birth = document.getElementById('birthdate').value;
					if (!/^\d{8}$/.test(birth)) {
						alert('生年月日は8桁の半角数字（例: 19600101）で入力してください。');
						document.getElementById('birthdate').focus();
						e.preventDefault();
					}
				});
	});
</script>
</head>
<body>
	<div class="sub-header">
		<h2>新規登録</h2>
	</div>
	<div class="container">
		<form
			action="${pageContext.request.contextPath}/OmoiyalinkUserRegistServlet"
			method="post" autocomplete="off">
			<c:if test="${not empty errorMessage}">
				<div class="error">${errorMessage}</div>
			</c:if>
			<label for="name">氏名</label> <input type="text" name="name" id="name"
				placeholder="ニックネームでも可" required> <label for="pref">都道府県</label>
			<select name="pref" id="pref" required>
				<option value="">都道府県を選択してください</option>
			</select> <label for="city">市区町村</label> <select name="city" id="city"
				required disabled>
				<option value="">市区町村で絞り込む</option>
			</select> <label for="birthdate">生年月日（例：19600101）</label> <input type="text"
				name="birthdate" id="birthdate" maxlength="8" pattern="\d{8}"
				required> <label for="email">メールアドレス</label> <input
				type="email" name="email" id="email" placeholder="example@email.com"
				required>
			<button type="submit">登録（メールを送信します）</button>
			<button type="button" class="seni" onclick="history.back();">登録をやめる</button>
		</form>
	</div>
	<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</body>
</html>
