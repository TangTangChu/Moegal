import {snackbarshow} from '/static/js/public/snackbarshow.js';
const btnlogin = document.getElementById('btn_login');
const user = document.getElementById('uservalue');
const passwd = document.getElementById('passwdvalue');

btnlogin.addEventListener('click', loginnow);
user.addEventListener('keydown',(event)=>{
    if(event.key=='Enter'){
        passwd.focus();
    }
});
passwd.addEventListener('keydown',(event)=>{
    if(event.key=='Enter'){
        loginnow();
    }
});

function vcheck(){
    if (user.value.trim() === '' || passwd.value.trim() === '') {
        snackbarshow('账户或用户名不可为空！');
        return false;
    }
    return true;
}

async function loginnow() {
    btnlogin.setAttribute('loading', '');
    btnlogin.setAttribute('disabled', '');

    if (vcheck()) {
        const data = { 'user':user.value.trim(), 'passwd':passwd.value.trim() }; 
        console.log(JSON.stringify(data));

        try {
            const resp = await fetch('/api/account/login', {
                'method': 'POST',
                'headers': { 'Content-Type': 'application/json' },
                'body': JSON.stringify(data)
            });

            if (!resp.ok) {
                throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
            }

            const rdata = await resp.json();
            console.log(rdata);

            if (rdata.code == 200) {
                btnlogin.setAttribute('icon', 'check--outlined');
                btnlogin.removeAttribute('loading');
                snackbarshow(rdata.details);
                setTimeout(() => {
                    let redirecturl = getQueryVariable('redirect');
                    window.location.assign(redirecturl);
                }, 2000);
                return;
            } else {
                throw new Error('登录失败:'+rdata.details);
            }
        } catch (err) {
            snackbarshow(err.message)
            console.error(err);
            resetButtonState();
        }
    }
    resetButtonState();
}

function resetButtonState() {
    btnlogin.removeAttribute('disabled');
    btnlogin.removeAttribute('loading');
}

function getQueryVariable(variable)
{
    var query = window.location.search.substring(1);
    var vars = query.split('&');
    for (var i=0;i<vars.length;i++) {
        var pair = vars[i].split('=');
        if(pair[0] == variable){return pair[1];}
    }
    return('/user');
}