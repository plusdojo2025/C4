<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>脳トレ選択画面</title>
</head>
<body>
 <h1>後だしじゃんけん</h1>

  <h2>～ルール説明～</h2>
    <p>制限時間は1分間</p>
    <P>表示されている手に勝つ</P>
    <p>手を選択してじゃんけんに勝とう!</p>

<form method = "post" action = "brainTra">
	<button type = "submit" name ="action" value = "start">ゲーム開始</button>
	<button type = "submit" name ="action" value = "history">閲覧履歴</button>
</form>
</body>
</html>