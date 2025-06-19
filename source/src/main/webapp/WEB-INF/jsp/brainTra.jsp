<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ選択画面</title>
<style>
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
