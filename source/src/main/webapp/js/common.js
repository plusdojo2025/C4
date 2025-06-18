// common.js - 全ページ共通JS

/** ----------- ローディング表示制御 ----------- **/
function showLoading(message = '読み込み中…') {
    let loader = document.getElementById('global-loading');
    if (!loader) {
        loader = document.createElement('div');
        loader.id = 'global-loading';
        loader.innerHTML = `
            <div class="loader-bg"></div>
            <div class="loader-inner">
                <div class="loader-spinner"></div>
                <div class="loader-msg">${message}</div>
            </div>`;
        document.body.appendChild(loader);
    }
    loader.style.display = 'flex';
}
function hideLoading() {
    const loader = document.getElementById('global-loading');
    if (loader) loader.style.display = 'none';
}

/** ----------- 画面遷移アニメーション ----------- **/
window.addEventListener('DOMContentLoaded', () => {
    document.body.classList.add('fadein');
});
window.addEventListener('beforeunload', () => {
    document.body.classList.remove('fadein');
    document.body.classList.add('fadeout');
});

/** ----------- モーダル表示 ----------- **/
function showModal(message, onClose) {
    let modal = document.getElementById('global-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'global-modal';
        modal.innerHTML = `
            <div class="modal-overlay"></div>
            <div class="modal-content">
                <div class="modal-message"></div>
                <button class="modal-close-btn">閉じる</button>
            </div>`;
        document.body.appendChild(modal);
        modal.querySelector('.modal-close-btn').onclick = function() {
            modal.style.display = 'none';
            if (onClose) onClose();
        };
        modal.querySelector('.modal-overlay').onclick = function() {
            modal.style.display = 'none';
            if (onClose) onClose();
        };
    }
    modal.querySelector('.modal-message').innerText = message;
    modal.style.display = 'flex';
}

/** ----------- 共通アラート（fadeIn/out） ----------- **/
function showAlert(message, type = 'error', duration = 2200) {
    let alertBar = document.getElementById('global-alert');
    if (!alertBar) {
        alertBar = document.createElement('div');
        alertBar.id = 'global-alert';
        document.body.appendChild(alertBar);
    }
    alertBar.textContent = message;
    alertBar.className = 'show ' + type;
    setTimeout(() => { alertBar.classList.remove('show'); }, duration);
}

/** ----------- エラーメッセージ統一 ----------- **/
function showFormError(targetId, message) {
    let errSpan = document.getElementById(targetId + '-err');
    if (!errSpan) {
        const input = document.getElementById(targetId);
        errSpan = document.createElement('span');
        errSpan.className = 'form-error';
        errSpan.id = targetId + '-err';
        input.parentNode.insertBefore(errSpan, input.nextSibling);
    }
    errSpan.textContent = message;
    errSpan.style.display = 'inline';
    setTimeout(() => { errSpan.style.display = 'none'; }, 3200);
}

/** ----------- 全角→半角自動変換 ----------- **/
function toHalfWidth(str) {
    return str.replace(/[！-～]/g, ch =>
        String.fromCharCode(ch.charCodeAt(0) - 0xFEE0)
    ).replace(/　/g, " ");
}
function autoHalfWidthInput(selector) {
    document.querySelectorAll(selector).forEach(input => {
        input.addEventListener('blur', function () {
            this.value = toHalfWidth(this.value);
        });
    });
}
// 例: autoHalfWidthInput('input[data-halfwidth]');

/** ----------- 日付・時間フォーマット ----------- **/
function formatDate(date, delimiter = '-') {
    const d = new Date(date);
    const y = d.getFullYear();
    const m = ('0' + (d.getMonth() + 1)).slice(-2);
    const day = ('0' + d.getDate()).slice(-2);
    return `${y}${delimiter}${m}${delimiter}${day}`;
}
function formatTime(date) {
    const d = new Date(date);
    const h = ('0' + d.getHours()).slice(-2);
    const mi = ('0' + d.getMinutes()).slice(-2);
    return `${h}:${mi}`;
}

/* 追加で必要なものは随時このcommon.jsに追記してください */
