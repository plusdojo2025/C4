<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>脳トレ選択画面</title>

<style>
/*画面遷移ボタン*/
.seni {
	display: inline-block;
	background: #A9C9E1;
	color: #22292F;
	text-decoration: none;
	border-radius: 9px;
	padding: 0.6em 1.7em;
	margin-bottom: 22px;
	margin-top: 8px;
	font-size: 1em;
	font-weight: bold;
	transition: background 0.2s;
	text-decoration: none !important;
}
.seni:hover {
	background: #7BA9C9;
	color: #fff;
	text-decoration: none !important;
}
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
    background-image: url('<%=request.getContextPath()%>/img/360_F_967425218_ZMkPYJQqHSUylEN5pCCCxWCN4D1QOhZM.jpg');
    background-position: center;
    }


h1 {
    color: #fff;
    margin-top: 0;
    margin-bottom: .7em;
    font-weight: bold;
    background: #46B1E1;
    text-align: center;
}

h2 {
    color: #fff;
    margin-top: 0;
    margin-bottom:30px;
    font-weight: bold;
    text-align: center;
    
}

h3 {
    color: #fff;
    margin-top: 0;
    margin-bottom:30px;
    font-weight: bold;
    text-align: center;
    
}
button, .menu-btn {
	padding: 13px 32px;
	font-size: 1.1em;
	background: #47aaf2;
	color: #fff;
	border: none;
	border-radius: 9px;
	box-shadow: 0 2px 8px #ccd8f0;
	cursor: pointer;
	transition: background .2s;
	text-decoration: none;
	margin-bottom: 0px;
	
}
button:hover, .menu-btn:hover {
	background:#46B1E1;
}

.saveMsg {
	color: #c24b3b;
	font-size: 1.05em;
	margin-bottom: 5px;
}

.container {
	text-align: center;
	margin-top: 40px;
}

.rule ul {
	list-style: none;
	padding: 0;
	margin: 0 auto;
	margin-left: 95px;
	display: inline-block;
	text-align: center; 
	background-image:;
	margin-top: 0px;
}
.rule ul li {
    color: white;
    font-weight: bold;
    font-size:18px;
}

.buttons {
	display: flex;
	justify-content: center;
	gap: 30px;
	margin-top: 80px;
}

.red {
	color:red;
	font-weight:bold;
}
</style>
</head>

<body>



	<h1>脳トレ</h1>

	<div class="rule">
		<h2>後だしじゃんけん</h2>
		<h3>―　ルール説明　―</h3>
		
		
		<ul>
			<li>制限時間は1分間</li>
			<li>表示されている手に<strong class="red">勝つ</strong>手を選ぼう！
			</li>
			<li>手を選択してじゃんけんに勝利を目指そう！</li>
		</ul>
	</div>

	<div class="buttons">
	<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra" method="post">
		<button class="seni" type="submit" name="action" value="start">ゲーム開始</button>
	</form>
	<form action="<%=request.getContextPath()%>/OmoiyalinkBrainTra" method="post">
		<button class="seni" type="submit" name="action" value="history">履歴閲覧</button>
	</form>
	</div>
	
</body>
</html>
