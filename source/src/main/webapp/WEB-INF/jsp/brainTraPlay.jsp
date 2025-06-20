<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>後出しじゃんけん（60秒バトル）</title>
<style>
body {
	font-family: 'メイリオ', 'Meiryo', sans-serif;
	background: #f6fcff;
	color: #264;
	padding: 32px;
}

h1 {
	color: #2692c7;
	font-size: 2em;
}

.timer-box {
	font-size: 1.3em;
	margin: 12px 0 18px 0;
	color: #1993d1;
	font-weight: bold;
}

.cpu-box {
	font-size: 1.2em;
	margin: 17px 0 16px 0;
}

.janken-img {
	width: 110px;
	height: 110px;
	margin: 0 22px;
	border-radius: 12px;
	cursor: pointer;
	border: 2px solid #d1eaff;
	background: #fff;
	box-shadow: 0 2px 8px #bbd8;
}

.janken-img:hover {
	border-color: #67c1ff;
	box-shadow: 0 4px 14px #bce;
}

.score-box {
	margin: 18px 0;
	font-size: 1.15em;
	color: #196;
}

.result-msg {
	font-size: 1.13em;
	color: #c24b3b;
	font-weight: bold;
	margin: 13px 0 5px 0;
	height: 2em;
}

@media ( max-width :600px) {
	.janken-img {
		width: 70px;
		height: 70px;
		margin: 0 7px;
	}
}
</style>
</head>
<body>
	<h1>後出しじゃんけん</h1>
	<div class="timer-box">
		残り <span id="timer">60</span> 秒
	</div>
	<div class="score-box">
		現在の勝利数: <span id="winCount">0</span>
	</div>
	<div class="cpu-box">
		相手の手：<span id="cpuHand" style="font-size: 1.3em;">?</span>
	</div>
	<div class="result-msg" id="resultMsg"></div>
	<div style="text-align: center; margin-top: 24px;">
		<img src="<%=request.getContextPath()%>/img/janken_gu.png" alt="グー"
			class="janken-img" onclick="play('グー')"> <img
			src="<%=request.getContextPath()%>/img/janken_choki.png" alt="チョキ"
			class="janken-img" onclick="play('チョキ')"> <img
			src="<%=request.getContextPath()%>/img/janken_pa.png" alt="パー"
			class="janken-img" onclick="play('パー')">
	</div>
	<form id="resultForm"
		action="<%=request.getContextPath()%>/OmoiyalinkBrainTraResult"
		method="post" style="display: none;">
		<input type="hidden" name="winCount" id="formWinCount">
	</form>
<script>
const hands = ["グー", "チョキ", "パー"];
let time = 60;
let winCount = 0;

	alert('準備はよろしいでしょうか　\n※OKを押すとゲームが始まります'); {
}

// 開始時にCPUの手を表示
let cpuHand = randomHand();
document.getElementById("cpuHand").textContent = cpuHand;

const timer = setInterval(() => {
    time--;
    document.getElementById("timer").textContent = time;
    if (time === 0) {
        clearInterval(timer);
        endGame();
    }
}, 1000);

function randomHand() {
    return hands[Math.floor(Math.random() * hands.length)];
}

function play(userHand) {
    // すでにタイマーが切れていたら何もしない
    if (time <= 0) return;

    // 判定
    let result;
    if (isUserWin(userHand, cpuHand)) {
        result = "勝ち！";
        winCount++;
    } else if (userHand === cpuHand) {
        result = "あいこ";
    } else {
        result = "負け";
    }
    document.getElementById("resultMsg").textContent = "あなた: " + userHand + " ／ 相手: " + cpuHand + " → " + result;
    document.getElementById("winCount").textContent = winCount;

    // 新しいCPUの手を即表示
    cpuHand = randomHand();
    document.getElementById("cpuHand").textContent = cpuHand;
}

function isUserWin(user, cpu) {
    return (user === "グー" && cpu === "チョキ") ||
           (user === "チョキ" && cpu === "パー") ||
           (user === "パー" && cpu === "グー");
}

function endGame() {
    // 最終スコアをサーバーへPOST
    document.getElementById("formWinCount").value = winCount;
    document.getElementById("resultForm").submit();
}
</script>
</body>
</html>
