const imgpix = document.getElementById('imgpix');
const imgview = document.getElementById('imgview');
const btn_del = document.getElementById('btn_del');
const dialog_del = document.querySelector('#dialog-del');
const dialog_del_confirm = document.querySelector('#dialog-del #del-confirm');
const dialog_del_cancel = document.querySelector('#dialog-del #del-cancel');
import {snackbarshow} from '/static/js/public/snackbarshow.js';
imgview.addEventListener('load',calpix);
btn_del.addEventListener('click',()=>{
    dialog_del.open = true;
});
dialog_del_confirm.addEventListener('click',delimg);
dialog_del_cancel.addEventListener('click',()=>{dialog_del.open=false});
function calpix(){
    imgpix.innerHTML=`${imgview.naturalWidth} × ${imgview.naturalHeight} px`;
}
if(imgview.complete){
    calpix();
}   

async function delimg(){
    dialog_del.open=false;
    btn_del.setAttribute('diabled','');
    btn_del.setAttribute('loading','');
    try{
        const fd = new FormData();
        fd.append('iid',document.getElementById('IID').innerHTML);
        const resp = await fetch('/api/image/delimage',{
            'method':'POST',
            'body':fd
        });
        if(!resp.ok){
           throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
        }
        const rdata = await resp.json();
			console.log(rdata);
			if (rdata.code == 200) {
                snackbarshow(rdata.details);
				btn_del.setAttribute('icon', 'check--outlined');
                btn_del.removeAttribute('loading');
				setTimeout(() => {
					window.location.assign('/imgstn');
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
    btn_del.removeAttribute('loading');
    btn_del.removeAttribute('disabled');
}

