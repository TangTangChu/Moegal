import {snackbarshow} from '/static/js/public/snackbarshow.js';
import { hex_md5 } from '/static/js/public/md5.js';
const btnReg = document.getElementById('btn_reg');
btnReg.addEventListener('click', reg);

const email = document.getElementById('emailvalue');
const nickname = document.getElementById('nicknamevalue');
const passwd1 = document.getElementById('passwdvalue');
const passwd2 = document.getElementById('passwdvalue2');

function setButtonState(disabled, loading) {
    if (disabled) btnReg.setAttribute('disabled', '');
    else btnReg.removeAttribute('disabled');
    if (loading) btnReg.setAttribute('loading', '');
    else btnReg.removeAttribute('loading');
}

function validateInput() {
    if (!email.validity.valid || !nickname.validity.valid || !passwd1.validity.valid || !passwd2.validity.valid) {
        snackbarshow('呜~请检查填写的文本！');
        return false;
    }

    if (nickname.value.trim() === '') {
        snackbarshow('昵称不可为空的啦！');
        return false;
    }

    if (passwd1.value !== passwd2.value) {
        snackbarshow('两次密码不一致！＞︿＜');
        return false;
    }
    return true;
}

async function reg() {
    setButtonState(true, true); 

    if (!validateInput()) {
        setButtonState(false, false); 
        return;
    }

    const sendData = {
        'email': email.value,
        'nickname': nickname.value,
        'passwd': hex_md5(passwd2.value) 
    };

    try {
        const resp = await fetch('/api/account/reg', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(sendData)
        });

        if (!resp.ok) {
            throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
        }
        const rdata = await resp.json();
        if (rdata.code == 200) {
            snackbarshow(rdata.details);
            btnReg.setAttribute('icon', 'check--outlined');
            setTimeout(() => window.location.assign('/login'), 3000);
        } else {
            throw new Error('注册失败：'+rdata.details);
        }
    } catch (err) {
        snackbarshow(err.message)
        console.error(err.message);
    } finally {
        setButtonState(false, false); 
    }
}