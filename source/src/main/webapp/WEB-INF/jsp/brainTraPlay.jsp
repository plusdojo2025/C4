<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>　ゲーム開始 </title>

<script>

function submitHand(hand) {
	document.getElementById("handInput").value = hand;
	document.getElementById("handForm").submit;
}
</script>

</head>
<body>
<h1>後出しじゃんけん</h1>
<div>制限時間:<span id="timer">60</span>秒</div>


<form id ="handForm" action ="BrainTraServlet" method ="post">
	<input type="hidden" name="hand" id=""handInput>
	
	<!-- 画像で手を選択する -->
	<img src= alt="グー">
	<img src= alt="チョキ">
	<img src= alt="パー">
</form>

<script>
	'use strict'
 	alert('準備はよろしいでしょうか'); {
   }
 	<!--60秒タイマー -->	
	let time = 60;
	const timer = document.getElementById("timer");
	const interval = setInterval(() => {
	time--;
	timer.textContent = time;
	if (time <= 0) clearInterval (interval);
	}, 1000);

</script>
</body>
</html>