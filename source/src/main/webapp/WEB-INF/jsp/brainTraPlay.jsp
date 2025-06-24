<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>後出しじゃんけん（60秒バトル）</title>
<style>
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    background: #FFFEEF;  /* 背景色指定 */
    color: #22292F;       /* 薄めの黒（ややグレー系：#22292F）*/
    font-family: 'メイリオ', 'Meiryo', 'sans-serif';
    font-size: 17px;
    line-height: 1.8;
    background-image: url('<%=request.getContextPath()%>/img/R (1).jpg');
    background-position: center;
}

h1 {
	color:  #fff;;
	font-size: 2em;
	text-align: center;
	background:#46B1E1;
	margin-top: 0;
	
}

.timer-box {
	margin: 12px 0 18px 0;
	color: #fff;
	font-weight: bold;
	text-align: center;
	
}

.cpu-box {
	font-size: 1.2em;
	margin: 17px 0 16px 0;
	text-align: center;
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
	color: #fff;
	text-align: center;
}

.result-msg {
	font-size: 1.13em;
	color: #fff;
	font-weight: bold;
	margin: 13px 0 5px 0;
	height: 2em;
	text-align: center;
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
		
		<img id="cpuHandImg" src="<%=request.getContextPath()%>/img/question.png" alt="相手の手" style="height: 120px;">
	</div>

	<div class="result-msg" id="resultMsg"></div>

	<div style="text-align: center; margin-top: 24px;">
		<img src="<%=request.getContextPath()%>/img/janken_gu.png" alt="グー"
			class="janken-img" onclick="play('グー')"> 
		<img src="<%=request.getContextPath()%>/img/janken_choki.png" alt="チョキ"
			class="janken-img" onclick="play('チョキ')"> 
		<img src="<%=request.getContextPath()%>/img/janken_pa.png" alt="パー"
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

	if (!confirm('準備はよろしいでしょうか？\n※「OK」でゲーム開始、「キャンセル」で戻ります')) {
		// 戻る処理（前のページに戻る）
		history.back();
	}

	// CPUの手の初期表示
	let cpuHand = randomHand();
	updateCpuHandImage(cpuHand);

	// タイマー開始
	const timer = setInterval(() => {
		time--;
		document.getElementById("timer").textContent = time;
		if (time === 0) {  // >= を === に直す
			clearInterval(timer);
			endGame();
		}
	}, 1000);

	function randomHand() {
		return hands[Math.floor(Math.random() * hands.length)];
	}

	function updateCpuHandImage(hand) {
		const cpuHandImg = document.getElementById("cpuHandImg");
		const basePath = "<%=request.getContextPath()%>/img/";

		switch (hand) {
			case "グー":
				cpuHandImg.src = basePath + "janken_gu.png";
				break;
			case "チョキ":
				cpuHandImg.src = basePath + "janken_choki.png";
				break;
			case "パー":
				cpuHandImg.src = basePath + "janken_pa.png";
				break;
		}
	}

	function play(userHand) {
		if (time <= 0) return;

		let result;
		if (isUserWin(userHand, cpuHand)) {
			result = "勝ち！";
			winCount++;
			
			
		} else if (userHand === cpuHand) {
			result = "あいこ";
		} else {
			result = "負け";
		}

		document.getElementById("resultMsg").textContent =
			"あなた: " + userHand + " ／ 相手: " + cpuHand + " → " + result;

		document.getElementById("winCount").textContent = winCount;

		cpuHand = randomHand();
		updateCpuHandImage(cpuHand);
	}

	function isUserWin(user, cpu) {
		return (user === "グー" && cpu === "チョキ") ||
			(user === "チョキ" && cpu === "パー") ||
			(user === "パー" && cpu === "グー");
	}

	function endGame() {
		document.getElementById("formWinCount").value = winCount;
		document.getElementById("resultForm").submit();
	}
	</script>
</body>

</html>