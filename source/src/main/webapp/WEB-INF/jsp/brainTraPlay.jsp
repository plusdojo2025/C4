<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>　ゲーム開始 </title>



</head>
<body>
<h1>後出しじゃんけん</h1>
<div>制限時間:<span id="timer">60</span>秒</div>


<form id ="handForm" action ="OmoiyalinkBrainTraPlay" method ="post">
	<input type="hidden" name="hand" id="handInput">
	
	<!-- 画像で手を選択する -->
	<img src="<%= request.getContextPath() %>/img/janken_gu.png" alt="グー" class="janken-img" onclick="submitHand('グー')">
	<img src="<%= request.getContextPath() %>/img/janken_choki.png" alt="チョキ" class="janken-img" onclick="submitHand('チョキ')">
	<img src="<%= request.getContextPath() %>/img/janken_pa.png" alt="パー" class="janken-img" onclick="submitHand('パー')">
	
</form>

<script>
	'use strict'
 	alert('準備はよろしいでしょうか　※OKを押すとゲームが始まります'); {
   }
 	<!--60秒タイマー -->	
	let time = 60;
	const timer = document.getElementById("timer");
	const interval = setInterval(() => {
	time--;
	timer.textContent = time;
	
	if (time === 0) {
		clearInterval (interval);
	
	//制限時間終了後、強制的にBrainTraResultに移行
	window.location.href = "<%= request.getContextPath() %>/OmoiyalinkBrainTraResult";
		}
	}, 1000);
	
	function submitHand(hand) {
		document.getElementById("handInput").value = hand;
		document.getElementById("handForm").submit();
	}

</script>
</body>
</html>