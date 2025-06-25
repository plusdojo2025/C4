<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>薬の編集・削除</title>
<style>
form {
	max-width: 600px;
	margin: 0 auto;
}

label {
	display: block;
	margin-top: 1em;
}

input[type="text"], textarea {
	width: 100%;
	padding: 0.5em;
}

.checkbox-group {
	margin-top: 0.5em;
}

.checkbox-group label {
	display: inline-block;
	margin-right: 1em;
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
	text-align: center;
}

label, .label {
	color: #22292F;
	font-weight: bold;
}
/* レスポンシブ設計 */
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

#regist {
	text-align: center;
	font-size: 1.5rem;
	color: #FF6368;
}

input[name="delete"], input[name="submit"] {
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

.button-group {
	display: flex;
	gap: 10px;
}

.button-group form {
	margin: 0;
}
/* ナビゲーションボタン */
.button-nav {
	display: flex;
	justify-content: center;
	gap: 18px;
	margin: 24px 0 8px 0;
}

.button-nav a {
	background: #46B1E1;
	color: #fff;
	border-radius: 9px;
	padding: 0.65em 1.6em;
	font-size: 1em;
	text-decoration: none;
	transition: background 0.22s;
	display: inline-block;
}

.button-nav a:hover {
	background: #2d7ea3;
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

.sub-header {
	background-color: #46B1E1;
	color: #FFFEEF;
	padding: 15px 30px;
	margin-top: 0px !important;
}

.sub-header h2 {
	margin: 0;
	font-size: 2rem;
	text-align: center;
	color: #FFFEEF;
	background-color: #46B1E1;
}
</style>
</head>
<body>
	<header>
		<%@ include file="/WEB-INF/jsp/header.jsp"%>
	</header>


	<div class="sub-header">
		<h2>薬の編集・削除</h2>
	</div>
	<main>


		<div class="button-center">
			<a class="seni" href="${pageContext.request.contextPath}/OmoiyalinkMedRegist">薬を登録する</a>
			<a class="seni" href="${pageContext.request.contextPath}/OmoiyalinkTlkMedMng">飲んだ薬</a>
			<a class="seni" href="${pageContext.request.contextPath}/OmoiyalinkTlkMedRegist">薬を飲む</a>
		</div>

		<h2>登録されているお薬の一覧</h2>
		<c:forEach var="e" items="${cardList}">
			<form method="POST"
				action="${pageContext.request.contextPath}/OmoiyalinkMedMng"
				class="form-box" accept-charset="UTF-8">
				<input type="hidden" name="medicationId" value="${e.medicationId}">

				<label> 薬の正式名称 <input type="text" name="formalName"
					value="${e.formalName}" required>
				</label> <label> 薬の愛称 <input type="text" name="nickName"
					value="${e.nickname}">
				</label> <label> 服薬時間 <input type="time" name="intake_time"
					value="<c:out value='${fn:substring(e.intakeTime,0,5)}'/>">
				</label> <label> 用量 <input type="text" name="dosage"
					value="${e.dosage}">
				</label> <label> メモ <input type="text" name="memo" value="${e.memo}">
				</label>

				<div class="button-group">
					<input type="submit" name="submit" value="更新"> <input
						type="submit" name="submit" value="削除"
						style="background: #f4645f;">
				</div>
			</form>
		</c:forEach>
		<c:if test="${empty cardList}">
			<p>指定された条件に一致するデータはありません。</p>
		</c:if>
	</main>

	<footer>
		<%@ include file="/WEB-INF/jsp/footer.jsp"%>
	</footer>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
document.querySelectorAll('form.form-box').forEach(function(form) {
    form.onsubmit = function(event) {
        const formalName = form.formalName.value;
        const intake_time = form.intake_time.value;
        // 必須バリデーション
        if (formalName === '' || intake_time === '') {
            alert('薬の正式名称と服薬時間を入力してください');
            event.preventDefault();
            return;
        }

        // どのボタンで送信されたかを判定
        // "submitter"はイベント発火元（モダンブラウザで利用可）
        const btn = event.submitter;
        if (btn && btn.value === '削除') {
            if (!confirm('本当に削除しますか？')) {
                event.preventDefault();
            }
        } else if (btn && btn.value === '更新') {
            if (!confirm('本当に更新しますか？')) {
                event.preventDefault();
            }
        }
    }
});
</script>

</body>
</html>