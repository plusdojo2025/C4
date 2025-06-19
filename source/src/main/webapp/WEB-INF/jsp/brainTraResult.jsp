<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>脳トレ結果発表</title>
</head>
<body>
<h1>結果</h1>

<h2>勝利回数：<%=request.getAttribute("winCount") %>　回</h2>


<div class="buttons">
<form action ="<%=request.getContextPath() %>/OmoiyalinkBrainTraPlay" method="get">
	<button type="submit">ゲーム実施へ戻る</button>
</form>	

<form action ="<%=request.getContextPath() %>/OmoiyalinkBrainTraMng" method="get">
	<button type="submit">履歴閲覧</button>
</form>	
</div>

</body>
</html>