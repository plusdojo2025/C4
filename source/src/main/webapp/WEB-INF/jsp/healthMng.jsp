<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>体調記録一覧</title>
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

.table-scroll-x {
	width: 100%;
	overflow-x: auto;
}

table {
	width: 100%;
	min-width: 800px; /* 必要に応じて調整 */
	border-collapse: collapse;
}

th, td {
	padding: 0.7em 1em;
	text-align: center;
	border-bottom: 1px solid #a3cde2;
	white-space: nowrap;
}

thead {
	background: #eaf6fc;
}

.no-data {
	text-align: center;
	color: #aaa;
	font-style: italic;
}

/* ヘッダー・フッターサンプル 
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
*/
</style>
<script>
//common.js - 全ページ共通JS

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
	<%@ include file="/WEB-INF/jsp/header.jsp"%>
	<h2>体調記録一覧</h2>

	<div style="text-align: center; margin-top: 18px;">
		<a href="${pageContext.request.contextPath}/OmoiyalinkHealthRegist"
			class="btn" style="background: #A9C9E1;"> 体調登録に戻る </a>
	</div>


	<div class="paging">
		<c:if test="${hasPrev}">
			<a href="OmoiyalinkHealthMng?page=${page - 1}">&laquo; 前の10件</a>
		</c:if>
		<span>ページ：${page + 1}</span>
		<c:if test="${hasNext}">
			<a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件 &raquo;</a>
		</c:if>
	</div>
	<div class="table-scroll-x">
		<table>
			<thead>
				<tr>
					<th>記録日</th>
					<th>体温（℃）</th>
					<th>最高血圧</th>
					<th>最低血圧</th>
					<th>脈拍</th>
					<th>血中酸素</th>
					<th>睡眠休養感</th>
					<th>メモ</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty records}">
						<c:forEach var="rec" items="${records}">
							<tr>
								<td><c:out value="${rec.date}" /></td>
								<td><c:out value="${rec.temperature}" /></td>
								<td><c:choose>
										<c:when test="${rec.highBp != null}">
											<c:out value="${rec.highBp}" />
										</c:when>
										<c:otherwise>―</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${rec.lowBp != null}">
											<c:out value="${rec.lowBp}" />
										</c:when>
										<c:otherwise>―</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${rec.pulseRate != null}">
											<c:out value="${rec.pulseRate}" />
										</c:when>
										<c:otherwise>―</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${rec.pulseOx != null}">
											<c:out value="${rec.pulseOx}" />
										</c:when>
										<c:otherwise>―</c:otherwise>
									</c:choose></td>
								<td><c:out value="${rec.sleep}" /></td>
								<td><c:out value="${rec.memo}" /></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="no-data" colspan="8">体調記録がありません。</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>

	<div class="paging">
		<c:if test="${hasPrev}">
			<a href="OmoiyalinkHealthMng?page=${page - 1}">&laquo; 前の10件</a>
		</c:if>
		<span>ページ：${page + 1}</span>
		<c:if test="${hasNext}">
			<a href="OmoiyalinkHealthMng?page=${page + 1}">次の10件 &raquo;</a>
		</c:if>
	</div>
	<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</body>
</html>
