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

h1, h2 {
    color: #46B1E1;
    margin-top: 1em;
    margin-bottom: .7em;
    font-weight: bold;
}


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
