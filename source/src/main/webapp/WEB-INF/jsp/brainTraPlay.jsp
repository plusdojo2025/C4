<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>後出しじゃんけん（ゲーム開始）</title>
<style>
body {
	background: #f6fcff;
	font-family: 'メイリオ', 'Meiryo', sans-serif;
	color: #264;
	padding: 32px;
}

h1 {
	font-size: 2em;
	color: #2692c7;
	margin-bottom: 14px;
}

.timer-box {
	font-size: 1.3em;
	background: #fff;
	padding: 12px 23px;
	border-radius: 11px;
	display: inline-block;
	margin-bottom: 20px;
	border: 2px solid #c1e7ff;
	color: #0a5d89;
	font-weight: bold;
}

.janken-select {
	margin: 28px 0;
	text-align: center;
}

.janken-img {
	width: 110px;
	height: 110px;
	margin: 0 24px;
	border-radius: 15px;
	box-shadow: 0 1px 8px #bce;
	cursor: pointer;
	background: #fff;
	transition: box-shadow 0.2s, transform 0.2s;
	border: 2px solid #d1eaff;
}

.janken-img:hover {
	box-shadow: 0 4px 16px #b3dbff;
	transform: scale(1.07);
	border-color: #67c1ff;
}

@media ( max-width : 600px) {
	.janken-img {
		width: 70px;
		height: 70px;
		margin: 0 7px;
	}
	.timer-box {
		font-size: 1.1em;
	}
}
</style>
</head>
<body>
	<h1>後出しじゃんけん</h1>
	<div class="timer-box">
		制限時間：<span id="timer">60</span>秒
	</div>

	<form id="handForm"
		action="<%=request.getContextPath()%>/OmoiyalinkBrainTraPlay"
		method="post">
		<input type="hidden" name="hand" id="handInput" />
		<div class="janken-select">
			<img src="<%=request.getContextPath()%>/img/janken_gu.png" alt="グー"
				class="janken-img" onclick="submitHand('グー')"> <img
				src="<%=request.getContextPath()%>/img/janken_choki.png" alt="チョキ"
				class="janken-img" onclick="submitHand('チョキ')"> <img
				src="<%=request.getContextPath()%>/img/janken_pa.png" alt="パー"
				class="janken-img" onclick="submitHand('パー')">
		</div>
	</form>

	<script>
    'use strict';
    // ゲーム開始前の注意
    window.onload = function() {
        setTimeout(function(){
            alert('準備はよろしいでしょうか？\n※OKを押すとゲームが始まります');
        }, 200);
    };

    // 60秒タイマー
    let time = 60;
    const timer = document.getElementById("timer");
    const interval = setInterval(() => {
        time--;
        timer.textContent = time;
        if (time === 0) {
            clearInterval(interval);
            // 制限時間終了後、自動で結果画面へ
            window.location.href = "<%=request.getContextPath()%>/OmoiyalinkBrainTraResult";
        }
    }, 1000);

    // 手の選択→フォーム送信
    function submitHand(hand) {
        document.getElementById("handInput").value = hand;
        document.getElementById("handForm").submit();
    }
    </script>
</body>
</html>
