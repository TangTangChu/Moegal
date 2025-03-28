import {snackbarshow} from '/static/js/public/snackbarshow.js';

const btn_logout = document.getElementById('btn_logout');
const t1 = document.getElementById('t1');
btn_logout.addEventListener('click', logoutnow);

async function logoutnow(){
    btn_logout.setAttribute('disabled','');
    btn_logout.setAttribute('loading','');
    try{
        const resp = await fetch('/api/account/logout',{
            method:'POST',
        });
        if(!resp.ok){
           throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
        }
        const rdata = await resp.json();
			console.log(rdata);
			if (rdata.code == 200) {
                t1.innerHTML=rdata.details;
                snackbarshow(rdata.details);
				btn_logout.setAttribute('icon', 'check--outlined');
                btn_logout.removeAttribute('loading');
				setTimeout(() => {
					window.location.assign('/login');
				}, 2000);
				return;
			} else {
				throw new Error('Error:'+rdata.details);
			}
    }
    catch(err){
        snackbarshow(err.message);
        console.error(err);
    }
    btn_logout.removeAttribute('loading');
    btn_logout.setAttribute('disabled','');
}