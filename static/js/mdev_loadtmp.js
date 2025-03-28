import {snackbarshow} from '/static/js/public/snackbarshow.js';

const btn_load = document.getElementById('mdev-load-tmp');
const sel_tmpl = document.getElementById('mdev-select-tmp');
const mdev_editor = document.querySelector('.markdowneditor .EV #editor');

btn_load.addEventListener('click',async ()=>{
    btn_load.setAttribute('disabled','');
    btn_load.setAttribute('loading','');
    try{
        let targeturl='';
        if(!sel_tmpl.value){
            throw new Error('没有选择模板哦~');
        }
        if(sel_tmpl.value==1){
            targeturl = '/static/md/public/gal.md';
        }
        const resp = await fetch(targeturl);
        if(!resp.ok){
            throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
        }
        const md = await resp.text();
        mdev_editor.innerHTML=md;
        snackbarshow('加载好了~只要随机修改一下文本就能触发渲染啦~');
    }
    catch(err){
        snackbarshow(err.message);
        console(err);
    }
    finally{
        btn_load.removeAttribute('disabled');
        btn_load.removeAttribute('loading');
    }
});