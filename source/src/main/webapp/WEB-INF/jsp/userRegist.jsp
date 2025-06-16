<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>新規登録</title>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body { font-family: sans-serif; padding: 2em; }
form { max-width: 600px; margin: 0 auto; }
label { display: block; margin: 1em 0 0.3em 0; }
input, select { width: 98%; padding: 0.5em; font-size: 1em; margin-bottom: 1em; }
button { padding: 0.6em 1.5em; font-size: 1em; margin-top: 0.5em; }
</style>
</head>
<body>
    <h1>新規登録</h1>
    <form action="UserRegistServlet" method="post">
        <label for="name">氏名</label>
        <input type="text" name="name" id="A2name" placeholder="ニックネームでも可" required>
        <label for="pref">都道府県</label>
        <select name="pref" id="pref"></select>
        <label for="city">市区町村</label>
        <select name="city" id="city">
            <option value="">市区町村で絞り込む</option>
        </select>
        <label for="birthdate">生年月日</label>
        <input type="number" name="birthdate" id="A2birth" placeholder="19600101" required>
        <label for="email">メールアドレス</label>
        <input type="email" name="email" id="A2mail" placeholder="example@email.com" required>
        <button type="submit" class="A2regibtn">登録（メールを送信します）</button>
        <button type="button" class="A2backbtn" onclick="history.back();">登録をやめる</button>
    </form>
</body>

<script>
// ▼都道府県・市区町村リスト
const PREF_CITY = {
    "都道府県を選択してください": ["市区町村で絞り込む"],
    "北海道": [
        "市区町村で絞り込む",
        "札幌市", "函館市", "小樽市", "旭川市", "室蘭市", "釧路市", "帯広市", "北見市", "夕張市", "岩見沢市",
        // ...（ここに北海道内の全市区町村を追加。今のところは一部のみ記載）
    ],
    "東京都": [
        "市区町村で絞り込む",
        "千代田区", "中央区", "港区", "新宿区", "文京区", "台東区", "墨田区", "江東区",
        "品川区", "目黒区", "大田区", "世田谷区", "渋谷区", "中野区", "杉並区", "豊島区",
        "北区", "荒川区", "板橋区", "練馬区", "足立区", "葛飾区", "江戸川区",
        "八王子市", "立川市", "武蔵野市", "三鷹市", "青梅市", "府中市", "昭島市", "調布市", "町田市", "小金井市",
        // ...（以下東京都下市町村）
    ],
    "大阪府": [
        "市区町村で絞り込む",
        "大阪市", "大阪市都島区", "大阪市福島区", "大阪市此花区", "大阪市西区", "大阪市港区", "大阪市大正区", "大阪市天王寺区",
        "大阪市浪速区", "大阪市西淀川区", "大阪市東淀川区", "大阪市東成区", "大阪市生野区", "大阪市旭区", "大阪市城東区",
        "大阪市阿倍野区", "大阪市住吉区", "大阪市東住吉区", "大阪市西成区", "大阪市淀川区", "大阪市鶴見区", "大阪市住之江区",
        "大阪市平野区", "大阪市北区", "大阪市中央区",
        "堺市", "堺市堺区", "堺市中区", "堺市東区", "堺市西区", "堺市南区", "堺市北区", "堺市美原区",
        // ...（以下大阪府下市町村）
    ],
    "愛知県": [
        "市区町村で絞り込む",
        "名古屋市", "名古屋市千種区", "名古屋市東区", "名古屋市北区", "名古屋市西区", "名古屋市中村区", "名古屋市中区",
        "名古屋市昭和区", "名古屋市瑞穂区", "名古屋市熱田区", "名古屋市中川区", "名古屋市港区", "名古屋市南区",
        "名古屋市守山区", "名古屋市緑区", "名古屋市名東区", "名古屋市天白区",
        "豊橋市", "岡崎市", "一宮市", "瀬戸市", "半田市", "春日井市", "豊川市",
        // ...（以下愛知県下市町村）
    ],
    "福岡県": [
        "市区町村で絞り込む",
        "北九州市", "北九州市門司区", "北九州市若松区", "北九州市戸畑区", "北九州市小倉北区", "北九州市小倉南区",
        "北九州市八幡東区", "北九州市八幡西区",
        "福岡市", "福岡市東区", "福岡市博多区", "福岡市中央区", "福岡市南区", "福岡市西区",
        "福岡市城南区", "福岡市早良区", "大牟田市", "久留米市", "直方市", "飯塚市", "田川市",
        // ...（以下福岡県下市町村）
    ],
    // ...（ここに他の都道府県も同じ形式で続けてください）
};

// ※サンプルのため5都道府県のみ記載。
// ▼本番は「PREF_CITY」部分に全都道府県データ（47都道府県分）を展開

$(function () {
    // 都道府県プルダウンを生成
    for (const pref in PREF_CITY) {
        $('#pref').append(`<option value="${pref}">${pref}</option>`);
    }
    $('#city').hide();

    // 都道府県選択時
    $('#pref').on('change', function () {
        const selectedPref = $(this).val();
        $('#city').empty();

        if (selectedPref && selectedPref !== "都道府県を選択してください") {
            const cities = PREF_CITY[selectedPref];
            for (const city of cities) {
                $('#city').append(`<option value="${city}">${city}</option>`);
            }
            $('#city').fadeIn();
        } else {
            $('#city').append('<option value="">市区町村で絞り込む</option>');
            $('#city').fadeOut();
        }
    });
});
</script>
</html>