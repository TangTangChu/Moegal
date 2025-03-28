import {snackbarshow} from '/static/js/public/snackbarshow.js';

const mtarget = document.getElementById('imgselector-mtarget');
const artc_title = document.getElementById('shareartc-card-title');
const isreprint = document.getElementById('shareartc-isreprint');
const lic = document.getElementById('share-bylic');
const btn_submit = document.getElementById('shareartc_submit');
const mdraw = document.querySelector('.markdowneditor .EV #rawmarkdown');

btn_submit.addEventListener('click',upartc);

function vcheck(){
    if(!artc_title.validity.valid){
        snackbarshow('请确认填写的信息！')
        return false;
    }
    if(mdraw.value.trim()===''){
        snackbarshow('文章内容不可为空');
        return false;
    }
    if(mtarget.value.trim()===''){
        snackbarshow('请选择封面');
        return false;
    }
    return true;
}

async function upartc(){
    if(vcheck()){
        btn_submit.setAttribute('disabled','');
        btn_submit.setAttribute('loading','');
        btn_submit.innerHTML='上传中';
        const sendData={
            'artc_title':artc_title.value,
            'artc_cover':mtarget.value,
            'artc_content':mdraw.value,
            'artc_isrep':isreprint.checked,
            'artc_bylic':lic.value
        }
        try{
            const resp = await fetch('/api/upload/article',{
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(sendData)
            });
            if(!resp.ok){
                throw new Error('むむむ...请求失败desu！(。>︿<)_θ 错误代码：'+resp.status+' 的说~');
            }
            const rdata = await resp.json();
            if(rdata.code == 200){
                snackbarshow(rdata.details);
                btn_submit.setAttribute('icon', 'check--outlined');
                btn_submit.removeAttribute('loading');
                setTimeout(()=>window.location.assign(`/article/show?aid=${rdata.aid}`),2000)
            }
            else{
                throw new Error(`提交失败:${rdata.details}`);
            }
        }
        catch(err){
            btn_submit.removeAttribute('disabled');
            btn_submit.removeAttribute('loading');
            btn_submit.innerHTML='上传失败';
            console.log(err);
            snackbarshow(err.message);
        }
    }
}