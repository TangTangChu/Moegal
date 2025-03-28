import {snackbarshow} from '/static/js/public/snackbarshow.js';

const comment= document.getElementById('comment-text');
const btn_comment = document.getElementById('submitcomment');

btn_comment.addEventListener('click',commentnow);

async function commentnow(){
    if(comment.value.trim()==''){
        snackbarshow('不可以发布空评论哦~！');
        return;
    }
    btn_comment.setAttribute('disabled','');
    btn_comment.setAttribute('loading','');
    const fd = new FormData();
    fd.append('comment',comment.value);
    fd.append('aid',document.getElementById('aid').value);
    console.log('1');
    try{
        const resp = await fetch('/api/article/comment',{
            'method':'POST',
            'body':fd
        });
        if(!resp.ok){
            throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
        }
        const rdata = await resp.json();
        if(rdata.code===200){
            snackbarshow(rdata.details);
            comment.value='';
        }
        else{
            throw new Error(rdata.details);
        }
    }
    catch(err){
        snackbarshow(err.message);
        console.log(err);
    }
    finally{
        btn_comment.removeAttribute('disabled');
        btn_comment.removeAttribute('loading');
    }
}