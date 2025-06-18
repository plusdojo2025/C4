<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>新規登録</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    body { font-family: sans-serif; padding: 2em; }
    form { max-width: 600px; margin: 0 auto; }
    label { display: block; margin: 1em 0 0.3em 0; }
    input, select { width: 98%; padding: 0.5em; font-size: 1em; margin-bottom: 1em; }
    button { padding: 0.6em 1.5em; font-size: 1em; margin-top: 0.5em; }
    select, option { color: #222 !important; background: #fff !important; }
    .error { color: #c00; margin-bottom: 1em; }
  </style>
</head>
<body>
  <h1>新規登録</h1>
  <form action="OmoiyalinkUserRegistServlet" method="post" autocomplete="off">
    <c:if test="${not empty errorMessage}">
      <div class="error">${errorMessage}</div>
    </c:if>

    <label for="name">氏名</label>
    <input type="text" name="name" id="name" placeholder="ニックネームでも可" required>

    <label for="pref">都道府県</label>
    <select name="pref" id="pref" required>
      <option value="">都道府県を選択してください</option>
    </select>

    <label for="city">市区町村</label>
    <select name="city" id="city" required disabled>
      <option value="">市区町村で絞り込む</option>
    </select>

    <label for="birthdate">生年月日（例：19600101）</label>
    <input type="text" name="birthdate" id="birthdate" maxlength="8" pattern="\d{8}" required>

    <label for="email">メールアドレス</label>
    <input type="email" name="email" id="email" placeholder="example@email.com" required>

    <button type="submit">登録（メールを送信します）</button>
    <button type="button" onclick="history.back();">登録をやめる</button>
  </form>

  <script>
    // jQuery不要で書く場合（純粋なJSだけでもOK）
    const PREF_CITY = {
      "北海道": ["札幌市", "函館市", "小樽市"],
      "青森県": ["青森市", "弘前市", "八戸市"],
      "岩手県": ["盛岡市", "宮古市", "大船渡市"],
      "宮城県": ["仙台市", "石巻市", "塩竈市"],
      "秋田県": ["秋田市", "能代市", "横手市"],
      "東京都": ["千代田区", "中央区", "港区", "新宿区", "世田谷区"]
      // ...必要に応じて追加
    };

    const prefSelect = document.getElementById('pref');
    const citySelect = document.getElementById('city');

    // ページロード時に都道府県追加
    window.addEventListener('DOMContentLoaded', function() {
      for (const pref of Object.keys(PREF_CITY)) {
        const option = document.createElement('option');
        option.value = pref;
        option.textContent = pref;
        prefSelect.appendChild(option);
      }
    });

    prefSelect.addEventListener('change', function() {
      const selectedPref = this.value;
      // リセット
      citySelect.innerHTML = '<option value="">市区町村で絞り込む</option>';
      if (PREF_CITY[selectedPref]) {
        citySelect.disabled = false;
        for (const city of PREF_CITY[selectedPref]) {
          const option = document.createElement('option');
          option.value = city;
          option.textContent = city;
          citySelect.appendChild(option);
        }
      } else {
        citySelect.disabled = true;
      }
    });
  </script>
</body>
</html>
