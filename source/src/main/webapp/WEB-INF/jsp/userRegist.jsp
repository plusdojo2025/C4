<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>新規登録</title>
<style>
/* === ページ全体ベース === */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	background: #FFFEEF; /* 背景色指定 */
	color: #22292F; /* 薄めの黒（ややグレー系：#22292F） */
	font-family: 'メイリオ', 'Meiryo', 'sans-serif';
	font-size: 17px;
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
}

/* === レスポンシブ設計 === */
@media ( max-width : 600px) {
	html, body {
		font-size: 15px;
		padding: 0;
	}
	.container, .login-container, .form-box {
		max-width: 99vw;
		padding: 6vw 2vw;
		box-sizing: border-box;
	}
	input, select, button, textarea {
		font-size: 1em !important;
	}
	h1, h2 {
		font-size: 1.25em !important;
	}
}

/* === 共通UI部品 === */

/* ローディングUI */
#global-loading {
	display: none;
	position: fixed;
	z-index: 10000;
	left: 0;
	top: 0;
	width: 100vw;
	height: 100vh;
	background: rgba(255, 254, 239, 0.96);
	align-items: center;
	justify-content: center;
	flex-direction: column;
}

.loader-bg {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background: rgba(70, 177, 225, 0.07);
}

.loader-inner {
	position: relative;
	z-index: 1;
	text-align: center;
}

.loader-spinner {
	width: 52px;
	height: 52px;
	border: 7px solid #f3f3f3;
	border-top: 7px solid #46B1E1;
	border-radius: 50%;
	animation: spin 0.8s linear infinite;
	margin: 0 auto 18px;
}

@
keyframes spin { 100% {
	transform: rotate(360deg);
}

}
.loader-msg {
	color: #46B1E1;
	font-size: 1.1em;
}

/* 画面フェードイン・アウト */
body.fadein {
	animation: fadeIn 0.7s both;
}

body.fadeout {
	animation: fadeOut 0.5s both;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes fadeOut {from { opacity:1;
	
}

to {
	opacity: 0;
}

}

/* モーダル */
#global-modal {
	display: none;
	position: fixed;
	z-index: 9999;
	left: 0;
	top: 0;
	width: 100vw;
	height: 100vh;
	align-items: center;
	justify-content: center;
}

#global-modal .modal-overlay {
	position: absolute;
	left: 0;
	top: 0;
	width: 100vw;
	height: 100vh;
	background: rgba(70, 177, 225, 0.14);
}

#global-modal .modal-content {
	position: relative;
	background: #fff;
	color: #46B1E1;
	border-radius: 12px;
	padding: 36px 28px 24px;
	min-width: 260px;
	box-shadow: 0 4px 24px #e6f6fd;
}

#global-modal .modal-message {
	font-size: 1.15em;
	margin-bottom: 24px;
}

#global-modal .modal-close-btn {
	background: #46B1E1;
	color: #fff;
	border: none;
	border-radius: 8px;
	padding: 0.6em 1.7em;
	cursor: pointer;
}

/* 共通アラート */
#global-alert {
	position: fixed;
	top: 30px;
	left: 50%;
	transform: translateX(-50%);
	min-width: 170px;
	max-width: 90vw;
	z-index: 1999;
	background: #46B1E1;
	color: #fff;
	padding: 10px 22px;
	border-radius: 10px;
	box-shadow: 0 2px 16px #d3ebf7;
	opacity: 0;
	pointer-events: none;
	transition: opacity 0.3s;
	font-size: 1em;
}

#global-alert.show {
	opacity: 1;
	pointer-events: auto;
}

#global-alert.error {
	background: #ec8888;
	color: #fff;
}

#global-alert.info {
	background: #46B1E1;
	color: #fff;
}

#global-alert.success {
	background: #78c677;
	color: #fff;
}

/* フォームエラー */
.form-error {
	color: #ec8888;
	font-size: 0.95em;
	margin-left: 7px;
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

/* コンテナ */
.container, .login-container, .form-box {
	max-width: 450px;
	margin: 50px auto;
	background: #fff;
	border-radius: 18px;
	box-shadow: 0 2px 18px #eef1f4;
	padding: 34px 18px 44px 18px;
}

/* 入力フォーム */
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

/* ヘッダー・フッターサンプル */
header, .site-header {
	width: 100vw;
	background: #fff;
	border-bottom: 2px solid #46B1E1;
	padding: 14px 0 8px 0;
	color: #46B1E1;
	font-weight: bold;
	letter-spacing: 1.2px;
	text-align: center;
	font-size: 1.6em;
}

footer, .site-footer {
	width: 100vw;
	background: #fff;
	border-top: 1px solid #46B1E1;
	color: #22292F;
	text-align: center;
	padding: 12px 0 8px 0;
	font-size: 0.98em;
	margin-top: 40px;
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

		// 都道府県プルダウン初期化
		for ( const pref in PREF_CITY) {
			const option = document.createElement('option');
			option.value = pref;
			option.textContent = pref;
			prefSelect.appendChild(option);
		}

		// 都道府県選択時の市区町村プルダウン切り替え
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

		// 必須バリデーション（全項目入力チェック & 生年月日8桁チェック）
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
					// 生年月日8桁バリデーション
					const birth = document.getElementById('birthdate').value;
					if (!/^\d{8}$/.test(birth)) {
						alert('生年月日は8桁の半角数字（例: 19600101）で入力してください。');
						document.getElementById('birthdate').focus();
						e.preventDefault();
					}
				});
	});
	
	// common.js - 全ページ共通JS

	/** ----------- ローディング表示制御 ----------- **/
	function showLoading(message = '読み込み中…') {
	    let loader = document.getElementById('global-loading');
	    if (!loader) {
	        loader = document.createElement('div');
	        loader.id = 'global-loading';
	        loader.innerHTML = `
	            <div class="loader-bg"></div>
	            <div class="loader-inner">
	                <div class="loader-spinner"></div>
	                <div class="loader-msg">${message}</div>
	            </div>`;
	        document.body.appendChild(loader);
	    }
	    loader.style.display = 'flex';
	}
	function hideLoading() {
	    const loader = document.getElementById('global-loading');
	    if (loader) loader.style.display = 'none';
	}

	/** ----------- 画面遷移アニメーション ----------- **/
	window.addEventListener('DOMContentLoaded', () => {
	    document.body.classList.add('fadein');
	});
	window.addEventListener('beforeunload', () => {
	    document.body.classList.remove('fadein');
	    document.body.classList.add('fadeout');
	});

	/** ----------- モーダル表示 ----------- **/
	function showModal(message, onClose) {
	    let modal = document.getElementById('global-modal');
	    if (!modal) {
	        modal = document.createElement('div');
	        modal.id = 'global-modal';
	        modal.innerHTML = `
	            <div class="modal-overlay"></div>
	            <div class="modal-content">
	                <div class="modal-message"></div>
	                <button class="modal-close-btn">閉じる</button>
	            </div>`;
	        document.body.appendChild(modal);
	        modal.querySelector('.modal-close-btn').onclick = function() {
	            modal.style.display = 'none';
	            if (onClose) onClose();
	        };
	        modal.querySelector('.modal-overlay').onclick = function() {
	            modal.style.display = 'none';
	            if (onClose) onClose();
	        };
	    }
	    modal.querySelector('.modal-message').innerText = message;
	    modal.style.display = 'flex';
	}

	/** ----------- 共通アラート（fadeIn/out） ----------- **/
	function showAlert(message, type = 'error', duration = 2200) {
	    let alertBar = document.getElementById('global-alert');
	    if (!alertBar) {
	        alertBar = document.createElement('div');
	        alertBar.id = 'global-alert';
	        document.body.appendChild(alertBar);
	    }
	    alertBar.textContent = message;
	    alertBar.className = 'show ' + type;
	    setTimeout(() => { alertBar.classList.remove('show'); }, duration);
	}

	/** ----------- エラーメッセージ統一 ----------- **/
	function showFormError(targetId, message) {
	    let errSpan = document.getElementById(targetId + '-err');
	    if (!errSpan) {
	        const input = document.getElementById(targetId);
	        errSpan = document.createElement('span');
	        errSpan.className = 'form-error';
	        errSpan.id = targetId + '-err';
	        input.parentNode.insertBefore(errSpan, input.nextSibling);
	    }
	    errSpan.textContent = message;
	    errSpan.style.display = 'inline';
	    setTimeout(() => { errSpan.style.display = 'none'; }, 3200);
	}

	/** ----------- 全角→半角自動変換 ----------- **/
	function toHalfWidth(str) {
	    return str.replace(/[！-～]/g, ch =>
	        String.fromCharCode(ch.charCodeAt(0) - 0xFEE0)
	    ).replace(/　/g, " ");
	}
	function autoHalfWidthInput(selector) {
	    document.querySelectorAll(selector).forEach(input => {
	        input.addEventListener('blur', function () {
	            this.value = toHalfWidth(this.value);
	        });
	    });
	}
	// 例: autoHalfWidthInput('input[data-halfwidth]');

	/** ----------- 日付・時間フォーマット ----------- **/
	function formatDate(date, delimiter = '-') {
	    const d = new Date(date);
	    const y = d.getFullYear();
	    const m = ('0' + (d.getMonth() + 1)).slice(-2);
	    const day = ('0' + d.getDate()).slice(-2);
	    return `${y}${delimiter}${m}${delimiter}${day}`;
	}
	function formatTime(date) {
	    const d = new Date(date);
	    const h = ('0' + d.getHours()).slice(-2);
	    const mi = ('0' + d.getMinutes()).slice(-2);
	    return `${h}:${mi}`;
	}

	/* 追加で必要なものは随時このcommon.jsに追記してください */

</script>

</head>
<body>
	<div class="container">
		<h1>新規登録</h1>
		<form
			action="${pageContext.request.contextPath}/OmoiyalinkUserRegistServlet"
			method="post" autocomplete="off">
			<c:if test="${not empty errorMessage}">
				<div class="error">${errorMessage}</div>
			</c:if>
			<!-- 入力欄ここから -->
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
			<button type="button" onclick="history.back();">登録をやめる</button>
		</form>
	</div>

<%@ include file="/WEB-INF/jsp/footer.jsp" %> 

</body>
</html>
