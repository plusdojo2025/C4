<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ選択画面</title>

<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    background: #FFFEEF;  /* 背景色指定 */
    color: #22292F;       /* 薄めの黒（ややグレー系：#22292F） */
    font-family: 'メイリオ', 'Meiryo', 'sans-serif';
    font-size: 17px;
    line-height: 1.8;
}

h1, h2, h3, h4, h5 {
    color: #fff;
    margin-top: 0;
    margin-bottom: .7em;
    font-weight: bold;
    background: #46B1E1;
}

button, .menu-btn {
	padding: 13px 32px;
	font-size: 1.1em;
	background: #47aaf2;
	color: #fff;
	border: none;
	border-radius: 9px;
	box-shadow: 0 2px 8px #ccd8f0;
	cursor: pointer;
	transition: background .2s;
	text-decoration: none;
	margin-bottom: 8px;
	text-align: center;
}

button:hover, .menu-btn:hover {
	background:#46B1E1;
}

.saveMsg {
	color: #c24b3b;
	font-size: 1.05em;
	margin-bottom: 8px;
}
</style>
</head>

<body>



	<h1>後出しじゃんけん</h1>

	<div class="rule">
		<h2>～ルール説明～</h2>
		<ul>
			<li>制限時間は1分間</li>
			<li>表示されている手に<strong>勝つ</strong>手を選ぼう！
			</li>
			<li>手を選択してじゃんけんに勝利を目指そう！</li>
		</ul>
	</div>

	<div class="buttons">
		<!-- POSTでaction="start" を送る -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
			method="post">
			<button type="submit" name="action" value="start">ゲーム開始</button>
		</form>
		<!-- POSTでaction="history" を送る -->
		<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra"
			method="post">
			<button type="submit" name="action" value="history">履歴閲覧</button>
		</form>
	</div>
</body>
</html>
