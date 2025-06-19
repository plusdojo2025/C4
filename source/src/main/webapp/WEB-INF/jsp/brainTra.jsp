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

<div class="buttons">
<form action ="<%=request.getContextPath() %>/OmoiyalinkBrainTraPlay" method="get">
	<button type="submit">ゲーム開始</button>
</form>	

<form action ="<%=request.getContextPath() %>/OmoiyalinkBrainTraMng" method="get">
	<button type="submit">履歴閲覧</button>
</form>	
</div>
</body>
</html>